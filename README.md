# Canvas

Prototype to iterate on your markdown documents with LLM support.

## Description
Canvas is a prototype tool designed to facilitate iterative creation and enhancement of Markdown documents. Whether you're working on project documentation, notes, or any form of written content, Canvas might be able to help.

It basically mimics [OpenAI's Canvas](https://openai.com/index/introducing-canvas/) feature, allows it to run on your LLM of choice and adds a change/undo history.

## Demo
https://github.com/user-attachments/assets/55b9c758-b48f-4bbf-9650-492fd867325b

## Features
- **Runs on local LLMs:** Works on consumer hardware with e.g. [Ollama](https://ollama.com/).
- **Undo History:** Revert any change at any time.
- **Real-Time Preview:** See changes instantly as you edit your Markdown files.

## How does it work
Canvas connects to your local [Ollama](https://ollama.com/) instance. The LLM is prompted with the current document contents encapsulated in `<|canvas_start|>` and `<|canvas_end|>` tags and instructed via the system prompt to re-generate the document with the requested transformation applied. The returned document is rendered in the interface.

## Tech Stack
Canvas is built using [Vue.js](https://vuejs.org/) and [Marked](https://marked.js.org/). Most of the code is generated using [aider](https://aider.chat/) on a [Llama3.1 (405B/70B)](https://ai.meta.com/blog/meta-llama-3-1/) model.

## Installation and Development
As a prototype, Canvas can only be used in dev mode at the moment.

```bash
git clone https://github.com/rti/canvas.git
cd canvas
npm install
npm run dev
```
