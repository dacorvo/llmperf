#!/bin/bash

model=${1:-meta-llama/Llama-2-7b-chat-hf}
vu=${2:-1}

export OPENAI_API_KEY=EMPTY
export OPENAI_API_BASE="http://localhost:8000/v1;http://localhost:8001/v1;http://localhost:8002/v1"

max_requests=$(expr ${vu} \* 8 )
date_str=$(date '+%Y-%m-%d-%H-%M-%S')

python ./token_benchmark_ray.py \
       --model ${model} \
       --mean-input-tokens 1500 \
       --stddev-input-tokens 150 \
       --mean-output-tokens 245 \
       --stddev-output-tokens 20 \
       --max-num-completed-requests ${max_requests} \
       --timeout 7200 \
       --num-concurrent-requests ${vu} \
       --results-dir "vllm_bench_results/${date_str}" \
       --llm-api openai \
       --additional-sampling-params '{}'
