import Vue from 'vue'
import Router from 'vue-router'
import MenuList from '@/page/MenuList'
import Content from '@/page/Content'

Vue.use(Router)

export default new Router({
  routes: [
    {
      path: '/',
      name: 'MenuList',
      component: MenuList
    },
    {
      path: '/content',
      name: 'Content',
      component: Content
    }
  ]
})
