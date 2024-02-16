#! /bin/bash
#$ -wd /u/home/c/ckyriazi/project-klohmuel/dominance_inference
#$ -l highp,h_rt=100:00:00,h_data=16G
#$ -o /u/home/c/ckyriazi/project-klohmuel/dominance_inference/logfiles
#$ -e /u/home/c/ckyriazi/project-klohmuel/dominance_inference/logfiles
#$ -N dominance_hs
#$ -m ae



source /u/home/c/ckyriazi/miniconda2/etc/profile.d/conda.sh
conda activate dominance

#python permute_h_values.py

# run huber model - values for each bin estimated as middle of each bin from
# inverse model: 1/(1-41225.56*s)
# see Huber et al. 2018 Table S3
# yields h values: 0.000485 0.00483 0.0463 0.327 0.829
# which we then round to numbers where we have already computed spectra
python run_DFE_inference_hs.py 0.00 0.00 0.04 0.30 0.80


 


