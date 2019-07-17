<template>
  <div></div>
</template>

<script>
export default {
  name: 'Content',
  mounted() {
    let str = this.$route.query.navTitle
    this.$store.dispatch('setNavTitle', str)
  }
}
</script>

<style scoped>

</style>
