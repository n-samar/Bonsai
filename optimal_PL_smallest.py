bandwidth = 40        # Read/write concurrent bandwidth in GB / s
LUTs = 892000         # Number of Look-Up Tables on FPGA


from scipy import optimize
import numpy as np
import math
from mpl_toolkits import mplot3d
import matplotlib.pyplot as plt


bytes_per_elem = 8      # Assuming 64-bit input
N = 4000000000        # Number of array elements to be sorted



bandwidth_elems_per_sec = bandwidth * pow(10, 9) / bytes_per_elem

def area_constraint(P, L):
    return 1024 * (L - P) + 210 * P * math.pow(math.log(P), 2)


def get_frequency(P, L):
    return 150 + 400 * (math.log(4.5 * L)/math.sqrt(4.5 * L))
    
def objective(P, L):
    f = get_frequency(P, L)
    return math.ceil((math.log(L)/math.log(N)) * min(bandwidth_elems_per_sec, pow(10, 6)*P*f))
    
def main():
    max_val = 0.0;
    max_P = -1;
    max_L = -1;
    P_arr = []
    L_arr = []
    val_arr = []    
    for P in [2, 4, 8, 16, 32, 64]:
        L = P
        while area_constraint(P, L) <= LUTs:
            if objective(P, L) > max_val:
                max_P = P
                max_L = L
                max_val = objective(P, L)
            P_arr.append(P)
            L_arr.append(L)            
            val_arr.append(objective(P, L))
            L = L * 2
            
    print "    Input array size = " + str(N*bytes_per_elem/1000000000) + "GB"
    print "    P = " + str(max_P) + " elems/cycle"
    print "    L = " + str(max_L) + " leaves"
    print "    Expected LUTs = " + str(int(round(area_constraint(max_P, max_L)))) + " LUTs"
    print "    Expected Frequency = " + str(round(get_frequency(max_P, max_L), 2)) + " MHz"
    print "    Expected runtime = " + str(N/objective(max_P, max_L)) + "s"
    print "    Expected runtime per stage = " + str(N/(objective(max_P, max_L) * math.log(N)/math.log(max_L))) + "s"


    ax = plt.axes(projection='3d')
    ax.scatter3D(P_arr, L_arr, val_arr, cmap="Greens")
    ax.set_xlabel('P')
    ax.set_ylabel('L')
    ax.set_zlabel('Effective Throughput')
    ax.set_xlim(0, max(P_arr))
    ax.set_ylim(0, max(L_arr))    
    plt.show()

    
if __name__ == "__main__":
    main()
