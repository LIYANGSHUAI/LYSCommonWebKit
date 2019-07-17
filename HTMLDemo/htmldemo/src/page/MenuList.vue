<template>
  <div class="container">
    <div class="itemBox" v-for="(item, index) in menuList" :key="index" @click="itemClickAction(index)">
      {{item}}
    </div>
  </div>
</template>

<script>
export default {
  name: 'MenuList',
  data () {
    return {
      menuList: [
        '利用bridge实现交互',
        '直接在window上绑定事件'
      ]
    }
  },
  created () {
    this.$store.dispatch('setNavTitle', 'API使用')
  },
  methods: {
    itemClickAction (index) {
      let str = this.menuList[index]
      this.$router.push({
        path: '/content',
        query: {
          navTitle: str
        }
      })
    }
  }
}
</script>

<style scoped>
  .container {
    width: 100%;
    height: 100%;
    background-color: #eee;
  }
  .itemBox {
    width: 100%;
    height: 50px;
    border-bottom: 1px #ddd solid;
    line-height: 50px;
    text-align: left;
    padding: 15px;
  }
</style>
