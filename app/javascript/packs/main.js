// The Vue build version to load with the `import` command
// (runtime-only or standalone) has been set in webpack.base.conf with an alias.
import Vue from 'vue/dist/vue.esm'
import App from './App'
import BootstrapVue from 'bootstrap-vue'
import VueSweetAlert from 'vue-sweetalert'

Vue.use(BootstrapVue)
Vue.use(VueSweetAlert)
Vue.config.productionTip = false

/* eslint-disable no-new */

document.addEventListener('DOMContentLoaded', () => {
  let hello = document.body.appendChild(document.createElement('hello'))
  let element = document.getElementById("section_content")
  let token = $('meta[name="csrf-token"]').attr('content')
  let origin = element.dataset
  const app = new Vue({
    el: hello,
    data: { origin: origin, token: token},
    template: '<App :origin="origin" :token="token"/>',
    components: { App }
  })
  console.log(app)
})
