<template>
  <main class="detail-page">
    <GoBack />
    <!-- 红包雨活动 -->
    <Activity v-if="info.status === 2" :remainder="remainder" @activityEndFun="activityEndFun"/>
    <!-- 活动未开始 -->
    <div class="status-mask" v-if="info.status === 0">
      <div class="card-box not-start">
        <img src="../../assets/detail/pic-not-start.png" alt="">
        <p>开始时间</p>
        <p>{{ info.startTimeStr }}</p>
      </div>
    </div>
    <!-- 活动已结束 -->
    <div class="status-mask" v-if="info.status === 1">
      <div class="card-box ended">
        <img src="../../assets/detail/pic-ended.png" alt="">
        <p>活动已结束</p>
      </div>
    </div>

    <!-- 我的商品、活动规则 -->
    <div class="right-float">
      <p v-if="info.status === 2" @click="openMyPrizeFun">我的奖品</p>
      <p @click="toRule">活动规则</p>
    </div>


    <!-- 底部云朵、钱袋 -->
    <div class="page-footer" :class="info.status === 1 || info.status === 2 ? 'ended' : 'not-start'"></div>

    <!-- 我的商品 -->
    <div class="my-prize-mask" v-show="myPrizeFlag">
      <div class="my-prize-cont">
        <div class="popup-title">我的奖品</div>
        <i class="popup-close" @click="myPrizeFlag = false"></i>
        <div class="popup-cont-mask">
          <ul class="prize-list" v-if="myPrizeList && myPrizeList.length > 0">
            <li v-for="item in myPrizeList" :key="item.id">
              <span>{{ item.name || '-' }}</span>
              <span>{{ item.hittime ? item.hittime.slice(0, 11) : '-' }}</span>
            </li>
          </ul>
          <div class="default-page" v-else>
            <p>很遗憾，您未中奖</p>
          </div>
        </div>
      </div>
    </div>
  </main>
</template>

<script lang="ts">
import axios from 'axios';
import { Component, Vue } from 'vue-property-decorator';
import Activity from '@/components/detail/activity.vue'
import GoBack from '@/components/layout/GoBack.vue'
import moment from 'moment'

@Component({
  components: {
    Activity,
    GoBack
  }
})
export default class Detail extends Vue {
  
  info: any = {} // info.status 0-未开始 1-已结束 2-进行中
  currId = this.$route.query.id // 活动id
  myPrizeFlag = false
  myPrizeList: any = [] // 我的奖品
  remainder = 0

  mounted(){
    if (this.currId) {
      this.getGameInfo()
    } else {
      this.$router.push('/')
    }
  }

  // 获取活动详情
  getGameInfo () {
    axios
      .get(`/game/info/${this.currId}`)
      .then((res: any) => {
        if (res.data.code === 1) {
          const { data, now } = res.data
          const currTime = new Date(now).getTime()
          const startTime = new Date(data.starttime).getTime()
          const endTime = new Date(data.endtime).getTime()
          this.remainder = endTime - currTime
          if( data.status === 1 ){
            if( currTime >= startTime && currTime < endTime )
            data.status = 2
          }
          data.startTimeStr = moment(data.starttime).format('YYYY年MM月DD日 HH:mm:ss')
          this.info = data
        }
      })
  }

