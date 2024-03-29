TOTAL_NUM_UPDATES=2036
WARMUP_UPDATES=122
LR=2e-05
NUM_CLASSES=2
MAX_SENTENCES=1
ROBERTA_PATH=checkpoint/roberta/rte-no-quant-noise/checkpoint_best.pt
RTE_PATH=RTE-bin/
UPDATE_FREQ=1000000

PYTHONPATH="~/Quant-Noisier/fairseq" python -m fairseq_cli.train $RTE_PATH \
    --restore-file $ROBERTA_PATH \
    --max-positions 512 \
    --batch-size $MAX_SENTENCES \
    --max-tokens 4400 \
    --task sentence_prediction \
    --reset-optimizer --reset-dataloader --reset-meters \
    --required-batch-size-multiple 1 \
    --init-token 0 --separator-token 2 \
    --arch roberta_base \
    --criterion sentence_prediction \
    --num-classes $NUM_CLASSES \
    --dropout 0.1 --attention-dropout 0.1 \
    --weight-decay 0.1 --optimizer adam --adam-betas "(0.9, 0.98)" --adam-eps 1e-06 \
    --clip-norm 0.0 \
    --lr-scheduler polynomial_decay --lr $LR --total-num-update $TOTAL_NUM_UPDATES --warmup-updates $WARMUP_UPDATES \
    --max-epoch 1 \
    --find-unused-parameters \
    --best-checkpoint-metric accuracy --maximize-best-checkpoint-metric \
    --ddp-backend legacy_ddp \
    --update-freq $UPDATE_FREQ \
    --write-losses True \
    --num-workers 0 