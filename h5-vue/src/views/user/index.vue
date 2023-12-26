<template>
  <div class="user-page" v-show="loadFlag">
    <div class="page-cont">
      <GoBack />
      <main>
        <div class="user-info" >
          <img :src="userInfo.pic" alt="">
          <h2>{{ userInfo.uname }}</h2>
          <p>{{ userInfo.phone }}</p>
        </div>
        <ul class="ad-info">
          <li>
            <img src="../../assets/user/icon-01.png" alt="">
            <div class="info-text">
              <p>{{ userInfo.games || 0 }}</p>
              <span>参与活动</span>
            </div>
          </li>
          <li>
            <img src="../../assets/user/icon-02.png" alt="">
            <div class="info-text">
              <p>{{ userInfo.products || 0 }}</p>
              <span>中奖记录</span>
            </div>
          </li>
        </ul>
        <div class="my-prize">
          <div class="prize-title">我的奖品</div>
          <div class="prize-list-mask">
            <ul class="prize-list" v-if="prizeList && prizeList.length > 0">
              <li v-for="item in prizeList" :key="item.id">
                <span>{{ item.title || '-' }}</span>
                <span>{{ item.name || '-' }}</span>
                <span>{{ item.hittime ? item.hittime.slice(0, 11) : '-' }}</span>
              </li>
            </ul>
            <div class="default-page" v-else>
              <p>很遗憾，您未中奖</p>
            </div>
          </div>
        </div>
        <div class="exit-btn" @click="exitFun">退出</div>
      </main>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import GoBack from '@/components/layout/GoBack.vue'
import axios from 'axios';
import { Dialog } from 'vant';
import 'vant/lib/dialog/index.css';

@Component({
  components: {
    GoBack
  }
})
export default class User extends Vue {
  loadFlag = false
  userInfo: any = {}
  prizeList: any = []

  mounted() {
    this.getUserInfo()
  }

  // 获取用户信息
  getUserInfo () {
    axios
      .get(
        `/user/info`,
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          // 用户已登录
          const { data } = res.data
          data.pic = process.env.VUE_APP_PATH + data.pic
          this.userInfo = data
          

          this.getPrizeList()
        } else { 
          // 未登录，跳转登录
          this.$router.push({
            name: 'login'
          })
        }
      })
  }

  // 获取奖品列表
  getPrizeList () {
    axios
      .get(
        `/user/hit/-1/1/100`,
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          const { data } = res.data
          if(data.totalNum && data.items.length > 0){
            // 接口数据处理，倒序显示最新奖品
            this.prizeList = data.items
          }
          this.loadFlag = true
        }
      })
  }

  // 退出
  exitFun(){
    Dialog.confirm({
      title: '温馨提示',
      message: '确定要退出登录吗？',
    })
      .then(() => {
        // on confirm
        axios
          .get(`/logout`)
          .then((res: any) => {
            if(res.data.code === 1){
              this.$router.push({
                path: '/'
              })
            }
          })
      })
      .catch(() => {
        // 关闭回调
      });
  }
}
</script>
<style lang="scss" scoped>
.user-page{
  height: 100%;
  .page-cont{
    min-height: 100%;
    background-image: url(../../assets/user/bg.svg);
    background-size: 100% 508px;
    background-repeat: no-repeat;
    background-position: 0 -88px;
    position: relative;
    background-color: #FFFFFF;
    padding-bottom: 40px;
    box-sizing: border-box;

    .user-info{
      padding-top: 88px;
      text-align: center;
      img{
        width: 104px;
        height: 104px;
        border-radius: 50%;
      }
      h2{
        margin-top: 16px;
        font-size: 36px;
        font-family: PingFangSC-Medium, PingFang SC;
        font-weight: 500;
        color: #FFFFFF;
        line-height: 52px;
        text-align: center;
      }
      p{
        font-size: 24px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #FFFFFF;
        line-height: 40px;
        text-align: center;
      }
    }

    .ad-info{
      width: 654px;
      margin: 32px auto 0;
      display: flex;
      align-items: center;
      justify-content: space-between;
      li{
        width: 316px;
        height: 128px;
        background: #FFFFFF;
        box-shadow: 0px 4px 32px 0px rgba(73,18,18,0.04);
        border-radius: 24px;
        box-sizing: border-box;
        padding: 24px 0 24px 56px;
        display: flex;
        align-items: center;
        img{
          width: 80px;
          height: 80px;
          margin-right: 32px;
        }
        .info-text{
          p{
            font-size: 36px;
            font-family: PingFangSC-Medium, PingFang SC;
            font-weight: 500;
            color: #1D2129;
            line-height: 50px;
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

    .my-prize{
      width: 654px;
      height: 652px;
      background: linear-gradient(90deg, #FA745F 0%, #EF6458 100%);
      border-radius: 32px;
      position: relative;
      margin: 56px auto 0;
      padding-top: 88px;
      box-sizing: border-box;
      .prize-title{
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
        font-size: 32px;
        font-family: PingFangSC-Medium, PingFang SC;
        font-weight: 500;
        color: #9B2410;
        line-height: 44px;
      }

      .prize-list-mask{
        width: 638px;
        height: 556px;
        background: linear-gradient(180deg, #FFECEA 0%, #FFFFFF 100%);
        box-shadow: inset 0px 4px 4px 0px #FFFFFF;
        border-radius: 24px;
        overflow: hidden;
        margin: 0 auto;
        .prize-list{
          width: 678px;
          height: 100%;
          padding-right: 40px;
          overflow-y: auto;
          box-sizing: border-box;
          overflow-x: hidden;
          li{
            width: 638px;
            max-width: 638px;
            height: 80px;
            display: flex;
            align-items: center;
            justify-content: space-between;
            padding: 18px 40px;
            margin-top: 8px;
            box-sizing: border-box;
            span{
              font-size: 28px;
              font-family: PingFangSC-Regular, PingFang SC;
              font-weight: 400;
              color: #1D2129;
              line-height: 44px;
              text-overflow:ellipsis;  
              overflow: hidden;  
              white-space: nowrap;
              &:nth-of-type(1){
                width: 120px;
              }
              &:nth-of-type(2){
                width: 190px;
                color: #F06659;
              }
              &:nth-of-type(3){
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
            font-size: 32px;
            font-family: PingFangSC-Medium, PingFang SC;
            font-weight: 500;
            color: #9B2410;
            line-height: 44px;
          }
        }
      }
    }

    .exit-btn{
      margin: 84px auto 0;
      width: 654px;
      height: 96px;
      background: linear-gradient(90deg, #FA745F 0%, #EF6458 100%);
      border-radius: 48px;
      text-align: center;
      font-size: 32px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #FFFFFF;
      line-height: 96px;
    }
  }
}

</style>