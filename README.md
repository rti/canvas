# Canvas

Prototype to iterate on your markdown documents with LLM support.

## Description
Canvas is a prototype tool designed to facilitate iterative creation and enhancement of Markdown documents. Whether you're working on project documentation, notes, or any form of written content, Canvas might be able to help.

It basically mimics [OpenAI's Canvas](https://openai.com/index/introducing-canvas/) feature, allows it to run on your LLM of choice and adds a change/undo history.

## Tech Stack
Canvas is built using [Vue.js](https://vuejs.org/) and [Marked](https://marked.js.org/). Most of the code is generated using [aider](https://aider.chat/) on a [Llama3.1 (405B/70B)](https://ai.meta.com/blog/meta-llama-3-1/) model.

## Features
- **Lean Interface:** Easy navigation and intuitive design.
- **Real-Time Preview:** See changes instantly as you edit your Markdown files.
- **Undo History:** Revert any change at any time.
- **Runs on local LLMs:** Works on consumer hardware with e.g. [Ollama](https://ollama.com/).

## Demo
https://github.com/user-attachments/assets/55b9c758-b48f-4bbf-9650-492fd867325b

## Installation and Development
As a prototype, Canvas can only be used in dev mode at the moment.

```bash
git clone https://github.com/rti/canvas.git
cd canvas
npm install
npm run dev
```
