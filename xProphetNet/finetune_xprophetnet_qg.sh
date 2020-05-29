DATA_DIR=./finetune_data/QG_processed_en
USER_DIR=./prophetnet
ARCH=ngram_transformer_prophet_large
CRITERION=ngram_language_loss
SAVE_DIR=./models/xprophetnet_qg_en
TENSORBOARD_LOGDIR=./models/logs_xprophetnet_qg_en
PRETRAINED_MODEL=./models/checkpoint_12_350000.pt

fairseq-train \
	--user-dir $USER_DIR --task translation_prophetnet --arch $ARCH \
	--optimizer adam --adam-betas '(0.9, 0.999)' --clip-norm 0.1 \
	--lr 0.00001 \
	--lr-scheduler inverse_sqrt --warmup-init-lr 1e-07 --warmup-updates 1000 \
	--dropout 0.1 --attention-dropout 0.1 --weight-decay 0.01 \
	--criterion $CRITERION --label-smoothing 0.1 \
	--update-freq 64  --max-sentences 4 \
	--num-workers 4 --load-from-pretrained-model $PRETRAINED_MODEL \
	--ddp-backend=no_c10d --max-epoch 20 \
	--max-source-positions 512 --max-target-positions 512 \
	--skip-invalid-size-inputs-valid-test \
	--seed 1 \
	--save-dir $SAVE_DIR \
	--keep-last-epochs 20 \
	--tensorboard-logdir $TENSORBOARD_LOGDIR \
	$DATA_DIR
