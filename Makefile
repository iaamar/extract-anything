export VIRTUAL_ENV=.venv

.PHONY: baml-compile
baml-compile:
	uv run baml-cli generate --from ./baml_src

setup:
	uv venv && source .venv/bin/activate
	uv sync --project backend --active
	npm install -g pnpm
	npm install next react react-dom
	(cd frontend && npm install)
	HOMEBREW_NO_AUTO_UPDATE=1 brew install poppler
	make baml-compile

ui:
	(cd frontend && npm run dev)

server:
	uv run python backend/server.py

modal-auth:
	uv run modal setup
	uv run modal token new

modal-deploy-llama:
	uv run modal deploy llama_modal/llama_3_2_11b.py
