#train
#bash training_scripts/single_gpu/run_LoRA.sh /apdcephfs_cq3/share_2973545/curvasong/test/output_models/llama/output-lora 3 /apdcephfs_cq3/share_2973545/curvasong/pretrain_model/LLAMA/llama-7b-hf /apdcephfs_cq3/share_2973545/curvasong/dataset/belle/belleMath-dev1K.json

#predict
python3 prompt_eval.py \
    --model_name_or_path /apdcephfs_cq3/share_2973545/curvasong/pretrain_model/LLAMA/llama-7b-hf \
    --finetuned_model_name_or_path /apdcephfs_cq3/share_2973545/curvasong/pretrain_model/LLAMA/llama-7b-hf \
    --test_file /apdcephfs_cq3/share_2973545/curvasong/dataset/belle/multiturn_chat_0.8M/multiturn_chat_50_conv.json \
    --predictions_file /apdcephfs_cq3/share_2973545/curvasong/test/predictions_chat50.json