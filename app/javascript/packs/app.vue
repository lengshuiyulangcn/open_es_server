<template>
  <div id="app" class="container">
    <img src="./assets/logo.png">
    <div class="row">
      <div class="col-md-12">
				<div class="bs-callout bs-callout-success">
					<h4>{{origin.title}}</h4>
						{{origin.content}}
				</div>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6">
        <Editor :content="dataModified" @input="update"></Editor>
      </div>
      <div class="col-md-6">
				<Sheet :content="content"></Sheet>
      </div>
    </div>
    <div class="row">
      <div class="col-md-6 col-md-offset-3">
        <button type='submit' class="btn btn-success long-btn" @click="modify">提交修改</button>
      </div>
    </div>
  </div>
</template>

<script>
import Sheet from './components/Sheet'
import Editor from './components/Editor'
import 'bootstrap/dist/css/bootstrap.css'
import 'bootstrap-vue/dist/bootstrap-vue.css'
import * as differ from 'diff/dist/diff.min'
import axios from 'axios'

export default {
  name: 'app',
  data () {
    return { dataModified: this.origin.modified, raw: this.origin.content, id: this.origin.id, token: this.token }
  },
  computed: {
    content() {
      var diff = differ.diffChars(this.$data.dataModified, this.$data.raw)
      let result = ''
      diff.forEach(function (part) {
        if (part.removed) {
          result += `<span style="text-decoration: line-through; font-style: italic; color: red;">${part.value}</span>`
        } else if (part.added) {
          result += `<span style="color: green;">${part.value}</span>`
        } else {
          result += part.value
        }
      })
      result = `<p>${result}</p>`
      return result
    }
  },
  components: {
    Sheet,
    Editor
  },
  props: ['origin', 'token'],
  methods: {
    update (message) {
      this.dataModified = message
    },
    modify () {
      var that = this
      axios.defaults.headers['X-CSRF-TOKEN'] = this.$data.token
      axios.post('/modifications', {
        section_id: this.$data.id,
				content: this.$data.dataModified,
			})
			.then(function (response) {
        that.$swal('saved')
			})
			.catch(function (error) {
        that.$swal('oops, something goes wrong')
			})
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
  margin-top: 60px;
}

.long-btn {
  margin-top: 30px;
  width: 100%;
}
.bs-callout {
    padding: 20px;
    margin: 20px 0;
    border: 1px solid #eee;
    border-left-width: 5px;
    border-radius: 3px;
	  text-align: left;
}
.bs-callout h4 {
	  text-align: left;
    margin-top: 0;
    margin-bottom: 5px;
}
.bs-callout p:last-child {
    margin-bottom: 0;
}
.bs-callout code {
    border-radius: 3px;
}
.bs-callout+.bs-callout {
    margin-top: -5px;
}
.bs-callout-default {
    border-left-color: #777;
}
.bs-callout-default h4 {
    color: #777;
}
.bs-callout-primary {
    border-left-color: #428bca;
}
.bs-callout-primary h4 {
    color: #428bca;
}
.bs-callout-success {
    border-left-color: #5cb85c;
}
.bs-callout-success h4 {
    color: #5cb85c;
}
.bs-callout-danger {
    border-left-color: #d9534f;
}
.bs-callout-danger h4 {
    color: #d9534f;
}
.bs-callout-warning {
    border-left-color: #f0ad4e;
}
.bs-callout-warning h4 {
    color: #f0ad4e;
}
.bs-callout-info {
    border-left-color: #5bc0de;
}
.bs-callout-info h4 {
    color: #5bc0de;
}
</style>
