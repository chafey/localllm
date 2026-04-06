docker run -it --rm  \
--entrypoint /bin/bash \
--device nvidia.com/gpu=all \
--ipc=host     \
--shm-size=8g   \
--ulimit memlock=-1     \
--ulimit stack=67108864  \
--network host     \
-e NCCL_P2P_LEVEL=4 \
-e NCCL_IB_DISABLE=1 \
-e OMP_NUM_THREADS=8 \
-v ~/.cache/huggingface:/root/.cache/huggingface \
-v ~/localllm:/workspace/localllm     \
voipmonitor/vllm:cu130-b12x-full
