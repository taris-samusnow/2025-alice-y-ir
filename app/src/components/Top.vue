<!----------------------------- script ------------------------------------------- -->
<script setup lang="ts">
  import { ref, onMounted, computed } from 'vue'
  import { gsap } from 'gsap'
  
  const vcastLists = [
    { 
      image: "/2025-alice-y-ir/static/images/cast_001_alice-yumemiya_castImages.png", 
      msg:   "かしこかわいい不思議の国のゆるふわメイドの夢宮ありすです！ 時は21世紀、地球から21光年離れたところにある、わんだふるわーるどからお給仕しています！", 
      clr:   "#CAEBF4"
    }, 
    { 
      image: "/2025-alice-y-ir/static/images/cast_002_alice-yumemiya_castImages.png",
      msg:   "アナーキーメイド長、 猫田ぺぺろです！！ ご主人の予想をいい意味で裏切り続けるぺぺーろに目が釘付けになっちゃうこと間違いなしっ♡", 
      clr:   "#D7D1FA"
    },
    { 
      image: "/2025-alice-y-ir/static/images/cast_003_alice-yumemiya_castImages.png", 
      msg:   "甘えん坊妹メイド？！ 相晴ひなたです！ 1度ご帰宅されればきっっと目が離せなくなること間違いなしです♡...心配で。", 
      clr:   "#BCD6FF"
    },
    { 
      image: "/2025-alice-y-ir/static/images/cast_004_alice-yumemiya_castImages.png",
      msg:   "しっかり者の姉ギャルメイド 初恋サキです！えちえち度120%♡いつでも全力！健気！！なお給仕をしています✨", 
      clr:   "#FBC4CB"
    }
  ];
  
  const links = [
    { icon: 'mdi-calendar', text: 'schedules',   route: 'https://cafe-masquerade.com/schedules',        newTab: true },
    { icon: 'mdi-rabbit',   text: 'Casts',       route: 'https://cafe-masquerade.com/casts',            newTab: true },
    { icon: 'mdi-note',     text: 'news',        route: 'https://cafe-masquerade.com/news',             newTab: true },
    { icon: 'mdi-heart',    text: 'Offcial FC',  route: 'https://ci-en.dlsite.com/creator/7561',        newTab: true },
    { icon: 'mdi-menu',     text: 'concept',     route: 'https://cafe-masquerade.com/concept',          newTab: true },
    { icon: 'mdi-bed',      text: 'How to Play', route: 'https://cafe-masquerade.com/about-masquerade', newTab: true }
  ];

  var drawer = ref(true);
  var currentIndex = 0;
  const Vimg = ref<any>(vcastLists[currentIndex]);
  const Vmsg = ref<any>(vcastLists[currentIndex]);
  const Vclr = ref<any>(vcastLists[currentIndex]);

  Vimg.value = vcastLists[currentIndex].image;
  Vmsg.value = vcastLists[currentIndex].msg;
  Vclr.value = vcastLists[currentIndex].clr;

  function click(){
    drawer = ref(true)
  }

  onMounted(() => {
    
    const target = document.querySelector(".fade-in");
    
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

    target!.addEventListener("animationiteration", () => {
      //console.debug("ローテーション終了");
      currentIndex = (currentIndex + 1) % vcastLists.length;
      Vimg.value   = vcastLists[currentIndex].image;
      Vmsg.value   = vcastLists[currentIndex].msg;
      Vclr.value   = vcastLists[currentIndex].clr;
      
      setTimeout(() => {
        
        const paragraph = document.querySelector('.animated-paragraph');
        
        splitText(paragraph);
        
        gsap.from('.animated-paragraph .char', {
          duration: 0.6,
          y: 50,
          opacity: 0,
          stagger: 0.05,
          ease: "power2.out",
          delay: 1
        });
      },1);

    });
    
    target!.addEventListener("animationstart", () => {
      //console.debug("アニメーション開始");
    });
    
  });
  
  const computedLinks = computed(() => {
    return links.map((link) => {
      const linkProps = {
        [/^((https?:)?\/\/)/.test(link.route) ? 'href' : 'to']: link.route,
      }
      if (link.newTab) {
        linkProps.target = '_blank'
      }
      return {
        ...link,
        linkProps,
      }
    })
  })
</script>

