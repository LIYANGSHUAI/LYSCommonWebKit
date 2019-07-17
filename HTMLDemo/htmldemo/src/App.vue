<template>
  <div id="app">
    <div class="navBox">
      <div class="navContent">
        <div class="back" @click="backAction">返回</div>
        <h4>{{navTitle}}</h4>
      </div>
    </div>
    <router-view/>
  </div>
</template>

<script>
import {mapGetters} from 'vuex'

export default {
  name: 'App',
  computed: {
    ...mapGetters([
      'navTitle'
    ])
  },
  methods: {
    backAction () {
      this.$router.back()
    }
  }
}
</script>

<style>
  #app {
    font-family: 'Avenir', Helvetica, Arial, sans-serif;
    -webkit-font-smoothing: antialiased;
    -moz-osx-font-smoothing: grayscale;
    text-align: center;
    color: #2c3e50;
    width: 100%;
    height: 100%;
  }

  * {
    margin: 0;
    padding: 0;
  }

  body, html {
    width: 100%;
    height: 100%;
  }

  .navBox {
    width: 100%;
    height: 64px;
    background-color: #E0E0DF;
    border-bottom: 1px #dddddd solid;
    padding-top: 20px;
    box-sizing: border-box;
  }

  .navContent {
    position: relative;
    width: 100%;
    height: 44px;
    display: flex;
    align-items: center;
    justify-content: center;
  }

  .back {
    height: 44px;
    line-height: 44px;
    position: absolute;
    left: 15px;
  }
</style>
