<template>
  <i class="icon-go-back" @click="GoBackFun"></i>
</template>

<script lang="ts">
import { Vue, Component } from 'vue-property-decorator';

@Component
export default class GoBack extends Vue {
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

.icon-go-back{
  position: absolute;
  top: 24px;
  left: 20px;
  width: 40px;
  height: 40px;
  background-image: url(../../assets/common/icon-go-back.svg);
  background-size: 100% 100%;
  background-repeat: no-repeat;
  z-index: 3;
}
</style>