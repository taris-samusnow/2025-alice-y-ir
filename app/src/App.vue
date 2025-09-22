<script setup lang="ts">
  import WelcomHome from './components/WelcomHome.vue'
  import Top from './components/Top.vue';
  import { ref } from 'vue'

  const isIf = ref(true);
  const handleChildData = () => {
    //console.debug("animationend")
    isIf.value = false;
  }
</script>

<template>
  <div class="box">
    <div v-if="isIf" id="if-wh"><WelcomHome  @eventEmit="handleChildData" ></WelcomHome></div>
    <div v-else id="if-else-top"><Top /></div>
  </div>
</template>

<style scoped>
</style>