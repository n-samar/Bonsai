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
    P_axis = [9, 8, 7, 7]
    L_axis = [12, 11, 10, 10]    
    for C in [1, 2, 3, 4]:
        ax = fig.add_subplot(2, 2, C)
        P = np.arange(1, P_axis[C-1], 1)  
        L = np.arange(1, L_axis[C-1], 1)
        PP, LL = np.meshgrid(P, L, sparse=True)
        LL = LL[::-1]
        z = np.log(C*np.maximum(0, 2**PP * np.log(2*2**LL)))/math.log(2)

        P = np.arange(0, P_axis[C-1], 1)  
        L = np.arange(0, L_axis[C-1], 1)
        PP, LL = np.meshgrid(P, L, sparse=True)
        LL = LL[::-1]        
        w = C*((2*2**LL-2**PP)*370 + np.floor(2**PP/2)*(622+142) + np.floor(2**PP/4)*(1555+273) + np.floor(2**PP/8)*(3620+530) + np.floor(2**PP/16)*(8500+1047) + np.floor(2**PP/32)*18853)
        ax = sns.heatmap(z, vmin=0, vmax=11, yticklabels=range(L_axis[C-1]-1,0,-1), xticklabels=range(1, P_axis[C-1]))
        ax.contour(w, levels=[200000], colors=['black', 'blue', 'black', 'magenta'])
        ax.title.set_text('Merge Tree Count = ' + str(C))        
        ax.set_xlabel('log(P)')
        ax.set_ylabel('log(L)')
    plt.subplots_adjust(hspace=0.5, wspace=0.2)
    plt.show()


heatmap()