  // 打开我的商品
  openMyPrizeFun () {
    this.myPrizeFlag = true
    axios
      .get(
        `/user/hit/-1/1/100`,
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          const { data } = res.data
          if(data.totalNum && data.items.length > 0){
            // 接口数据处理，倒序显示最新奖品
            this.myPrizeList = data.items
          }
        }
      })
  }

  // 活动规则
  toRule (){
    this.$router.push({
      name: 'rule',
      query: {
        id: this.currId
      }
    })
  }

  // 活动结束回调
  activityEndFun (){
    this.info.status = 1
  }
}
</script>
<style lang="scss" scoped>
.detail-page{
  height: 100%;
  background-image: url(../../assets/detail/detail-bg.png);
  background-size: 100% auto;
  background-repeat: no-repeat;
  background-color: #ffeed5;
  position: relative;
  
  .status-mask{
    width: 100%;
    height: 100%;
    position: fixed;
    z-index:2;
    top: 0;
    left: 0;
    background-color: rgba(0, 0, 0, .6);
    .card-box{
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      width: 560px;
      height: 560px;
      background-color: #fff4eb;
      border-radius: 50px;
      box-sizing: border-box;
      text-align: center;
      p{
        font-family: SourceHanSansCN-Medium;
        font-weight: normal;
        font-stretch: normal;
        line-height: 46px;
        letter-spacing: 0px;
        color: #ff2b39;
      }
      &.not-start{
        padding-top: 103px;
        img{
          width: 271px;
          transform: translateX(8.5px);
          margin-bottom: 61px;
        }
        p{
          font-size: 36px;
        }
      }
      &.ended{
        padding-top: 86px;
        img{
          width: 291px;
          transform: translateX(18.5px);
          margin-bottom: 70px;
        }
        p{
          font-family: SourceHanSansCN-Heavy;
          font-size: 44px;
          font-weight: 600;
        }
      }
    }
  }

  .right-float{
    position: fixed;
    right: 0;
    bottom: 371px;
    width: 200px;
    z-index: 3;
    p{
      width: 200px;
      height: 72px;
      text-align: center;
      background-color: #f94823;
      border-radius: 36px 0px 0px 36px;
      margin-top: 32px;
      font-family: SourceHanSansCN-Heavy;
      font-size: 32px;
      font-weight: normal;
      font-stretch: normal;
      line-height: 72px;
      letter-spacing: 2px;
      color: #ffeddb;
    }
  }

  .page-footer{
    position: fixed;
    z-index:1;
    bottom: 0;
    left: 0;
    width: 100%;
    height: 852px;
    background-size: 100% 100%;
    &.not-start{
      background-image: url(../../assets/detail/pic-purse-1.png);
    }

    &.ended{
      background-image: url(../../assets/detail/pic-purse-2.png);
    } 
  }

  .my-prize-mask{
    position: fixed;
    top: 0;
    left: 0;
    background-color: rgba(0,0,0,.6);
    width: 100%;
    height: 100%;
    z-index: 3;
    .my-prize-cont{
      width: 650px;
      height: 629px;
      background-color: #f94823;
      border-radius: 40px;
      position: absolute;
      top: 50%;
      left: 50%;
      transform: translate(-50%, -50%);
      padding-top: 97px;
      box-sizing: border-box;
      box-shadow: inset 0px 0px 25px rgba(255, 255, 255, .6);
      .popup-title{
        width: 396px;
        height: 108px;
        background-image: url(../../assets/user/pic-title-bg.png);
        background-size: 100% 100%;
        position: absolute;
        top: -22px;
        left: 50%;
        transform: translateX(-50%);
        text-align: center;
        padding-top: 28px;
        box-sizing: border-box;
        font-size: 40px;
        font-family: PingFangSC-Medium, PingFang SC;
        font-weight: 500;
        color: #ff2b39;
        line-height: 44px;
      }
      .popup-close{
        position: absolute;
        bottom: -89px;
        left: 50%;
        transform: translateX(-50%);
        width: 50px;
        height: 50px;
        background-image: url(../../assets/common/icon-close.png);
        background-size: 100% 100%;
      }

      .popup-cont-mask{
        width: 611px;
        height: 511px;
        background-color: #ffeddb;
        border-radius: 20px;
        margin: 0 auto;
        overflow: hidden;
        padding: 48px 30px;
        box-sizing: border-box;
        .prize-list{
          width: 631px;
          height: 100%;
          padding-right: 50px;
          overflow-y: auto;
          box-sizing: border-box;
          overflow-x: hidden;
          li{
            width: 551px;
            max-width: 551px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            margin-top: 40px;
            box-sizing: border-box;
            &:first-child{
              margin: 0;
            }
            span{
              font-size: 30px;
              font-weight: normal;
              font-stretch: normal;
              line-height: 34px;
              letter-spacing: 0px;
              color: #0f0301;
              text-overflow:ellipsis;  
              overflow: hidden;  
              white-space: nowrap;
              &:nth-of-type(1){
                width: 190px;
                color: #f94823;
              }
              &:nth-of-type(2){
                width: 180px;
                text-align: right;
              }
            }
          }
        }

        .default-page{
          width: 100%;
          height: 100%;
          position: relative;
          p{
            width: 100%;
            position: absolute;
            top: 50%;
            transform: translateY(-50%);
            text-align: center;
            box-sizing: border-box;
            font-size: 40px;
            font-family: PingFangSC-Medium, PingFang SC;
            font-weight: 500;
            color: #f94823;
            line-height: 48px;
          }
        }
      }
    }
  }
}

</style>
