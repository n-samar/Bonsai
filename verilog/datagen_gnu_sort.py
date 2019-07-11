import random

leaf_cnt = 8
elems_per_run_per_leaf = 128
total_runs = 1
elems_per_leaf = total_runs * elems_per_run_per_leaf
N = leaf_cnt*elems_per_leaf
output_elems_per_line = 4
input_elems_per_line = 1
seed_val = 1

random.seed(seed_val)
input_dict = []

input_file = open("gnu_data_" + str(leaf_cnt) + "_" + str(total_runs) + "_" + str(elems_per_run_per_leaf) + "_" + str(input_elems_per_line) + "_" + str(output_elems_per_line) + ".txt", "w+")


for i in range(0, N):
    key = random.randint(0, 2**80)
    value = random.randint(0, 2**48)
    input_file.write(format(value, '015d') + ' ' + format(key, '025d'))
    if (i%input_elems_per_line == input_elems_per_line - 1):
        input_file.write('\n')

input_file.close()