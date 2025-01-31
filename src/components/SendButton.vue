<template>
  <button class="send-button" @click="handleButtonClick" :disabled="isRequestActive">
    <svg
      v-if="!isRequestActive"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <line x1="22" y1="2" x2="11" y2="13"></line>
      <polygon points="22 2 15 22 11 13 2 9 22 2"></polygon>
    </svg>
    <span v-if="isRequestActive" style="color: white">Working...</span>
    <span v-else>Send</span>
  </button>
</template>

<script>
export default {
  props: {
    isRequestActive: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    handleButtonClick() {
      this.$emit('handleButtonClick')
    },
  },
}
</script>

<style scoped>
.send-button {
  background-color: #4caf50;
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.send-button:hover {
  background-color: #3e8e41;
}

.send-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.send-button svg {
  vertical-align: middle;
  margin-right: 5px;
}
</style>
