BURST_SIZE = 16
LEAF_CNT = 4
ARRAY_SIZE = 2*8192

for i in range(ARRAY_SIZE-2*BURST_SIZE*LEAF_CNT):
    print (((i/BURST_SIZE)%LEAF_CNT)*ARRAY_SIZE/LEAF_CNT + BURST_SIZE*(i/LEAF_CNT/BURST_SIZE) + i%BURST_SIZE);

    