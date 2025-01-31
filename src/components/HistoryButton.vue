<template>
  <button
    class="history-button"
    @click="stepInCanvasHistory"
    :disabled="disabled"
  >
    <svg
      v-if="direction === 'back'"
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <polyline points="15 18 9 12 15 6"></polyline>
    </svg>
    <svg
      v-else
      width="24"
      height="24"
      viewBox="0 0 24 24"
      fill="none"
      stroke="currentColor"
      stroke-width="2"
      stroke-linecap="round"
      stroke-linejoin="round"
    >
      <polyline points="9 18 15 12 9 6"></polyline>
    </svg>
  </button>
</template>

<script>
export default {
  props: {
    direction: {
      type: String,
      required: true,
    },
    disabled: {
      type: Boolean,
      required: true,
    },
  },
  methods: {
    stepInCanvasHistory() {
      this.$emit('stepInCanvasHistory')
    },
  },
}
</script>

<style scoped>
.history-button {
  background-color: #4caf50;
  color: #fff;
  padding: 10px 20px;
  border: none;
  border-radius: 5px;
  cursor: pointer;
}

.history-button:hover {
  background-color: #3e8e41;
}

.history-button:disabled {
  background-color: #ccc;
  cursor: not-allowed;
}

.history-button svg {
  vertical-align: middle;
  margin-right: 5px;
}
</style>
