#!/usr/local_rwth/bin/zsh
 
### #SBATCH directives need to be in the first part of the jobscript

### Job name
#SBATCH --job-name=acml2

### Output path for stdout and stderr
### %J is the job ID, %I is the array ID
#SBATCH --output=output_%J.txt

### Request the time you need for execution. The full format is D-HH:MM:SS
### You must at least specify minutes OR days and hours and may add or
### leave out any other parameters
#SBATCH --time=5-00:00:00

### Request the amount of memory you need for your job.
### You can specify this in either MB (1024M) or GB (4G).
#SBATCH --mem-per-cpu=16G
#SBATCH --gres=gpu:volta:1

### if needed: switch to your working directory (where you saved your program)
cd $HOME/midi-rnn/

### Load modules
module switch intel gcc
module load python/3.6.8
module load cuda/100
module load cudnn/7.4
pip install --user -r requirements.txt

### your code goes here, the second part of the jobscript
python3 train_gpu.py --rnn_size 64 --num_layers 1 --window_size 20 --batch_size 32 --num_epochs 10 --dropout 0.2 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25
python3 train_gpu.py --rnn_size 128 --num_layers 1 --window_size 64 --batch_size 32 --num_epochs 50 --dropout 0.2 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25
python3 train_gpu.py --rnn_size 256 --num_layers 2 --window_size 256 --batch_size 32 --num_epochs 100 --dropout 0.5 --grad_clip 5 --n_jobs 1 --max_files_in_ram 25

python3 sample.py --experiment_dir experiments/01
python3 sample.py --experiment_dir experiments/02
python3 sample.py --experiment_dir experiments/03