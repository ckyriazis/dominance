#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/dominance_inference
#$ -l h_rt=100:59:00,h_data=8G,highp
#$ -o /u/home/c/ckyriazi/project-klohmuel/dominance_inference/logfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/dominance_inference/logfiles
#$ -N dominance_h0.30_s0.25
#$ -m ae



source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate dominance

python run_DFE_inference_s0.25.py 0.30 /u/home/c/ckyriazi/project-klohmuel/dominance_inference/data/1kG_syn.csv /u/home/c/ckyriazi/project-klohmuel/dominance_inference/data/1kG_nonsyn.csv



