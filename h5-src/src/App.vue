<template>
  <div id="app">
    <router-view />
  </div>
</template>

<style lang="scss">
html{
  overflow: hidden;
}
body{
  overflow-y: auto;
}
*{ margin: 0; padding: 0; font-size: 28px;}
html, body, #app{
  height: 100%;
}
body{
  background-color: #F7F9FD;
}

// vant
.van-toast{
  padding: 24px !important;
  border-radius: 10px !important;
  .van-toast__text{
    font-size: 30px !important;
    line-height: 38px !important;
  }
}

.van-dialog{
  width: 690px !important;
  .van-dialog__header{
    padding-top: 40px !important; 
    font-size: 44px;
    line-height: 48px;
  }
  .van-dialog__content{
    margin: 40px 0;
    .van-dialog__message{
      font-size: 36px;
      line-height: 42px;
    }
  }
  .van-dialog__footer{
    height: 80px;
    .van-button{
      height: 80px;
      line-height: 80px;
      .van-button__content{
        .van-button__text{
          font-size: 36px
        }
      }
    }
  }
}
</style>
