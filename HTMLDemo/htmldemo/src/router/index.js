import Vue from 'vue'
import Router from 'vue-router'
import MenuList from '@/page/MenuList'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'MenuList',
      component: MenuList
    }
  ]
})
