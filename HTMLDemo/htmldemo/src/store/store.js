import Vue from 'vue'
import Vuex from 'vuex'

Vue.use(Vuex)
export default new Vuex.Store({
  state: {
    navTitle: ''
  },
  mutations: {
    SETNAVTITLE: (state, title) => {
      state.navTitle = title
    }
  },
  actions: {
    setNavTitle ({commit}, title) {
      commit('SETNAVTITLE', title)
    }
  },
  getters: {
    navTitle: (state) => {
      return state.navTitle
    }
  }
})
