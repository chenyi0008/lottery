import Vue from 'vue'
import App from './App.vue'
import router from './router'
import '../api/init'
import { List, Form, Field, Swipe, SwipeItem } from 'vant';
import 'vant/lib/index.css';

Vue.use(Swipe);
Vue.use(SwipeItem);
Vue.use(Form);
Vue.use(Field);
Vue.use(List);
Vue.config.productionTip = false

new Vue({
  router,
  render: h => h(App)
}).$mount('#app')
