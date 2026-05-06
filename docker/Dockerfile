FROM vllm/vllm-openai:v0.20.1
#FROM vllm/vllm-openai:v0.19.1-cu130
#FROM vllm/vllm-openai:cu130-nightly

# Add custom MOE config for RTX PRO 6000 MaxQ
COPY "E=256,N=512,device_name=NVIDIA_RTX_PRO_6000_Blackwell_Max-Q_Workstation_Edition.json" "/usr/local/lib/python3.12/dist-packages/vllm/model_executor/layers/fused_moe/configs/E=256,N=512,device_name=NVIDIA_RTX_PRO_6000_Blackwell_Max-Q_Workstation_Edition.json"

# Default entrypoint runs vLLM
ENTRYPOINT ["vllm", "serve"]
