<template>
  <header>
    <div class="header-cont">
      <h2>让红包治愈一切</h2>
      <div class="login-mask" v-show="loadFlag">
        <div class="login-btn" @click="login" v-if="!userInfo.loginFlag">登录</div>
        <div class="user-info" v-else @click="goUser">
          <img :src="userInfo.photo" alt="">
          <span>{{ userInfo.userName }}</span>
        </div>
      </div>
    </div>
  </header>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import axios from 'axios';

@Component
export default class Header extends Vue {
  loadFlag = false
  userInfo: any = {
    loginFlag: false,
    photo: '',
    userName: ''
  }

  mounted () {
    this.getUserInfo()
  }


  getUserInfo () {
    axios
      .get(
        `/user/info`,
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          // 用户已登录
          const { data } = res.data
          this.userInfo = {
            loginFlag: true,
            photo: process.env.VUE_APP_PATH + data.pic,
            userName: data.uname
          }
        } else { 
          this.userInfo.loginFlag = false
        }
        this.loadFlag = true
      })
  }
  // 跳转登录页
  login () {
    this.$router.push({
      name: 'login'
    })
  }

  // 跳转个人中心
  goUser(){
    this.$router.push({
      name: 'user'
    })
  }
}
</script>
<style lang="scss" scoped>
header{
  height: 88px;
  .header-cont{
    position: fixed;
    top: 0;
    left: 0;
    width: 100%;
    height: 88px;
    box-sizing: border-box;
    background-color: #fff;
    z-index: 1;
    h2{
      text-align: center;
      font-size: 34px;
      font-family: PingFangSC-Medium, PingFang SC;
      font-weight: 500;
      color: #1D2129;
      line-height: 88px;
    }
    .login-mask{
      position: absolute;
      right: 24px;
      top: 50%;
      transform: translateY(-50%);
      .login-btn{
        width: 120px;
        height: 60px;
        background: rgba(240,101,88,0.08);
        border-radius: 30px;
        text-align: center;
        font-size: 26px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #EF6458;
        line-height: 60px;
      }

      .user-info{
        display: flex;
        align-items: center;
        img{
          width: 40px;
          height: 40px;
          border-radius: 50%;
          border: 1px solid #BEDAFF;
          margin-right: 8px;
          box-sizing: border-box;
        }
        span{
          max-width: 104px;
          height: 36px;
          font-size: 26px;
          font-family: PingFangSC-Regular, PingFang SC;
          font-weight: 400;
          color: #1D2129;
          line-height: 36px;
          text-overflow:ellipsis;  
          overflow: hidden;  
          white-space: nowrap;
        }
      }
    }
  }
}

</style>