import random

leaf_cnt = 8
elems_per_run_per_leaf = 32
total_runs = 8
elems_per_leaf = total_runs * elems_per_run_per_leaf
N = leaf_cnt*elems_per_leaf
output_elems_per_line = 4
input_elems_per_line = 1
seed_val = 1

random.seed(seed_val)
input_dict = []

input_file = open("data_" + str(leaf_cnt) + "_" + str(total_runs) + "_" + str(elems_per_run_per_leaf) + "_" + str(input_elems_per_line) + "_" + str(output_elems_per_line) + ".txt", "w+")
ans_file = open("ans_" + str(leaf_cnt) + "_" + str(total_runs) + "_" + str(elems_per_run_per_leaf) + "_" + str(input_elems_per_line) + "_" + str(output_elems_per_line) + ".txt", "w+")


for i in range(0, N):
    key = random.randint(0, 2**80)
    value = random.randint(0, 2**48)
    input_dict.append((key, value))

for i in range(0, total_runs):
    for leaf_index in range(0, leaf_cnt):    
        input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf] = sorted(input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf], key=lambda x: x[0]);

for i in range(0, N):
    (key, value) = input_dict[(i/input_elems_per_line+1)*input_elems_per_line-i%input_elems_per_line-1]
    input_file.write(format(value, '012x') + format(key, '020x'))
    if (i%input_elems_per_line == input_elems_per_line - 1):
        input_file.write('\n')
    if (i%elems_per_run_per_leaf == elems_per_run_per_leaf - 1):
        input_file.write(input_elems_per_line*32*'0' + "\n")

output_dict = []
for i in range(0, total_runs):
    run_input = []
    for leaf_index in range(0, leaf_cnt):
        run_input += input_dict[(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf:(total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf];
        # print(str((total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf) + " - " + str((total_runs*elems_per_run_per_leaf)*leaf_index + i*elems_per_run_per_leaf  + elems_per_run_per_leaf))
    output_dict += (sorted(run_input, key=lambda x: x[0]))



for i in range(0, N):
    key = output_dict[(i/output_elems_per_line+1)*output_elems_per_line-i%output_elems_per_line-1][0]
    value = output_dict[(i/output_elems_per_line+1)*output_elems_per_line-i%output_elems_per_line-1][1]
    ans_file.write(format(value, '012x') + format(key, '020x'))
    if (i%output_elems_per_line == output_elems_per_line - 1):
        ans_file.write('\n')
    if (i%(elems_per_run_per_leaf*leaf_cnt) == elems_per_run_per_leaf*leaf_cnt - 1):
        ans_file.write(output_elems_per_line*32*'0' + "\n")        

ans_file.close()
input_file.close()
