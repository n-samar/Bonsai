import math
import pandas as pd
import numpy as np
import seaborn as sns
import matplotlib.pyplot as plt
from matplotlib.colors import LogNorm


cbar_ticks = [math.pow(2, i) for i in range(1, 13)]

def heatmap():
    sns.set()
    fig = plt.figure()
    P_axis = [9, 8, 8, 7]
    L_axis = [11, 10, 9, 9]    
    for C in [1]:
        ax = fig.add_subplot(1, 1, C)
        P = np.arange(0, P_axis[C-1], 1)  
        L = np.arange(0, L_axis[C-1], 1)
        PP, LL = np.meshgrid(P, L, sparse=True)
        LL = LL[::-1]
        z = np.log(C*np.maximum(0, 2**PP * np.log(2*2**LL)))/math.log(2)
        w = np.log(C*((2*2**LL-2**PP)*370 + np.floor(2**PP/2)*(622+142) + np.floor(2**PP/4)*(1555+273) + np.floor(2**PP/8)*(3620+530) + np.floor(2**PP/16)*(8500+1047) + np.floor(2**PP/32)*18853))/math.log(2)
        ax = sns.heatmap(w, yticklabels=range(L_axis[C-1]-1,-1,-1))
        ax.contour(w, levels=[math.log(200000, 2)], colors=['black'])
    plt.show()


heatmap()
