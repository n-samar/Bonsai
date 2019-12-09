import math
import matplotlib.pyplot as plt

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

def get_optimal(OCMB, Area):
    curr_max = pow(10., 10);
    max_P = -1
    max_L = -1
    max_C = -1
    for C in [1]:
        for P in [1, 2, 4, 8, 16, 32]:
            for L in [1, 2, 4, 8, 16, 32, 64, 128]:
                if L >= P:
                    if (C*get_area(P, L) < Area):
                        curr = N/min(OCMB*pow(10., 9)/4., P*f)*(math.ceil(math.log(N)/math.log(2*L) - 1) + 1)
                        if (curr < curr_max):
                            curr_max = curr
                            max_P = P
                            max_L = L
                            max_C = C

    return (max_C, max_P, max_L, curr_max)

N = 16*2**30/4   # 16 GiB
print("Theoretical performance at 16 GiB")
d = {}
for L in [2, 4, 8, 16, 32, 64, 128]:
    d[L] = []    
    for P in [1, 2, 4, 8, 16, 32]:
        d[L].append((16.0/(N/(P*f)*(math.ceil(math.log(N)/math.log(2*L) - 1) + 1)))/get_area(P, L)*pow(10., 5))
        print "P = " + str(P) + ", L = " + str(L) + ": " + str(16.0/(N/(P*f)*(math.ceil(math.log(N)/math.log(2*L) - 1) + 1))/get_area(P, L)) + " GiB/s"

a = ['b.', 'r+', 'gv', 'mx', '^', 's', '<']
        
for L in sorted([2, 4, 8, 16, 32, 64, 128], reverse=True):
    plt.plot([1, 2, 4, 8, 16, 32], d[L], a[int(math.log(L)/math.log(2))-1], label="L = " + str(L))
plt.xscale('log', basex=2)
plt.xlabel('Tree Throughput P (log scale)')
plt.ylabel('End-to-End Throughput per LUT x10^(-6) [GiB/s/LUT]')
plt.legend()
plt.show()    
'''
for N in [1*268435456, 2*268435456, 4*268435456, 8*268435456, 50*268435456, 100*268435456, 512*268435456, 1024*1*268435456, 10240*1*268435456]:
    for Area in [300000]:    
        for OCMB in [1, 2, 4, 8, 16, 32]:
            C, P, L, Perf = get_optimal(OCMB, Area)
            area = get_area(P, L)
            print("N = " + str(N/268435456.) + "GB, OCMB = " + str(OCMB) + ", LUTs = "+str(area)+"): P = " + str(P) + ", L = " + str(L) +", "+str(Perf) + "sec");
'''
