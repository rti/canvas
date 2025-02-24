<template>
  <div class="markdown-editor">
    <textarea :value="modelValue" @input="handleInput" spellcheck="false"></textarea>
    <div class="preview" v-html="preview"></div>
  </div>
</template>

<script setup lang="ts">
import { ref, computed } from 'vue'
import { marked } from 'marked'

const props = defineProps({
  modelValue: String,
})

const emit = defineEmits(['update:modelValue'])

const handleInput = (event: Event) => {
  const target = event.target as HTMLTextAreaElement
  emit('update:modelValue', target.value)
}

const preview = computed(() => {
  return marked(props.modelValue || '')
})
</script>

<style scoped>
.markdown-editor {
  display: flex;
}

.markdown-editor textarea {
  flex: 1;
  padding: 1em;
  font-size: 12pt;
  resize: none;
}

.markdown-editor .preview {
  flex: 1;
  padding: 0 1em;
  font-size: 12pt;
}

:deep(strong) {
  font-weight: bold;
}

:deep(h1),
:deep(h2),
:deep(h3),
:deep(h4),
:deep(h5),
:deep(h6) {
  margin-bottom: 0.3rem;
  font-weight: bold;
}

:deep(h1):not(:first-child),
:deep(h2):not(:first-child),
:deep(h3):not(:first-child),
:deep(h4):not(:first-child),
:deep(h5):not(:first-child),
:deep(h6):not(:first-child) {
  margin-top: 0.7rem;
}

:deep(code) {
  background-color: #dfdfdf;
  padding: 0.1rem;
  margin: 0.1rem;
  border-radius: 0.1em;
}

:deep(pre) {
  background-color: #dfdfdf;
  padding: 0.3rem;
  margin: 0.3rem 0;
  border-radius: 0.1em;
}

:deep(p) {
  margin-top: 0.3rem;
}

:deep(a) {
  color: #4caf50;
  font-weight: bold;
}

:deep(table) {
  margin-top: 0.7rem;
  background-color: #f5f5f5;
  padding: 0rem;
}

:deep(td),
:deep(th) {
  padding: 0 0.1rem;
}

:deep(td) {
  padding: 0 0.5em;
}

:deep(th) {
  background-color: #dfdfdf;
}

:deep(img) {
  max-width: 100%;
}

:deep(hr) {
  color: #00000000;
  border-bottom: solid #dfdfdf 3px;
  margin: 1em;
}
</style>
