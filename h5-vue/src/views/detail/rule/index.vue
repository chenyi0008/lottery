<template>
  <div class="rule-page" v-show="loadFlag">
    <GoBack />
    <div class="rule-title"></div>
    <div class="rule-cont">

      <div class="cont-modal prize-list">
        <div class="modal-title">劲爆大奖</div>
        <div class="modal-cont-mask">
          <div class="my-swiper" v-if="productsList && productsList.length > 0 && loadFlag">
            <swiper :options="swiperOption" ref="mySwiper" class="swiperitems" >
              <swiper-slide
                class="swiperwrap"
                v-for="(item, index) in productsList"
                :key="index"
              >
                <ul class="slide-box">
                  <li v-for="v1 in item" :key="v1.id">
                    <img :src="imgPath + v1.pic" alt="" />
                    <p>{{ v1.name }}</p>
                  </li>
                </ul>
                <div class="card">
                </div>
              </swiper-slide>
            </swiper>
            <div class="swiper-pagination"></div>
          </div>
          <div class="default-page" v-else-if="loadFlag">
            <p>暂无数据</p>
          </div>
        </div>
      </div>

      <div class="cont-modal avtivity-rule">
        <div class="modal-title">活动规则</div>
        <div class="modal-cont-mask">
          <div class="rule-item">
            <h4>1、抽奖时间</h4>
            <p v-html="lotteryTime"></p>
          </div>
          <div class="rule-item">
            <h4>2、抽奖规则</h4>
            <p>中奖结果以系统显示为准；<br/>非本集团员工不得参与本次活动。</p>
          </div>
        </div>
      </div>

      <div class="cont-modal winning-list-box">
        <div class="modal-title">中奖名单</div>
        <div class="modal-cont-mask">
          <ul class="winning-list" v-if="winningList && winningList.length > 0 && loadFlag">
            <li v-for="item in winningList" :key="item.id">
              <span>恭喜{{ item.uname }}</span>
              <span>抢到 {{ item.name}}</span>
            </li>
          </ul>
          <div class="default-page" v-else-if="loadFlag">
            <p>暂无数据</p>
          </div>
        </div>
      </div>
    </div>
    
  </div>
</template>

<script lang="ts">
import axios from 'axios';
import { Vue, Component } from 'vue-property-decorator';
import GoBack from '@/components/layout/GoBack.vue'
import { swiper, swiperSlide } from "vue-awesome-swiper";
import "swiper/dist/css/swiper.css";
import moment from 'moment'

@Component({
  components: {
    GoBack,
    swiper,
    swiperSlide
  }
})
export default class Rule extends Vue {
  imgPath: string = process.env.VUE_APP_PATH
  loadFlag = false
  lotteryTime = '' // 抽奖时间
  info: any = {} // 活动信息
  currId = this.$route.query.id // 活动id
  productsList: any = [] // 奖品列表
  winningList: any = [] // 中奖名单
  swiperOption:any = {
    autoplay: true,
    slidesPerView: "auto",
    spaceBetween: 20,
    centeredSlides: true,
    pagination: {
      el: ".swiper-pagination",
    },
  }

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
          if( data.status === 1 ){
            if( currTime >= startTime && currTime < endTime )
            data.status = 2
          }
          
          const strDay = new Date(data.starttime.slice(0, 11)).getTime()
          const endDay = new Date(data.endtime.slice(0, 11)).getTime()
          const startStr = moment(data.starttime).format('YYYY年MM月DD日 HH:mm:ss')
          if (strDay === endDay) {
            // 活动是同一天， 显示  YYYY年MM月DD日 HH:mm:ss ~ HH:mm:ss
            const endStr = moment(data.endtime).format('HH:mm:ss')
            this.lotteryTime = `${startStr} ~ ${endStr}`
          } else {
            // 活动跨天， 显示  YYYY年MM月DD日 HH:mm:ss 至 YYYY年MM月DD日 HH:mm:ss
            const endStr = moment(data.endtime).format('YYYY年MM月DD日 HH:mm:ss')
            this.lotteryTime = `${startStr} 至<br/> ${endStr}`
          }

          this.info = data
          this.getProductsList()
          this.getWinningList()
        }
      })
  }

  // 获取奖品列表
  getProductsList () {
    axios
      .get(`/game/products/${this.currId}`)
      .then((res: any) => {
        if(res.data.code === 1){
          const { data } = res.data
          const arr = []
          if(data && data.length > 0){
            let chunk = 4
            for (var i = 0, j = data.length; i < j; i += chunk) {
              arr.push(data.slice(i, i + chunk))
            }
          }
          this.productsList = arr
          this.loadFlag = true
        }
      })
  }

  // 获取中奖名单
  getWinningList () {
    axios
      .get(`game/hit/${this.currId}/1/30`)
      .then((res: any) => {
        if(res.data.code === 1){
          this.winningList = res.data.data.items
          this.loadFlag = true
        }
      })
  }
}
</script>

