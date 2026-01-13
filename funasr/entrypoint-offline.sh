#!/bin/bash

set -e
cd /workspace/FunASR/runtime
nohup bash run_server.sh \
  --download-model-dir /workspace/models \
  --model-dir damo/speech_paraformer-large-vad-punc_asr_nat-zh-cn-16k-common-vocab8404-onnx \
  \
  --vad-dir damo/speech_fsmn_vad_zh-cn-16k-common-onnx \
  --punc-dir damo/punc_ct-transformer_cn-en-common-vocab471067-large-onnx \
  --itn-dir thuduj12/fst_itn_zh \
  --lm-dir damo/speech_ngram_lm_zh-cn-ai-wesp-fst \
  --certfile /workspace/FunASR/runtime/ssl_key/server.crt \
  --keyfile /workspace/FunASR/runtime/ssl_key/server.key \
  --hotword /workspace/FunASR/runtime/websocket/hotwords.txt > log.txt 2>&1 &
tail -n +1 -f log.txt
