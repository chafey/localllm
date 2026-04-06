vllm serve Sehyo/Qwen3.5-122B-A10B-NVFP4 \
--host 0.0.0.0 \
--port 8000 \
--tensor-parallel-size 2 \
--served-model-name Qwen35
