<template>
  <div class="activity-cont">
    <!-- 倒计时开始活动 -->
    <div class="countdown-mask" v-show="countdownFlag">
      <div class="countdown-cont">
        <img class="countdown-title" src="../../assets/detail/pic-countdown.png" alt="">
        <img class="countdown-num" :src="require(`../../assets/detail/icon-${countdownIndex}.png`)" alt="">
      </div>
    </div>

    <!-- 活动剩余时间 -->
    <div class="remainder" v-show="!countdownFlag">
      <h1>剩余时间</h1>
      <p>{{ remainderTime }}<span>s</span></p>
    </div>

    <!-- 红包雨 -->
    <div class="game-cont" v-if="!countdownFlag" ref="gameCont">
      <div class="envelope-item" 
        v-for="item in gameList" 
        :key="item.id" 
        @click="receiveFun(item, $event)"
        :style="{
          left: item.left,
          transform: `scale(${item.scale}) rotate(${item.rotate}deg)`
        }"
        ></div>
    </div>
  </div>
</template>

<script lang="ts">
import axios from 'axios';
import { Vue, Prop, Component } from 'vue-property-decorator';
import { Toast } from 'vant';

@Component
export default class Activity extends Vue {
  userInfo: any = {} // 用户信息
  countdownFlag = false
  countdownTime: any = null
  countdownIndex = 1
  gameList: any = []
  currIndex = 1 // 红包id
  remainderTime = 0 // 活动剩余时间
  time: any = null
  @Prop() readonly remainder: any;


  mounted() {
    this.getUserInfo()
  }

  beforeDestroy(){
    // 组件销毁清空定时器
    clearInterval(this.countdownTime)
    this.countdownTime = null
    clearInterval(this.time)
    this.time = null
  }

  // 
  getUserInfo () {
    axios
      .get(
        `/user/info`,
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          // 用户已登录
          const { data } = res.data
          this.userInfo = data

          if (!localStorage.getItem(`${data.id}-${this.$route.query.id}`)) {
            // 倒计时
            this.countdownFun()
            // 保存用户不是初次进入标识
            localStorage.setItem(`${data.id}-${this.$route.query.id}`, 'true')
          } else {
            // 红包雨
            this.gameFun()
          }

        } else { 
          // 未登录，跳转登录
          this.$router.push({
            name: 'login'
          })
        }
      })
  }

  // 红包雨
  gameFun(){
    // 活动倒计时开始
    this.getActivityTime(this.remainder)

    // 添加红包
    this.countdownTime = setInterval(()=>{
      const delId = this.currIndex
      // 创建红包
      let item = {
        id: this.currIndex,
        rotate: Math.floor(Math.random() * 100 - 50), // 倾斜角度
        left: Math.floor(Math.random() * 600) / 75 + 'rem', // 定位
        scale: Math.random() * 0.65 + 0.65
      }
      // 放进红包数组
      this.gameList.push(item)

      // 两秒后销毁（下落动画2s）
      setTimeout(()=>{
        this.gameList = this.gameList.filter((v1: any) => {
          return v1.id !== delId
        })
      }, 2000)

      this.currIndex++
    }, 400)
  }


  // 活动结束倒计时  num剩余的毫秒数
  getActivityTime(num: number){
    this.remainderTime = Math.ceil(num / 1000)
    this.time = setInterval(()=>{
      this.remainderTime--

      // 倒计时为0时，活动结束
      if(this.remainderTime === 0){
        clearInterval(this.countdownTime)
        this.countdownTime = null
        clearInterval(this.time)
        this.time = null
        // 触发活动结束事件
        this.$emit('activityEndFun')
      }
    }, 1000)
  }

  // 领取奖品
  receiveFun(item: any, event: any){
    axios
      .get(
        `act/go/${this.$route.query.id}`,
      )
      .then((res: any) => {
        const { data, code, msg } = res.data
        if (code === 1) {
          // 用户已登录， 且中奖
          this.hasPrizeFun(data, event.target, true)
          this.gameList = this.gameList.filter((v1: any) => {
            return v1.id !== item.id
          })
        } else if (code === 0){
          // 未中奖
          this.hasPrizeFun(data, event.target, false)
          this.gameList = this.gameList.filter((v1: any) => {
            return v1.id !== item.id
          })
        } else { 
          // 其他情况，toast提示
          Toast(msg);
        }
      })
  }

  // 是否中奖
  hasPrizeFun(data: any, receiveDom: any, flag: boolean){
    receiveDom.style.animation = ''
    const gameCont = document.getElementsByClassName('game-cont')[0]
    const newDom = document.createElement("div")
    if(flag){
      newDom.className = 'receive-tips'
      newDom.innerHTML = data.name
    } else {
      newDom.className = 'receive-tips not-receive-tips'
      newDom.innerHTML = ''
    }
    newDom.style.top = receiveDom.offsetTop + 'px'
    newDom.style.left = receiveDom.offsetLeft + 'px'
    gameCont.appendChild(newDom)

    setTimeout(()=>{
      gameCont.removeChild(newDom)
    }, 1000)

  }


  // 倒计时逻辑
  countdownFun(){
    
    if(this.countdownIndex == 4){
      setTimeout(()=>{
        this.countdownTime = null
        this.countdownFlag = false
        this.gameFun()
      },1000)
    }else{
      this.countdownFlag = true
      setTimeout(()=>{
        this.countdownIndex++
        this.countdownFun()
      }, 1000)
    }
  }
}
</script>

