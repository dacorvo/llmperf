#!/bin/bash

model=${1:-meta-llama/Llama-2-7b-chat-hf}

for vu in 1 2 4 8 16 32 64 128 256 512; do
    ./vllm_benchmark.sh ${model} ${vu}
done
