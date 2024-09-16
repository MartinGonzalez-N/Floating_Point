import numpy as np
import random
from vector_generator import vector_gen
import argparse

parser = argparse.ArgumentParser(description="argumentos")
parser.add_argument("--num_vectors", type=int, help="numero de vectores a generar", default=10)
args = parser.parse_args()

for i in range(args.num_vectors):
    seed = random.randint(0,1000)
    vector_gen(seed)