<!----------------------------- script ------------------------------------------- -->
<script setup lang="ts">
import { ref, onMounted, defineEmits } from 'vue'
import { gsap } from 'gsap'

const msg_welcomehome = "お帰りなさいませ"
const msg_master = "ご主人様"
const Img = ref<any>("url('/2025-alice-y-ir/static/images/welcomhome.png')")

const emit = defineEmits(['eventEmit'])

onMounted(() => {
  //---------------------
  // テキストを文字単位に分割する関数
  function splitText(element: any) {
    const text = element.textContent;
    element.innerHTML = '';
  
    text.split('').forEach((char: string) => {
      const span = document.createElement('span');
      span.className = 'char';
      span.textContent = char === ' ' ? '\u00A0' : char; // スペースの処理
      element.appendChild(span);
    });
  }
  const target = document.querySelector(".fade-in-background");
  target!.addEventListener("animationend", () => {
    emit('eventEmit',)
  });
  //-----------main----------
  // 段落のアニメーション
  const paragraph = document.querySelector('.animated-paragraph');
  const paragraph2 = document.querySelector('.animated-paragraph_');
  splitText(paragraph);
  splitText(paragraph2);

  gsap.from('.animated-paragraph .char', {
    duration: 0.6,
    y: 50,
    opacity: 0,
    stagger: 0.15,
    ease: "power2.out",
    delay: 4
  });

  gsap.from('.animated-paragraph_ .char', {
    duration: 0.6,
    y: 50,
    opacity: 0,
    stagger: 0.1,
    ease: "power2.out",
    delay: 6
  });
});
</script>

<!----------------------------- html --------------------------------------------->
<template>
  <div class="fade-in-background">
    <div class="text-animation-container">
      <p class="animated-paragraph"> {{ msg_welcomehome }} </p>
      <p class="animated-paragraph_"> {{ msg_master }} </p>
    </div>
  </div>
</template>

<!----------------------------- style--------------------------------------------->
<style scoped>
@font-face {
  font-family: "KTEGAKI";
  src: url("/2025-alice-y-ir/static/fonts/KTEGAKI.ttf") format("truetype") 
}

/* テキストアニメーション*/
.text-animation-container {
  font-family: "KTEGAKI";
  max-width: 800px;
  margin: 100px auto;
  text-align: center;
  padding: 40px;
}

.animated-paragraph {
  font-size: 3rem;
  line-height: 1.8;
  color: white;
  overflow: hidden;
  font-size: 80px;
}

.animated-paragraph_ {
  font-size: 3rem;
  line-height: 1.8;
  color: white;
  overflow: hidden;
  font-size: 80px;
}

.char {
  display: inline-block;
}

/* 背景画像 */
.fade-in-background {
  background-image: v-bind(Img);
  background-size: cover;
  background-repeat: no-repeat;
  background-position: bottom;
  width: 100vw;
  height: 100vh;
  margin-right: calc(50% - 50vw);
  margin-left: calc(50% - 50vw);
  display: flex;
  justify-content: center;
  align-items: center;
  z-index: -1;
  animation-duration: 10s;
  animation-iteration-count: 1;
  animation-timing-function: linear;
  animation-fill-mode: forwards;
  animation-name: fadeIn;
}

.fade-in-background::before {
  content: "";
  position: absolute;
  width: 100%;
  height: 100%;
  background: inherit;
  filter: brightness(90%);
  /* 最背面へ */
  z-index: -2;
}

@keyframes fadeIn {
  0% {
      opacity: 0;
      transform: scale(1.1);
  }

  25% {
      opacity: 1;
      transform: scale(1.2);
    }

  50% {
      opacity: 1;
      transform: scale(1.3);
  }

  75% {
      opacity: 1;
      transform: scale(1.4);
  }

  100% {
      opacity: 0;
      transform: scale(1.4);
  }
}
html {
  overflow: hidden !important;
  scrollbar-width: none;
  -ms-overflow-style: none;
}

html::-webkit-scrollbar {
  width: 0;
  height: 0;
}
</style>
