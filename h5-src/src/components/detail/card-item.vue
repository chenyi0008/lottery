<template>
  <div class="card-item" @click="toDetail">
    <div class="card-banner">
      <img :src="imgPath + item.pic">
      <div class="card-status" :class="{active: currStatus === 1}" v-show="showTips">{{ statusList[currStatus] }}</div>
      <div class="card-remainder" v-if="remainder">还剩 {{ remainder }}秒</div>
    </div>
    <div class="card-cont">
      <h4>{{ item.title }}</h4>
      <p>{{ item.info }}</p>
      <div class="">
        <i></i>
        <span>{{ item.startTimeStr }}</span>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Vue, Prop, Component } from 'vue-property-decorator';
import moment from 'moment'

@Component
export default class CardItem extends Vue {
  imgPath:string = process.env.VUE_APP_PATH
  statusList = ['未开始', '进行中', '已结束']
  currStatus = 2 // 0-未开始 1-进行中 2-已结束
  showTips = false
  remainder = 0
  time: any = null
  @Prop() readonly item!: any;


  mounted(){
    let currTime = new Date().getTime()
    let startTime = new Date(this.item.starttime).getTime()
    let endTime = new Date(this.item.endtime).getTime()
    // 开始时间格式化
    this.item.startTimeStr = moment(this.item.starttime).format('YYYY-MM-DD HH:mm:ss')
    if (currTime >= startTime && currTime < endTime) {
      this.currStatus = 1
      this.getAdTime(endTime - currTime)
    }else if (currTime < startTime){
      this.currStatus = 0
    }else if (currTime >= endTime){
      this.currStatus = 2
    }
    this.showTips = true
  }

  beforeDestroy(){
    // 组件销毁清空定时器
    clearTimeout(this.time)
    this.time = null
  }
  
  // 跳转活动详情
  toDetail () {
    this.$router.push({
      name: 'detail',
      query: {
        id: this.item.id
      }
    })
  }

  // 活动结束倒计时  num剩余的毫秒数
  getAdTime(num: number){
    this.remainder = Math.ceil(num / 1000)
    this.time = setInterval(()=>{
      this.remainder--
    }, 1000)
  }
}
</script>
<style lang="scss" scoped>

.card-item{
  margin-top: 24px;
  background-color: #fff;
  border-radius: 12px;
  overflow: hidden;
  .card-banner{
    position: relative;
    img{
      width: 100%;
      height: 340px;
    }
    .card-status{
      position: absolute;
      top: 0;
      right: 0;
      width: 110px;
      height: 48px;
      border-radius: 0 12px 0 12px;
      text-align: center;
      line-height: 48px;
      font-size: 28px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #FFFFFF;
      background-color: #9C8686;
      &.active{
        background-color: #EF6458;
      }
    }

    .card-remainder{
      position: absolute;
      bottom: 12px;
      left: 32px;
      padding: 4px 12px;
      background-color: rgba(29, 33, 41, .6);
      font-size: 24px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #FFFFFF;
      line-height: 40px;
    }
  }
  .card-cont{
    padding: 24px 32px;
    h4{
      font-size: 32px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #1D2129;
      line-height: 48px;
      text-overflow:ellipsis;  
      overflow: hidden;  
      white-space: nowrap;
    }
    p{
      margin-top: 8px;
      font-size: 28px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #4E5969;
      line-height: 44px;
      text-overflow:ellipsis;  
      overflow: hidden;  
      white-space: nowrap;
    }
    div{
      display: flex;
      align-items: center;
      margin-top: 8px;
      i{
        width: 24px;
        height: 24px;
        background-image: url(../../assets/detail/icon-time.svg);
        margin-right: 12px;
      }
      span{
        font-size: 24px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #86909C;
        line-height: 40px;
      }
    }
  }
}

</style>