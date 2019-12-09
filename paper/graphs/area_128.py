import math

# MODIFY AREA NUMBERS

MERGER_1 = 1016
MERGER_2 = 2210
MERGER_4 = 5604
MERGER_8 = 13051
MERGER_16 = 29970
MERGER_32 = 77732

COUPLER_1 = 576
COUPLER_2 = 1938
COUPLER_4 = 2081
COUPLER_8 = 4142
COUPLER_16 = 8266

FIFO = 134

def get_area(P, L):
    return max(0, (2*L-P))*(MERGER_1+FIFO) \
         + (math.floor(P/2) < L)*math.floor(P/2)*(MERGER_2+2*(COUPLER_1-FIFO)) \
         + (math.floor(P/2) == L)*math.floor(P/2)*MERGER_2 \
         + (math.floor(P/4) < L)*math.floor(P/4)*(MERGER_4+2*COUPLER_2) \
         + (math.floor(P/4) == L)*math.floor(P/4)*MERGER_4 \
         + (math.floor(P/8) < L)*math.floor(P/8)*(MERGER_8+2*COUPLER_4) \
         + (math.floor(P/8) == L)*math.floor(P/8)*MERGER_8 \
         + (math.floor(P/16) < L)*math.floor(P/16)*(MERGER_16+2*COUPLER_8) \
         + (math.floor(P/16) == L)*math.floor(P/16)*MERGER_16 \
         + (math.floor(P/32) < L)*math.floor(P/32)*(MERGER_32+2*COUPLER_16)

def get_optimal(OCMB, Area):
    curr_max = -1;
    max_P = -1
    max_L = -1
    max_C = -1
    for C in [1]:
        for P in [1, 2, 4, 8, 16, 32]:
            for L in [1, 2, 4, 8, 16, 32, 64, 128, 256, 512, 1024]:
                if (C*get_area(P, L) < Area):
                    if (min(OCMB, 4*C*P)*math.log(2*L, 2) > curr_max):
                        curr_max = min(OCMB, 4*C*P)*math.log(2*L, 2)
                        max_P = P
                        max_L = L
                        max_C = C

    return (max_C, max_P, max_L, curr_max)

'''
for P in [1, 2, 4, 8, 16, 32]:
    for L in [1, 2, 4, 8, 16, 32, 64, 128]:
        print("(" + str(P) + ", " + str(L) + "): " + str(get_area(P, L)))
'''

N = 10*2**30/128*8;
for OCMB in [1, 2, 4, 8, 16, 32, 64]:
    for Area in [50000, 75000, 100000, 130000, 150000, 200000]:
        C, P, L, Perf = get_optimal(OCMB, Area)   
        print("("+str(OCMB)+", "+str(Area)+"): C = "+ str(C)+", P = " + str(P) + ", L = " + str(L) +", "+str(4*4*N*math.ceil(math.log(N/C, 2*L))/(2**30*min(4*C*P, OCMB)))) + "sec";


for P in [1, 2, 4, 8, 16, 32]:
    for L in [2, 4, 8, 16, 32, 64, 128]:
        if L >= P:
            print "(P, L) = (" + str(P) + ", " + str(L) + ") -- " + str(get_area(P, L))
