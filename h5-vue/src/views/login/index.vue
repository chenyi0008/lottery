<template>
  <div class="login-page">
    <div class="login-banner" >
      <GoBack />
      <img class="pic-text" src="../../assets/login/pic-text.svg" alt="">
      <img class="pic-dot" src="../../assets/login/pic-dot.png" alt="">
    </div>
    <div class="login-cont-mask">
      <div class="login-cont">
        <div class="form-item user-item">
          <input type="text" placeholder="请输入用户名" v-model="loginForm.userName">
        </div>
        <div class="form-item psw-item">
          <input :type="eyeFlag ? 'text' : 'password'" placeholder="请输入密码" v-model="loginForm.password">
          <i class="icon-eye" :class="{open: eyeFlag}" @click="eyeFlag = !eyeFlag"></i>
        </div>
        <div 
          class="submit" 
          :class="{pass: loginForm.userName && loginForm.password}"
          @click="loginFun"
        >登录</div>
        <p>红包雨活动</p>
      </div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import GoBack from '@/components/layout/GoBack.vue'
import axios from 'axios';
import { Toast } from 'vant';

@Component({
  components: {
    GoBack
  }
})
export default class Login extends Vue {
  loginForm: any = {
    userName: 'bxg',
    password: 'bxg123'
  }
  eyeFlag = false
  // 登录事件
  loginFun () {
    if(this.loginForm.userName !== '' && this.loginForm.password !== ''){
      const params = {
        account: this.loginForm.userName,
        password: this.loginForm.password
      }
      axios
        .post(
          `/login`,
          params,
          {
            headers: {
              'Content-Type': 'application/x-www-form-urlencoded'
            }
          }
        )
        .then((res: any) => {
          if (res.data.code === 1) {
            // 登录成功，返回上一页
            this.GoBackFun()
          } else { 
            // 登录失败，错误提示
            Toast(res.data.msg);
          }
        })
    }
  }

  // 返回上一页
  GoBackFun () {
    if(window.history.state){
      this.$router.go(-1)
    }else{
      this.$router.push({
        path: '/'
      })
    }
  }
}
</script>
<style lang="scss" scoped>
.login-page{
  height: 100%;
  .login-banner{
    height: 396px;
    position: relative;
    background: linear-gradient(117deg, #F67C6B 0%, #E94C33 100%);
    .icon-go-back{
      position: absolute;
      top: 24px;
      left: 20px;
      width: 40px;
      height: 40px;
      background-image: url(../../assets/common/icon-go-back.svg);
      background-size: 100% 100%;
      background-repeat: no-repeat;
    }
    img{
      position: absolute;
      -webkit-touch-callout: none;
      -webkit-user-select: none; 
      -moz-user-select: none;
      -ms-user-select: none;
      user-select: none;
    }
    .pic-text{
      top: 88px;
      left: 64px;
      width: 254px;
      height: 158px;
    }
    .pic-dot{
      top: 44px;
      right: 52px;
      width: 300px;
      height: 300px;
    }
  }

  .login-cont-mask{
    height: calc(100% - 302px - 44px);
    padding-bottom: 44px;
    transform: translateY(-94px);
    min-height: 548px;
  }
  .login-cont{
    width: 686px;
    height: calc(100%);
    // min-height: 504px;
    margin: 0 auto 44px;
    background: #FFFFFF;
    box-shadow: 0px 4px 40px 0px rgba(0,0,0,0.08);
    border-radius: 24px;
    padding: 48px 48px 32px;
    box-sizing: border-box;
    position: relative;

    .form-item{
      height: 96px;
      background: #F9F9F9;
      border-radius: 48px;
      border: 2px solid #F9F9F9;
      padding: 26px 48px;
      box-sizing: border-box;
      margin-bottom: 32px; 
      input{
        width: 400px;
        height: 44px;
        border: 0;
        font-size: 30px;
        font-family: PingFangSC-Regular, PingFang SC;
        font-weight: 400;
        color: #1D2129;
        line-height: 44px;
        outline: none;
        background-color: transparent;
      }

      &.psw-item{
        position: relative;
        .icon-eye{
          position: absolute;
          top: 50%;
          right: 48px;
          width: 40px;
          height: 40px;
          transform: translateY(-50%);
          background-image: url(../../assets/login/icon-preview-close.svg);
          background-size: 100% 100%;
          &.open{
            background-image: url(../../assets/login/icon-preview-open.svg);
          }
        }
      }
    }
    .submit {
      height: 96px;
      border-radius: 48px;
      height: 44px;
      font-size: 32px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #FFFFFF;
      line-height: 44px;
      padding: 26px 0;
      text-align: center;
      margin-top: 48px;
      background: linear-gradient(90deg, #FA745F 0%, #EF6458 100%);
      opacity: 0.5;
      &.pass{
        opacity: 1;
        background: linear-gradient(90deg, #FA745F 0%, #EF6458 100%);
      }
    }

    p{
      position: absolute;
      bottom: 32px; 
      left: 0;
      width: 100%;
      text-align: center;
      height: 40px;
      font-size: 28px;
      font-family: PingFangSC-Regular, PingFang SC;
      font-weight: 400;
      color: #F09587;
      line-height: 40px;
    }
  }

}

</style>