<style lang="scss" scoped>
.activity-cont{
  .countdown-mask{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 100%;
    background-color: rgba(0, 0, 0, .6);
    z-index: 1;
    .countdown-cont{
      position: absolute;
      top: 50%;
      left: 0;
      height: calc(288px + 143px + 205px);
      transform: translateY(-50%);
      text-align: center;
      .countdown-title{
        width: 638px;
        height: 288px;
        margin-bottom: 148px;
      }
      .countdown-num{
        width: 205px;
        height: 205px;
      }
    }
  }

  .remainder{
    position: fixed;
    top: 185px; 
    left: 0;
    width: 100%;
    h1{
      font-family: SourceHanSansCN-Medium;
      font-size: 60px;
      font-weight: normal;
      font-stretch: normal;
      line-height: 60px;
      letter-spacing: 3px;
      color: #ffeddb;
      text-align: center;
    }
    p{
      margin-top: 20px;
      font-family: SourceHanSansCN-Heavy;
      font-size: 96px;
      font-weight: normal;
      font-stretch: normal;
      line-height: 96px;
      letter-spacing: 0px;
      color: #ffeddb;
      text-align: center;
      span{
        font-size: 66px;
      }
    }
  }
  
  .game-cont{
    position: fixed;
    width: 100%;
    height: 100%;
    top:0;
    left:0;
    z-index: 2;
    .envelope-item{
      width: 123px;
      height: 163px;
      position: absolute;
      z-index: 2;
      top: 10;
      animation-name: move;
      animation-timing-function: ease-out;
      animation-duration: 2.5s;
      animation-fill-mode: forwards;
      
      background-image: url(../../assets/detail/icon-prize.png);
      background-size: 100% 100%;
    }

    @keyframes move {
      0%{
        top: 0;
      }
      100%{
        top: 110%;
      }
    }

    ::v-deep {
      .receive-tips{
        position: absolute;
        z-index: 1;
        animation-name: receivetTips;
        animation-timing-function: ease-out;
        animation-duration: 1s;
        animation-fill-mode: forwards;
        font-family: SourceHanSansCN-Bold;
        font-size: 32px;
        font-weight: normal;
        font-stretch: normal;
        line-height: 32px;
        letter-spacing: 0px;
        color: #fff2e5;
        width: 260px;
        height: 80px;
        padding: 23px 51px 0 17px;
        box-sizing: border-box;
        background-image: url(../../assets/detail/receice-tips.png);
        background-size: 100% 100%;
        text-align: center;
        text-overflow:ellipsis;  
        overflow: hidden;  
        white-space: nowrap;
      }

      .not-receive-tips{
        width: 272px;
        height: 58px;
        background-image: url(../../assets/detail/not-receice-tips.png);
      }
    }

    @keyframes receivetTips {
      0%{
        opacity: 1;
        transform: translateY(0px);
      }
      100%{
        opacity: 0;
        transform: translateY(-30px);
      }
    }
  }
}
</style>