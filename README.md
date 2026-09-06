# tensai-playground

[mattn/tensai](https://github.com/mattn/tensai)を使って、純Goの機械学習とローカルLLMを試すためのリポジトリです。

## 必要な環境

- Go 1.27以降
- ローカルLLMを実行する場合は数GB以上の空きストレージ

## 機械学習サンプル

公開ライブラリAPIを使い、ニューラルネットワークにXORを学習させます。

```bash
make run-xor
```

実行結果の例：

```text
XOR predictions
0 XOR 0 = 0.0000 (expected 0)
0 XOR 1 = 1.0000 (expected 1)
1 XOR 0 = 1.0000 (expected 1)
1 XOR 1 = 0.0000 (expected 0)
```

学習結果にはわずかな誤差があるため、実際の数値は例と異なります。

## ローカルLLM

### 単発実行

```bash
make llm-run
```

初回は既定モデルがユーザーキャッシュディレクトリへダウンロードされます。プロンプトは変更できます。

```bash
make llm-run PROMPT="GoでCQRSを採用する条件を説明してください"
```

ローカルのGGUFモデルを指定する場合：

```bash
make llm-run MODEL=./models/model.gguf PROMPT="こんにちは"
```

### 対話モード

```bash
make llm-chat
```

### OpenAI互換API

```bash
make llm-serve
```

別のターミナルからリクエストします。

```bash
curl http://127.0.0.1:8080/v1/chat/completions \
  -H 'Content-Type: application/json' \
  -d '{
    "model": "local",
    "messages": [
      {"role": "user", "content": "Goについて説明してください"}
    ]
  }'
```

## モデルについて

- モデルファイルは容量が大きいためGitで管理しません。
- モデルごとのライセンスと利用条件を確認してください。
