<script setup lang="ts">
// 欢迎页面的逻辑（目前无需额外逻辑）
</script>

<template>
  <div class="welcome-container">
    <h1 class="animated-text">Solmorrow</h1>
    <p class="subtitle">欢迎来到 Solmorrow 的世界</p>
  </div>
</template>

<style scoped>
.welcome-container {
  display: flex;
  flex-direction: column;
  align-items: center;
  justify-content: center;
  height: 100vh;
  background-color: #1a1a1a;
  /* 暗色背景 */
  color: #ffffff;
  font-family: Arial, sans-serif;
}

.animated-text {
  font-size: 4rem;
  font-weight: bold;
  animation: colorChange 10s infinite;
}

@keyframes colorChange {
  0% {
    color: #ff6b6b;
  }

  /* 红色 */
  14% {
    color: #ff8c42;
  }

  /* 橙色 */
  28% {
    color: #f9ca24;
  }

  /* 黄色 */
  42% {
    color: #6bcf7f;
  }

  /* 绿色 */
  57% {
    color: #4ecdc4;
  }

  /* 青色 */
  71% {
    color: #45b7d1;
  }

  /* 蓝色 */
  85% {
    color: #9b59b6;
  }

  /* 紫色 */
  100% {
    color: #ff6b6b;
  }

  /* 回到红色 */
}

.subtitle {
  font-size: 1.5rem;
  margin-top: 1rem;
  opacity: 0.8;
}
</style>
