import Vue from 'vue'
import VueRouter, { RouteConfig } from 'vue-router'

Vue.use(VueRouter)

const routes: Array<RouteConfig> = [
  {
    path: '/',
    name: 'home',
    component: () => import( '../views/index.vue')
  },
  {
    path: '/login',
    name: 'login',
    component: () => import( '../views/login/index.vue')
  },
  {
    path: '/user',
    name: 'user',
    component: () => import( '../views/user/index.vue')
  },
  {
    path: '/detail',
    name: 'detail',
    component: () => import( '../views/detail/index.vue')
  },
  {
    path: '/detail/rule',
    name: 'rule',
    component: () => import( '../views/detail/rule/index.vue')
  }
]

const router = new VueRouter({
  mode: 'hash',
  base: process.env.BASE_URL,
  routes
})

export default router
