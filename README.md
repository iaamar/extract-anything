# Extract Anything

Adapted from https://github.com/BoundaryML/baml-examples/tree/hellovai/extract-anything

Mainly with a modal deployment of llama-3.2-11b for extraction

## Details

BAML can be leveraged to build a pipeline that can extract anything
without knowing the schema in advance.

This is done via 2 steps:

1. Ask an LLM to describe a schema that could represent the content of the document.

2. Use the schema to extract the content by leveraging dyanmic types.

## Architecture

Backend is python + FASTAPI + BAML (+ modal for serving an vision LLM)

Frontend is React

We try and stream whatever possible!

## Setup
* run `make setup` (make sure you have `uv` and `npm` installed)
* install the baml vscode extension (at the version of baml you have installed. They must match!)
* create a modal account and login: `uv run modal setup` and `uv run modal token new`
* run `make modal-deploy` to deploy your LLM 
* go to [clients.baml](./baml_src/clients.baml) and update the value for `YOUR_MODAL_APP_URL` with the url provided to your app (should be something like `https://{your-modal-account-name}--llama-3-2-11b-vision-serve.modal.run`). Keep the `/v1` in the url in clients.baml