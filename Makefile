.PHONY: run-xor llm-run llm-chat llm-serve

PROMPT ?= Goのinterfaceについて簡潔に説明してください
MODEL ?=

run-xor:
	go run ./cmd/xor

llm-run:
	go tool tensai run -q8 $(if $(MODEL),-model $(MODEL),) "$(PROMPT)"

llm-chat:
	go tool tensai chat -q8 $(if $(MODEL),-model $(MODEL),)

llm-serve:
	go tool tensai serve -q8 $(if $(MODEL),-model $(MODEL),) -addr 127.0.0.1:8080
