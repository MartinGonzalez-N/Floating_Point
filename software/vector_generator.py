#Test vector generator for functional verification of arithmetic unit
'''
Scritp will generate 4 files containing 50k test data vectors:
-Input A vector
-Input B vector
-Output Add vector
-Output Mult vector

Script must consider:
-randomization seed -WIP
-randomization constraints
'''
import random
import numpy as np
import os

#Float to hex function
def float16_to_hex(value):
    if not isinstance(value, np.float16):
        raise TypeError("Value must be of type numpy.float16")
    int_repr = np.frombuffer(np.float16(value).tobytes(), dtype=np.uint16)[0] #fp16 to 16bit binary
    hex_repr = format(int_repr, '04x')  #format '04x' for 4-digit hexadecimal number
    return hex_repr

#Randomization function for data different than +-0  (random != 0+-)  
def fp16_randomize_data_gen(condition):
    while True:
        data_rand_int = random.getrandbits(16)  #generate random 16-bit integer value
        #data_rand = np.float16(np.frombuffer(data_rand_int.to_bytes(), dtype=np.float16)[0])  #convert to float16
        data_rand = np.frombuffer(data_rand_int.to_bytes(2, 'little'), dtype=np.float16)[0]
        if condition(data_rand_int): #will loop until condition random != 0+- is fulfilled 
            return data_rand

#Randomization function
def fp16_generate_data():
    #randomization ranges
    man = random.randint(0,1023)/1024
    exp = random.randint(-14,15)
    full_rand = [np.float16(np.ldexp(random.randint(0,1)+man, exp)),-np.float16(np.ldexp(random.randint(0,1)+man, exp))]
    normal_num = [np.float16(np.ldexp(1+man, exp)),-np.float16(np.ldexp(1+man, exp))]
    subnormal_num = [np.float16(np.ldexp(man, -14)),-np.float16(np.ldexp(man, -14))]
    zero_plus_minus = [np.float16(0.0), np.float16(-0.0)]
    one_plus_minus = [np.float16(1.0), np.float16(-1.0)]
    smallest_subnormal = [np.float16(np.ldexp(1.0/1024, -14)), np.float16(-np.ldexp(1.0/1024, -14))]
    largest_subnormal = [np.float16(np.ldexp(1023/1024, -14)), np.float16(-np.ldexp(1023/1024, -14))]
    smallest_normal = [np.float16(np.ldexp(1.0, -14)), np.float16(-np.ldexp(1.0, -14))]
    largest_normal = [np.float16(np.ldexp(1.0+1023/1024, 15)), np.float16(-np.ldexp(1.0+1023/1024, 15))]
    #largest_normal = [np.float16(np.float16(np.finfo(np.float16).max)), np.float16(-np.float16(np.finfo(np.float16).max))]
    random.randint(0,1023)
    #array of weights for each randomization range
    cases = [
        #(10000, lambda: fp16_randomize_data_gen(lambda x: x != 0x0000 and x != 0x8000)),  # random != 0+-
        (1000, lambda: random.choice(full_rand)),
        (10, lambda: random.choice(subnormal_num)),
        (1000, lambda: random.choice(normal_num)),
        (1, lambda: random.choice(zero_plus_minus)),     # zero+-
        (1, lambda: random.choice(one_plus_minus)),      # one +-
        (1, lambda: random.choice(smallest_subnormal)),  # smallest subnormal (exp == 0)
        (1, lambda: random.choice(largest_subnormal)),   # largest subnormal (exp == 0)
        (1, lambda: random.choice(smallest_normal)),     # smallest normal
        (1, lambda: random.choice(largest_normal)),      # largest normal
    ]
    #choice based on the weights
    weights, actions = zip(*cases)
    action = random.choices(actions, weights=weights)[0]
    data_rand = action() 

    #convert float back to 16-bit integer for bitwise manipulation
    data_rand_int = int.from_bytes(np.float16(data_rand).tobytes(), 'little')
   
    '''
    #To check if directory exists
     def int_to_float16(value):
        return np.frombuffer(value.to_bytes(2, 'little'), dtype=np.float16)[0]
    '''
    
    #If exponent bits are all 1's set mantissa to 0 to get a inf value and to avoid NaN
    if (data_rand_int & 0x7C00) == 0x7C00 or (data_rand_int & 0xFE00) == 0xFE00 :  #if exp == 0x7C
        data_rand_int = data_rand_int & 0x7C00 #mantissa = 0
        data_rand = np.frombuffer(data_rand_int.to_bytes(2, 'little'), dtype=np.float16)[0]

    return data_rand

#MAIN SCRIPT
def vector_gen(seed):
    current_directory = os.getcwd()
    subdirectory = "software/fp16_vectors/" + str(seed)
    try:
        os.mkdir(subdirectory)
    except:
        pass
    file_directory = os.path.join(current_directory, subdirectory)
    input_a_file_path = os.path.join(file_directory, 'input_a.mem')
    input_b_file_path = os.path.join(file_directory, 'input_b.mem')
    output_add_file_path = os.path.join(file_directory, 'output_add.mem')
    output_mult_file_path = os.path.join(file_directory, 'output_mult.mem')

    #Random stimulli vector generator (4 files -> 2 inputs, 1 output & operation)
    with open(input_a_file_path, 'w') as fileA, open(input_b_file_path, 'w') as fileB, open(output_add_file_path, 'w') as fileAdd, open(output_mult_file_path, 'w') as fileMult:
        for _ in range(1000000):
            a_fp16_value = np.float16(fp16_generate_data())
            b_fp16_value = np.float16(fp16_generate_data())
            o_fp16_value_add = a_fp16_value + b_fp16_value
            o_fp16_value_mult = a_fp16_value * b_fp16_value
            a_hex_value = format(int.from_bytes(a_fp16_value.tobytes(), 'little'), '04x')
            b_hex_value = format(int.from_bytes(b_fp16_value.tobytes(), 'little'), '04x')
            o_hex_value_add = format(int.from_bytes(o_fp16_value_add.tobytes(), 'little'), '04x')
            o_hex_value_mult = format(int.from_bytes(o_fp16_value_mult.tobytes(), 'little'), '04x')
            
            fileA.write(f"{a_hex_value}\n")
            fileB.write(f"{b_hex_value}\n")
            fileAdd.write(f"{o_hex_value_add}\n")
            fileMult.write(f"{o_hex_value_mult}\n")

if __name__ == '__main__':
    seed = random.randint(0,1000)
    vector_gen(seed)