<!----------------------------- html --------------------------------------------->
<template>
   <v-layout>
    <!-- 上部バー -->
    <v-app-bar color="transparent" elevation="0" >
      <v-app-bar-nav-icon @click="drawer = !drawer"></v-app-bar-nav-icon>
      <v-app-bar-title>バーチャルメイド喫茶『ますかれーど』</v-app-bar-title>
    </v-app-bar>
    <!-- 左サイドバー -->
    <v-navigation-drawer v-model="drawer" color="transparent" width="120" elevation="0" >
      <v-list>
        <v-list-item v-for="link in computedLinks" :key="link.text" v-bind="link.linkProps">
          <v-list-item-action>
            <v-icon>{{ link.icon }}</v-icon>
          </v-list-item-action>
          <v-list-item-title> {{ link.text }} </v-list-item-title>
        </v-list-item>
      </v-list>
    </v-navigation-drawer>
    <!-- 画像関連 -->
    <div class="img-box">
      <v-img :src=Vimg class="fade-in"></v-img>
    </div>
    <!-- 文字制御 -->
    <div class="text-animation-container">
      <div class="stroke anim">
        <div class="border top"></div>
        <div class="border right"></div>
        <div class="border bottom"></div>
        <div class="border left"></div>
      </div>
      <p class="animated-paragraph"> {{ Vmsg }} </p>
    </div>
   </v-layout>
</template>
<!----------------------------- style--------------------------------------------->
<style scoped>
@font-face {
  font-family: "KTEGAKI";
  src: url("/2025-alice-y-ir/static/fonts/KTEGAKI.ttf") format("truetype") 
}


/* 文字制御 */
.text-animation-container {
  font-family: "KTEGAKI";
  width: 100%;
  height: 100%;
  animation-duration: 8s;
  animation-iteration-count: infinite;
  animation-name: underupIn;
  position: relative;
  top: 0;
  right: 0;
  z-index: 1;
}

.animated-paragraph {
  background: v-bind(Vclr);
  text-align: right;
  font-size: 3rem;
  color: black;
  overflow: hidden;
  font-size: 80px;
  writing-mode: vertical-rl;
}

.char {
  display: inline-block;
}

@keyframes underupIn {
  0% {
      opacity: 1;
      /*transform: scale(1.0);*/
      transform: translateY(1000px);
  }
  10% {
      opacity: 1;
  }
  20% {
      opacity: 1;
      transform: translateY(0px);
  }

  40%{
      opacity: 1;
  }
  100% {
      opacity: 1;
      /*transform: scale(1.4);*/
  }
}

/*囲み枠 制御*/
.stroke {
  max-width: 400px;
  height: 0px;
  position: absolute;
  z-index: 2
}
 
.stroke .border {
  content: "";
  position: absolute;
  opacity: 0;
}
.stroke .border.top,
.stroke .border.bottom {
  width: calc(100% - 20px);
}
.stroke .border.top {
  border-top: 3px solid #362ae0;
  right: 0;
  top: 0;
}
.stroke .border.bottom {
  border-bottom: 3px solid #362ae0;
  left: 0;
  bottom: 0;
}
 
.stroke .border.right,
.stroke .border.left {
  height: calc(100% - 20px);
}
.stroke .border.right {
  border-right: 3px solid #362ae0;
  right: 0;
  top: 0;
}
.stroke .border.left {
  border-left: 3px solid #362ae0;
  left: 0;
  bottom: 0;
}
 
.stroke.is-animated .border {
  opacity: 1;
}
 
.stroke.is-animated .border.top,
.stroke.is-animated .border.bottom {
  animation: stroke-width 1.8s cubic-bezier(0.22, 1, 0.36, 1);
}
.stroke.is-animated .border.right,
.stroke.is-animated .border.left {
  animation: stroke-height 1.8s cubic-bezier(0.22, 1, 0.36, 1);
}
 
@keyframes stroke-width {
  0% {
    width: 0;
    opacity: 1;
  }
  100% {
    width: calc(100% - 20px);
    opacity: 1;
  }
}
 
@keyframes stroke-height {
  0% {
    height: 0;
    opacity: 1;
  }
  100% {
    height: calc(100% - 20px);
    opacity: 1;
  }
}

/* キャスト画像 */
.img-box{
  position: relative;
  left: 0;
  top: 0;
  width: 100%;
  height: 100%;
  overflow-y: hidden; /* はみ出た部分を隠す */
  z-index: 0;
}
.fade-in {
  object-fit: cover;
  animation-duration: 8s;
  animation-iteration-count: infinite;
  animation-name: fadeIn;
}

@keyframes fadeIn {
  0% {
      opacity: 1;
      /*transform: scale(1.0);*/
      transform: translateY(-1000px);
  }
  10% {
      opacity: 1;
  }
  20% {
      opacity: 1;
      transform: translateY(0);
  }

  40%{
      opacity: 1;
  }
  100% {
      opacity: 1;
      /*transform: scale(1.4);*/
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