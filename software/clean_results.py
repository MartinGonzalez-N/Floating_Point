from results_analysis import report
import argparse
import os

parser = argparse.ArgumentParser(description="argumentos")
parser.add_argument("--vectors_path", type=str, help="relative path", default="software/fp16_vectors")
args = parser.parse_args()
seeds = [name for name in os.listdir(args.vectors_path) if os.path.isdir(os.path.join(args.vectors_path, name))]
for i in seeds:
    seed_path = args.vectors_path+"/"+i
    if(os.path.exists(seed_path+"/output_sim_add.mem")):
        os.remove(seed_path+"/output_sim_add.mem")
    if(os.path.exists(seed_path+"/output_sim_mult.mem")):
        os.remove(seed_path+"/output_sim_mult.mem")
    if(os.path.exists(seed_path+"/out_add.csv")):
        os.remove(seed_path+"/out_add.csv")
    if(os.path.exists(seed_path+"/out_mult.csv")):
        os.remove(seed_path+"/out_mult.csv")