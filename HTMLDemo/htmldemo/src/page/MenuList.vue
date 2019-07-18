<template>
  <div class="container">
    <div @click="clickAction" class="btn">点击{{name}}</div>
  </div>
</template>

<script>
export default {
  name: 'MenuList',
  data () {
    return {
      name: ''
    }
  },
  created () {
    let obj = window.addValue('vue  to  ios!!!')
    this.name = obj.name
  },
  mounted () {

  },
  methods: {
    clickAction: function () {
      // window.JsBridgeBind('addValue', function (res) {
      //   console.log(res)
      // }, {
      //   params: 'vue  to  ios!!!'
      // })

      // console.log(window.addValue('vue  to  ios!!!'))

      let obj = window.addValue('vue  to  ios!!!')
      this.name = obj.name
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
  .btn {
    margin-top: 100px;
  }
</style>
