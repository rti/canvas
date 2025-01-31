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

::v-deep strong {
  font-weight: bold;
}

::v-deep h1,
::v-deep h2,
::v-deep h3,
::v-deep h4,
::v-deep h5,
::v-deep h6 {
  margin-bottom: 0.3rem;
  font-weight: bold;
}

::v-deep h1:not(:first-child),
::v-deep h2:not(:first-child),
::v-deep h3:not(:first-child),
::v-deep h4:not(:first-child),
::v-deep h5:not(:first-child),
::v-deep h6:not(:first-child) {
  margin-top: 0.7rem;
}

::v-deep code {
  background-color: #dfdfdf;
  padding: 0.1rem;
  margin: 0.1rem;
  border-radius: 0.1em;
}

::v-deep pre {
  background-color: #dfdfdf;
  padding: 0.3rem;
  margin: 0.3rem 0;
  border-radius: 0.1em;
}

::v-deep p {
  margin-top: 0.3rem;
}

::v-deep a {
  color: #4caf50;
  font-weight: bold;
}

::v-deep table {
  margin-top: 0.7rem;
  background-color: #f5f5f5;
  padding: 0rem;
}

::v-deep td,
::v-deep th {
  padding: 0 0.1rem;
}

::v-deep td {
  padding: 0 0.5em;
}

::v-deep th {
  background-color: #dfdfdf;
}

::v-deep img {
  max-width: 100%;
}

::v-deep hr {
  color: #00000000;
  border-bottom: solid #dfdfdf 3px;
  margin: 1em;
}
</style>
