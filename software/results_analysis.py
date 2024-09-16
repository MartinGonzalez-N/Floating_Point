import numpy as np
import pandas as pd
import struct
import matplotlib.pyplot as plt
import matplotlib.transforms as transforms
import matplotlib.patches as mpatches
from mpl_toolkits.axes_grid1 import host_subplot
import os
import time
#import mpl_interactions.ipyplot as iplt  interaccion en las graficas
import pandas as pd
import argparse
# read text file into pandas DataFrame

# display DataFrame

def report(seed):
    print("reporting ",seed)
    #paths
    rep_path = "software/fp16_vectors/"+seed
    va_path = rep_path+"/input_a.mem"
    vb_path = rep_path+"/input_a.mem"
    mul_exp_path = rep_path+"/output_mult.mem"
    add_exp_path = rep_path+"/output_add.mem" 
    mul_sim_path = rep_path+"/output_sim_mult.mem"
    add_sim_path = rep_path+"/output_sim_add.mem"
    
    #reading files
    va = pd.read_csv(va_path,names=["va"], sep=' ',dtype=str)
    vb = pd.read_csv(vb_path,names=["vb"], sep=' ',dtype=str)
    mul_exp = pd.read_csv(mul_exp_path,names=["exp"], sep=' ',dtype=str)
    add_exp = pd.read_csv(add_exp_path,names=["exp"], sep=' ',dtype=str)
    mul_sim = pd.read_csv(mul_sim_path,names=["sim"], sep=' ',dtype=str)
    add_sim = pd.read_csv(add_sim_path,names=["sim"], sep=' ',dtype=str)
    df_mul = pd.concat([va,vb,mul_exp,mul_sim],axis=1)
    df_add = pd.concat([va,vb,add_exp,add_sim],axis=1)
    df_add = df_add.head(-1)
    df_mul = df_mul.head(-1)
    df_mul=df_mul.assign(error = lambda x: (x["sim"]!=x["exp"]))
    df_mul = df_mul.loc[df_mul["error"]]
    df_mul["bin_exp"] = df_mul["exp"].apply(lambda x:(bin(int(x,16))[2:].zfill(16)))
    df_mul["bin_sim"] = df_mul["sim"].apply(lambda x:(bin(int(x,16))[2:].zfill(16)))
    df_mul["sign_error"] = df_mul["bin_exp"].str[0] != df_mul["bin_sim"].str[0]
    df_mul["exp_error"] = df_mul["bin_exp"].str[1:6].apply(lambda a:(int(a,2))) - df_mul["bin_sim"].str[1:6].apply(lambda a:(int(a,2)))
    df_mul["man_error"] = df_mul["bin_exp"].str[6:16].apply(lambda a:(int(a,2))) - df_mul["bin_sim"].str[6:16].apply(lambda a:(int(a,2)))
    df_mul = df_mul.drop("bin_exp",axis=1)
    df_mul = df_mul.drop("bin_sim",axis=1)
    df_mul = df_mul.drop("error",axis=1)
    #print(df_mul)
    df_add=df_add.assign(error = lambda x: (x["sim"]!=x["exp"]))
    df_add = df_add.loc[df_add["error"]]
    df_add["bin_exp"] = df_add["exp"].apply(lambda x:(bin(int(x,16))[2:].zfill(16)))
    df_add["bin_sim"] = df_add["sim"].apply(lambda x:(bin(int(x,16))[2:].zfill(16)))
    df_add["sign_error"] = df_add["bin_exp"].str[0] != df_add["bin_sim"].str[0]
    df_add["exp_error"] = df_add["bin_exp"].str[1:6].apply(lambda a:(int(a,2))) - df_add["bin_sim"].str[1:6].apply(lambda a:(int(a,2)))
    df_add["man_error"] = df_add["bin_exp"].str[6:16].apply(lambda a:(int(a,2))) - df_add["bin_sim"].str[6:16].apply(lambda a:(int(a,2)))
    df_add = df_add.drop("bin_exp",axis=1)
    df_add = df_add.drop("bin_sim",axis=1)
    df_add = df_add.drop("error",axis=1)
    #print(df_add)
    df_add.to_csv(rep_path+'/out_add.csv', index=False)
    df_mul.to_csv(rep_path+'/out_mult.csv', index=False)

if __name__ == '__main__':
    #models = [name for name in os.listdir(models_folder) if os.path.isdir(os.path.join(models_folder, name))] can be used to read all vector
    parser = argparse.ArgumentParser(description="argumentos")
    parser.add_argument("seed", type=str, help="random seed")
    #parser.add_argument("--edad", type=int, help="La edad de la persona", default=18)
    args = parser.parse_args()
    report(args.seed)