<style lang="scss" scoped>
.rule-page{
  position: relative;
  min-height: 100%;
  background: linear-gradient(180deg, rgba(255,83,43, 1) 0%, #ffbf80 50%);
  padding-top: 103px;
  padding-bottom: 60px;
  box-sizing: border-box;
  .rule-title{
    width: 410px;
    height: 107px;
    background-image: url(../../../assets/detail/pic-rule-title.png);
    background-size: 100% 100%;
    margin: 0 auto;
  }
  .rule-cont{
    margin-top: 68px;
    width: 690px;
    margin: 60px auto 0;
    .cont-modal{
      position: relative;
      background-color: #ff532b;
      border-radius: 40px;
      padding-top: 96px;
      box-sizing: border-box;
      box-shadow: inset 0px 0px 25px rgba(255, 255, 255, .6);
      .modal-title{
        width: 396px;
        height: 108px;
        background-image: url(../../../assets/user/pic-title-bg.png);
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

      .modal-cont-mask{
        width: 650px;
        margin: 0 auto;
        background-color: #ffeddb;
        border-radius: 20px;
        padding: 30px;
        box-sizing: border-box;
        overflow: hidden;
      }

      // 劲爆大奖
      &.prize-list{
        padding-bottom: 20px;
        .modal-cont-mask{
          .my-swiper{
            position: relative;
            .swiper-pagination {
              display: flex;
              align-items: center;
              position: absolute;
              left: 50%;
              bottom: 0px;
              transform: translate(-50%, 0px);
              height: 6px;
              transform: translate(-50%, 0px);
              background: rgba(249,72,35, 0.5);
              border-radius: 4px;
            }

            /deep/ .swiper-pagination-bullet {
              width: 50px;
              height: 8px;
              background: transparent;
              border-radius: 4px;
            }

            /deep/.swiper-pagination-bullet.swiper-pagination-bullet-active {
              width: 50px;
              height: 8px;
              background: #f94823;
              border-radius: 4px;
            }
          }
          .slide-box{
            display: flex;
            justify-content: space-between;
            flex-wrap:wrap;
            li{
              width: 280px;
              margin-bottom: 40px;
              img{
                width: 280px;
                height: 280px;
                background-color: #ffeddb;
                border-radius: 10px;
                border: solid 2px #f94823;
                box-sizing: border-box;
              }
              p{
                margin-top: 18px;
                width: 280px;
                text-align: center;
                font-family: SourceHanSansCN-Normal;
                font-size: 26px;
                font-weight: normal;
                font-stretch: normal;
                line-height: 30px;
                letter-spacing: 0px;
                color: #0f0301;
                text-overflow:ellipsis;  
                overflow: hidden;  
                white-space: nowrap;
              }
            }
          }
        }
      }

      // 活动规则
      &.avtivity-rule{
        margin-top: 57px;
        padding-bottom: 20px;
        .modal-cont-mask{
          padding: 50px 0 50 40px;
          .rule-item{
            margin-top: 28px;
            &:first-child{
              margin-top: 0;
            }
            h4{
              font-family: SourceHanSansCN-Medium;
              font-size: 30px;
              font-weight: normal;
              font-stretch: normal;
              line-height: 30px;
              letter-spacing: 0px;
              color: #f94823;
              margin-bottom: 11px;
            }
            p{
              line-height: 48px;
              padding-left: 45px;
            }
          }
        }
      }

      // 中奖名单
      &.winning-list-box{
        height: 861px;
        margin-top: 57px;
        .modal-cont-mask{
          height: 744px;
          padding: 50px;
          .winning-list{
            width: 650px;
            height: 100%;
            padding-right: 100px;
            overflow-y: auto;
            box-sizing: border-box;
            overflow-x: hidden;
            li{
              width: 550px;
              max-width: 550px;
              display: flex;
              align-items: center;
              margin-top: 40px;
              &:first-child{
                margin: 0;
              }
              span{
                font-family: SourceHanSansCN-Normal;
                font-size: 30px;
                font-weight: normal;
                font-stretch: normal;
                letter-spacing: 0px;
                color: #0f0301;
                text-overflow:ellipsis;  
                overflow: hidden;  
                white-space: nowrap;
                &:first-child{
                  width: 180px;
                  margin-right: 20px;
                }
                &:last-child{
                  color: #f94823;
                }
              }
            }
          }
        }
      }
    }
  }


  // 缺省
  .default-page{
    width: 100%;
    height: 100%;
    position: relative;
    min-height: 300px;
    p{
      width: 100%;
      position: absolute;
      top: 50%;
      transform: translateY(-50%);
      text-align: center;
      box-sizing: border-box;
      font-size: 44px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #ff2b39;
      line-height: 44px;
    }
  }
}
</style>