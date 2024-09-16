import numpy as np
import random

def fp16_randomize_data_gen(condition):
    while True:
        data_rand_int = random.getrandbits(16)  #generate random 16-bit integer value
        #data_rand = np.float16(np.frombuffer(data_rand_int.to_bytes(), dtype=np.float16)[0])  #convert to float16
        print(data_rand_int.to_bytes(2, 'little'))
        data_rand = np.frombuffer(data_rand_int.to_bytes(2, 'little'), dtype=np.float16)[0]
        if condition(data_rand_int): #will loop until condition random != 0+- is fulfilled 
            return data_rand
        
#fp16_randomize_data_gen()
print(fp16_randomize_data_gen(lambda x: x != 0x0000 and x != 0x8000))