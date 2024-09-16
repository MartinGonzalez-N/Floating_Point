import argparse
import subprocess
import os
import time as t
#...

def cmd(command):
    process=subprocess.Popen(command, shell=True)
    process.communicate()
    #process2=subprocess.Popen("make sim ps1", shell=True)
    #process2.communicate()
    #print ([name for name in os.listdir('.') if os.path.isdir(name)])

if __name__ == '__main__':
    os.chdir("work")
    parser = argparse.ArgumentParser(description="argumentos")
    parser.add_argument("--vectors_path", type=str, help="work relative path", default="../software/fp16_vectors")
    parser.add_argument("--tb", type=str, help="tb name", default="tb_fp16")
    args = parser.parse_args()
    seeds = [name for name in os.listdir(args.vectors_path) if os.path.isdir(os.path.join(args.vectors_path, name))]
    inicio = t.time()
    for seed in seeds:
        if(not(os.path.isfile(args.vectors_path+"/"+seed+"/output_sim_add.mem") and os.path.isfile(args.vectors_path+"/"+seed+"/output_sim_mult.mem"))):
            cmd("Makefile sim "+args.tb+" "+seed)
    fin = t.time()
    print(fin - inicio)