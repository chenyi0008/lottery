<template>
  <div class="home-page">
    <Header />
    <div class="card-list">

      <CardItem v-for="item in pageList" :key="item.id" :item="item"></CardItem>
      <div class="get-more" @click="onLoad" v-if="!finished">加载更多</div>
      <div class="get-more"  v-else>没有更多了</div>
    </div>
  </div>
</template>

<script lang="ts">
import { Component, Vue } from 'vue-property-decorator';
import Header from '@/components/layout/Header.vue';
import CardItem from '@/components/detail/card-item.vue'
import axios from 'axios';
import { List } from 'vant';
@Component({
  components: {
    Header,
    CardItem,
    List
  },
})
export default class HomeView extends Vue {
  imgPath:string = process.env.VUE_APP_PATH
  loading = false
  finished = false
  total = 0
  pageSize = 1
  pageList: any[] = []

  mounted () {
    this.getInfo()
  }

  getInfo (type?:string) {
    axios
      .get(
        `/game/list/-1/${this.pageSize}/3`
      )
      .then((res: any) => {
        if (res.data.code === 1) {
          const { isMore, total, items } = res.data.data
          if(type === 'add'){
            this.pageList.push(...items)
          }else{
            this.pageList = items
          }
          this.total = total

          // 加载结束
          this.loading = false;

          // 全部加载完成
          if(isMore === 0){
            this.finished = true
          } else {
            this.finished = false
          }
          
        }
      })
  }

  onLoad(){
    this.pageSize++
    this.getInfo('add')
  }
}
</script>
<style lang="scss" scoped>
.card-list{
  width: 702px;
  margin: 0 auto;
  overflow-y: auto;
}

.get-more{
  text-align: center;
  font-size: 24px;
  font-family: PingFangSC-Regular, PingFang SC;
  font-weight: 400;
  color: #86909C;
  line-height: 40px;
  margin: 48px 0;
}

</style>