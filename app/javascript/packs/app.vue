<template>
  <div id="app">
    <input v-model="message"><br />
    <p>{{ message }}</p>
    <ul>
      <li v-for="food in food_items">{{food}}</li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      message: "Hello Vue!",
      food_items: ['hamburger','hotdog','fries']
    }
  }
}
</script>

<style scoped>
p {
  font-size: 2em;
  text-align: center;
}
</style>
