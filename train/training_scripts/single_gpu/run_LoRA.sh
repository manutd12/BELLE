#!/bin/bash
# Copyright (c) Microsoft Corporation.
# SPDX-License-Identifier: Apache-2.0

# DeepSpeed Team
#facebook/opt-1.3b
# Note that usually LoRA needs to use larger learning rate
#/nfs/v100-022/jiyunjie/anaconda3/envs/llamalora/
#export LD_LIBRARY_PATH=$LD_LIBRARY_PATH:/nfs/v100-022/jiyunjie/anaconda3/envs/llamalora/lib/

OUTPUT_PATH=$1
ZERO_STAGE=$2
model_name_or_path=$3
sft_only_data_path=$4

#rm -rf output/
#mkdir -p $OUTPUT_PATH
echo $OUTPUT_PATH
echo $ZERO_STAGE


lora_module_name="q_proj,k_proj,v_proj,o_proj,down_proj,gate_proj,up_proj"
# If the model is Bloom, lora_module_name should be 
# model_name_or_path=/workspace/model_name_or_path/bloomz-7b1-mt
# lora_module_name="query_key_value,mlp"

echo ${lora_module_name}
#echo ${model_name_or_path}

deepspeed --num_gpus 1 main.py \
   --sft_only_data_path $sft_only_data_path \
   --data_split 10,0,0 \
   --model_name_or_path $model_name_or_path \
   --per_device_train_batch_size 2 \
   --per_device_eval_batch_size 1 \
   --max_seq_len 64 \
   --learning_rate 3e-4 \
   --weight_decay 0. \
   --num_train_epochs 2 \
   --gradient_accumulation_steps 1 \
   --lr_scheduler_type cosine \
   --num_warmup_steps 100 \
   --seed 1234 \
   --gradient_checkpointing \
   --zero_stage $ZERO_STAGE \
   --lora_dim 16 \
   --lora_alpha 16 \
   --lora_droppout 0.05 \
   --lora_module_name ${lora_module_name} \
   --deepspeed \
   --output_dir $OUTPUT_PATH \
   # &> $OUTPUT_PATH/training.log
