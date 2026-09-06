.PHONY: run-xor llm-run llm-run-q8 llm-chat llm-chat-q8 llm-serve llm-serve-q8

PROMPT ?= Goのinterfaceについて簡潔に説明してください
MODEL ?=

run-xor:
	go run ./cmd/xor

llm-run:
	go tool tensai run $(if $(MODEL),-model $(MODEL),) "$(PROMPT)"

llm-run-q8:
	go tool tensai run -q8 $(if $(MODEL),-model $(MODEL),) "$(PROMPT)"

llm-chat:
	go tool tensai chat $(if $(MODEL),-model $(MODEL),)

llm-chat-q8:
	go tool tensai chat -q8 $(if $(MODEL),-model $(MODEL),)

llm-serve:
	go tool tensai serve $(if $(MODEL),-model $(MODEL),) -addr 127.0.0.1:8080

llm-serve-q8:
	go tool tensai serve -q8 $(if $(MODEL),-model $(MODEL),) -addr 127.0.0.1:8080
