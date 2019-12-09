import math


f = 250. * pow(10, 6) # Hz
N = 2684354560       # 10 GB of 32-bit elements

# MODIFY AREA NUMBERS

MERGER_1 = 290
MERGER_2 = 622
MERGER_4 = 1555
MERGER_8 = 3620
MERGER_16 = 8500
MERGER_32 = 18853

COUPLER_1 = 142
COUPLER_2 = 273
COUPLER_4 = 530
COUPLER_8 = 1047
COUPLER_16 = 2049

FIFO = 50

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

def get_optimal(OCMB, Area, N, num_stages = None):
    curr_max = pow(10., 10);
    max_P = -1
    max_L = -1
    max_C = -1
    for C in [1]:
        for P in [1, 2, 4, 8, 16, 32]:
            for L in [1, 2, 4, 8, 16, 32, 64, 128]:
                if (C*get_area(P, L) < Area):
                    curr = 0;
                    if num_stages == None:
                        curr = N/min(OCMB*pow(2., 30)/4, P*f)*(math.ceil(math.log(N)/math.log(2*L) - 1) + 1)
                    else:
                        curr = N/min(OCMB*pow(2., 30)/4, P*f)*num_stages                        
                    if (curr < curr_max):
                        curr_max = curr
                        max_P = P
                        max_L = L
                        max_C = C

    return (max_C, max_P, max_L, curr_max)

'''
for P in [1, 2, 4, 8, 16, 32]:
    for L in [1, 2, 4, 8, 16, 32, 64, 128]:
        print("(" + str(P) + ", " + str(L) + "): " + str(get_area(P, L)))
'''
for N in [268435456/4, 268435456/2, 1*268435456, 2*268435456, 4*268435456, 8*268435456, 10*268435456, 20*268435456, 50*268435456, 80*268435456, 100*268435456, 200*268435456, 512*268435456, 1024*268435456, 10*1024*268435456, 100*1024*268435456]:
    for OCMB in [1, 2, 4, 8, 16]:
        for Area in [300000]:
            C, P, L, DRAM_Perf = get_optimal(OCMB*4, Area, N/128)
            _, P_2, L_2, Perf = get_optimal(OCMB, Area, N)
            DRAM_Perf = 128*DRAM_Perf
            Perf = Perf*min(OCMB*pow(2., 30)/4, P*f)/(math.ceil(math.log(N)/math.log(2*L) - 1) + 1)
            print("N = " + str(N/268435456.) + "GB, OCMB = " + str(OCMB) + ", LUTs = "+str(Area)+"): P_DRAM = " + str(P) + ", L_DRAM = " + str(L) +", P_Flash = " + str(P_2) + ", L_Flash = " + str(L_2) +", "+str(Perf+DRAM_Perf+0.2) + "sec");
            
