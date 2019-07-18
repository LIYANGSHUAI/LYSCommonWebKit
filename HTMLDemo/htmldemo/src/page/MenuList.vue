<template>
  <div class="container">
    <div @click="clickAction" class="btn">点击</div>
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
  methods: {
    clickAction: function () {
      console.log(window.ios.addValue('vue  to  ios!!'))
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
