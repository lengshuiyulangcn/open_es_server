<template>
  <div class="sheet">
    <article v-html="content"></article>
  </div>
</template>

<script>
export default {
  name: 'sheet',
  props: ['content']
}
</script>

<style scoped>
.sheet article{
  padding: 5px;
  background-color: #f6f6f6;
  width: 100%;
  min-height: 300px;
  text-align: left;
}
</style>
