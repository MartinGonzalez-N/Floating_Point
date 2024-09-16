from results_analysis import report
import argparse
import os

parser = argparse.ArgumentParser(description="argumentos")
parser.add_argument("--vectors_path", type=str, help="relative path", default="software/fp16_vectors")
args = parser.parse_args()
seeds = [name for name in os.listdir(args.vectors_path) if os.path.isdir(os.path.join(args.vectors_path, name))]
for i in seeds:
    if(os.path.isfile(args.vectors_path+"/"+i+"/output_sim_add.mem") and os.path.isfile(args.vectors_path+"/"+i+"/output_sim_mult.mem")):
        report(i)