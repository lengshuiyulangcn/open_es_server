<template>
  <div class="sheet">
    <textarea @input="update">{{ content }}</textarea>
  </div>
</template>

<script>
export default {
  name: 'editor',
  props: ['content'],
  methods: {
    update () {
      this.$emit('input', event.target.value)
    }
  }
}
</script>

<style scoped>
.sheet textarea{
  background-color: #fff;
  border-color: #ddd;
  width: 100%;
  min-height: 300px;
}
</style>
