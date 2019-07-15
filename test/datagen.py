import math
import random
import argparse

parser = argparse.ArgumentParser(description='Generates input data for sorting.')
parser.add_argument('--seed', type=int, help='seed for the random library')
parser.add_argument('--key_bits', type=int, help='number of key bits in each element')
parser.add_argument('--value_bits', type=int, help='number of value bits in each element')
parser.add_argument('--leaf_count', type=int, help='number of leaves in the merge tree')
parser.add_argument('--runs', type=int, help="number of `runs'")
parser.add_argument('--elems_per_run', type=int, help="number of elements per run per leaf")
parser.add_argument('--o_elems_per_line', type=int, help="number of output elements per line")
parser.add_argument('--i_elems_per_line', type=int, help="number of input elements per line")

args = parser.parse_args()
seed_val = args.seed

leaf_cnt = args.leaf_count
elems_per_run_per_leaf = args.elems_per_run
total_runs = args.runs
elems_per_leaf = total_runs * elems_per_run_per_leaf
N = leaf_cnt*elems_per_leaf
output_elems_per_line = args.o_elems_per_line
input_elems_per_line = args.i_elems_per_line


key_bits = args.key_bits
value_bits = args.value_bits

random.seed(seed_val)
input_dict = []

input_file = open("data_" + str(leaf_cnt) + "_" + str(total_runs) + "_" + str(elems_per_run_per_leaf) + "_" + str(input_elems_per_line) + "_" + str(output_elems_per_line) + str(key_bits + value_bits) + "b.txt", "w+")
ans_file = open("ans_" + str(leaf_cnt) + "_" + str(total_runs) + "_" + str(elems_per_run_per_leaf) + "_" + str(input_elems_per_line) + "_" + str(output_elems_per_line) + str(key_bits + value_bits) + "b.txt", "w+")


for i in range(0, N):
    key = random.randint(0, 2**key_bits)
    value = random.randint(0, 2**value_bits)
    input_dict.append((key, value))

for i in range(0, total_runs):
    for leaf_index in range(0, leaf_cnt):    
        input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf] = sorted(input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf], key=lambda x: x[0])

for i in range(0, N):
    (key, value) = input_dict[(i/input_elems_per_line+1)*input_elems_per_line-i%input_elems_per_line-1]
    input_file.write((format(value, '0' + str(int(math.ceil(value_bits/4.0))) + 'x') if (value_bits > 0)  else '') + format(key, '0' + str(int(math.ceil(key_bits/4.0))) + 'x'))
    if (i%input_elems_per_line == input_elems_per_line - 1):
        input_file.write('\n')
    if (i%elems_per_run_per_leaf == elems_per_run_per_leaf - 1):
        input_file.write(input_elems_per_line*(key_bits+value_bits)/4*'0' + "\n")

output_dict = []
for i in range(0, total_runs):
    run_input = []
    for leaf_index in range(0, leaf_cnt):
        run_input += input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf];        
    output_dict += (sorted(run_input, key=lambda x: x[0]))



for i in range(0, N):
    key = output_dict[(i/output_elems_per_line+1)*output_elems_per_line-i%output_elems_per_line-1][0]
    value = output_dict[(i/output_elems_per_line+1)*output_elems_per_line-i%output_elems_per_line-1][1]
    ans_file.write((format(value, '0' + str(int(math.ceil(value_bits/4.0))) + 'x') if (value_bits > 0)  else '') + format(key, '0' + str(int(math.ceil(key_bits/4.0))) + 'x'))
    if (i%output_elems_per_line == output_elems_per_line - 1):
        ans_file.write('\n')
    if (i%(elems_per_run_per_leaf*leaf_cnt) == elems_per_run_per_leaf*leaf_cnt - 1):
        ans_file.write(output_elems_per_line*(key_bits+value_bits)/4*'0' + "\n")        

ans_file.close()
input_file.close()
