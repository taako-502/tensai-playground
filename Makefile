.PHONY: install run-xor llm-run llm-chat llm-serve

PROMPT ?= Goのinterfaceについて簡潔に説明してください
MODEL ?=

install:
	go install github.com/mattn/tensai/cmd/tensai@v0.0.26

run-xor:
	go run ./cmd/xor

llm-run:
	tensai run -q8 $(if $(MODEL),-model $(MODEL),) "$(PROMPT)"

llm-chat:
	tensai chat -q8 $(if $(MODEL),-model $(MODEL),)

llm-serve:
	tensai serve -q8 $(if $(MODEL),-model $(MODEL),) -addr 127.0.0.1:8080
