<script setup lang="ts">
import { ref } from 'vue'
import HistoryButton from './components/HistoryButton.vue'
import SendButton from './components/SendButton.vue'
import MarkdownEditor from './components/MarkdownEditor.vue'

const initialCanvasText = '# Canvas\nA tool to iterate on markdown docs.'
const canvas = ref(initialCanvasText)
const instruction = ref('')
const responseText = ref('')
const isRequestActive = ref(false)
const canvasHistory = ref([initialCanvasText])
const canvasHistoryIndex = ref(0)

const systemPrompt =
  'You receive markdown text wrapped in <|canvas_start|> and <|canvas_end|> tokens. ' +
  'Refine the text in between those tokens according to the instructions and return it ' +
  'using the same tokens again, keep the markdown format.'

function handleCanvasChange(value: string) {
  canvas.value = value
  updateCanvasHistory()
}

function handleInstructionChange(event: Event) {
  const target = event.target as HTMLTextAreaElement
  instruction.value = target.value
}

function handleInstructionKeyPress(event: KeyboardEvent) {
  if (event.key === 'Enter' && !event.shiftKey) {
    handleButtonClick()
    event.preventDefault()
  }
}

function updateCanvasHistory() {
  canvasHistory.value = canvasHistory.value.slice(0, canvasHistoryIndex.value + 1)
  canvasHistory.value.push(canvas.value)
  canvasHistoryIndex.value = canvasHistory.value.length - 1
}

function stepBackInCanvasHistory() {
  if (canvasHistoryIndex.value > 0) {
    canvasHistoryIndex.value -= 1
    canvas.value = canvasHistory.value[canvasHistoryIndex.value]
  }
}

function stepForwardInCanvasHistory() {
  if (canvasHistoryIndex.value < canvasHistory.value.length - 1) {
    canvasHistoryIndex.value += 1
    canvas.value = canvasHistory.value[canvasHistoryIndex.value]
  }
}

async function fetchResponse(prompt: string) {
  const response = await fetch('http://localhost:11434/api/chat', {
    method: 'POST',
    headers: {
      'Content-Type': 'application/json',
    },
    body: JSON.stringify({
      stream: true,
      model: 'qwen2.5-coder:32b',
      messages: [
        {
          role: 'system',
          content: systemPrompt,
        },
        {
          role: 'user',
          content: prompt,
        },
      ],
    }),
  })
  return response
}

async function parseResponseChunk(
  reader: ReadableStreamDefaultReader<string>,
  responseText: Ref<string>,
  canvas: Ref<string>,
) {
  const { done, value } = await reader.read()
  if (done) {
    return
  }
  const chunk = new TextDecoder('utf-8').decode(value)
  const lines = chunk.split('\n')
  for (const line of lines) {
    try {
      const data = JSON.parse(line)
      if (data.message && data.message.content) {
        responseText.value += data.message.content
        if (responseText.value.includes('<|canvas_start|>')) {
          const endIndex = responseText.value.indexOf('<|canvas_end|>')
          if (endIndex !== -1) {
            canvas.value = responseText.value.slice(
              responseText.value.indexOf('<|canvas_start|>') + '<|canvas_start|>'.length,
              endIndex,
            )
          } else {
            canvas.value = responseText.value.slice(
              responseText.value.indexOf('<|canvas_start|>') + '<|canvas_start|>'.length,
            )
          }
        }
      }
    } catch (error) {
      console.error('Error parsing response chunk:', error)
    }
  }
  await parseResponseChunk(reader, responseText, canvas)
}

async function handleButtonClick() {
  try {
    isRequestActive.value = true
    responseText.value = ''
    const prompt = '<|canvas_start|>' + canvas.value + '<|canvas_end|>\n\n' + instruction.value
    console.log('Prompt', prompt)
    const response = await fetchResponse(prompt)
    const reader = response.body.getReader()
    await parseResponseChunk(reader, responseText, canvas)
    console.log('Response', responseText.value)
    const startIndex = responseText.value.indexOf('<|canvas_start|>') + '<|canvas_start|>'.length
    const endIndex = responseText.value.indexOf('<|canvas_end|>')
    if (startIndex !== -1 && endIndex !== -1) {
      canvas.value = responseText.value.slice(startIndex, endIndex)
      updateCanvasHistory()
    }
    isRequestActive.value = false
  } catch (error) {
    console.error(error)
    isRequestActive.value = false
  }
}
</script>

<template>
  <main class="app">
    <div class="container">
      <div class="content">
        <div class="history-buttons">
          <HistoryButton
            direction="back"
            :disabled="canvasHistoryIndex === 0"
            @stepInCanvasHistory="stepBackInCanvasHistory"
          />
          <span>{{ canvasHistoryIndex }} / {{ canvasHistory.length - 1 }}</span>
          <HistoryButton
            direction="forward"
            :disabled="canvasHistoryIndex === canvasHistory.length - 1"
            @stepInCanvasHistory="stepForwardInCanvasHistory"
          />
        </div>
        <MarkdownEditor
          v-model="canvas"
          @update:modelValue="handleCanvasChange"
          class="markdown-editor"
        ></MarkdownEditor>
      </div>
      <div class="input">
        <textarea
          class="instruction-textarea"
          :value="instruction"
          @input="handleInstructionChange"
          @keypress="handleInstructionKeyPress"
          placeholder="Describe how to refine your document"
        ></textarea>
        <SendButton :isRequestActive="isRequestActive" @handleButtonClick="handleButtonClick" />
      </div>
    </div>
  </main>
</template>

<style scoped>
.app {
  height: 100vh;
  display: flex;
  flex-direction: column;
}

.container {
  padding: 3em;
  padding-top: 1em;
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1em;
}

.content {
  flex: 1;
  display: flex;
  flex-direction: column;
  gap: 1em;
}

.history-buttons {
  display: flex;
  align-items: center;
  justify-content: center;
  gap: 1em;
}

.markdown-editor {
  flex: 1;
}

.input {
  display: flex;
  flex-direction: row;
  gap: 1em;
}

.instruction-textarea {
  flex: 1;
  font-size: 12pt;
  resize: none;
  font-family: 'sans';
  padding: 0.5em;
}

</style>
