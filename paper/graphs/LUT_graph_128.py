import matplotlib.pyplot as plt
import seaborn as sns

LUT = {}
data_1 = {1: 1016, 2: 3324, 4: 7925, 8: 17151, 16: 35628, 32: 72533, 64: 146262}
L_1 = sorted(list(data_1.keys()))
LUT[1] = [x/1000 for x in sorted(list(data_1.values()))]

data_2 = {1: 2210, 2: 4207, 4: 9990, 8: 19222, 16: 37596, 32: 74418, 64: 147973}
L_2 = sorted(list(data_2.keys()))
LUT[2] = [x/1000 for x in sorted(list(data_2.values()))]

data_4 = {1: 5604, 2: 6841, 4: 18685, 8: 27936, 16: 46279, 32: 833, 64: 156597}
L_4 = sorted(list(data_4.keys()))
LUT[4] = [x/1000 for x in sorted(list(data_4.values()))]

data_8 = {1: 13051, 2: 28777, 4: 42236, 8: 55005, 16: 73483, 32: 110205, 64: 177285}
L_8 = sorted(list(data_8.keys()))
LUT[8] = [x/1000 for x in sorted(list(data_8.values()))]

data_16 = {1: 29970, 2: 45514, 4: 58898, 8: 123541, 16: 149233, 32: 52959}
L_16 = sorted(list(data_16.keys()))
LUT[16] = [x/1000 for x in sorted(list(data_16.values()))]

data_32 = {1: 77732, 2: 74219, 4: 104282, 8: 126220, 16: 142189}
L_32 = sorted(list(data_32.keys()))
LUT[32] = [x/1000 for x in sorted(list(data_32.values()))]

fig, axs = plt.subplots();

a = ['b.', 'r+', 'gv', 'mx', '^', 's', '<']
res = {}
res[2] = [LUT[x][1] for x in [1, 2, 4, 8, 16, 32]]
res[4] = [LUT[x][2] for x in [1, 2, 4, 8, 16, 32]]
res[8] = [LUT[x][3] for x in [1, 2, 4, 8, 16, 32]]
res[16] = [LUT[x][4] for x in [1, 2, 4, 8, 16, 32]]
res[32] = [LUT[x][5] for x in [1, 2, 4, 8, 16]]
res[64] = [LUT[x][6] for x in [1, 2, 4, 8]]


plt.xscale('log', basex=2)

axs.plot([2, 4, 8], res[64][1:], a[5], label="L=64");
axs.plot([2, 4, 8, 16], res[32][1:], a[4], label="L=32");
axs.plot([2, 4, 8, 16, 32], res[16][1:], a[3], label="L=16");
axs.plot([2, 4, 8, 16, 32], res[8][1:], a[2], label="L=8");
axs.plot([2, 4, 8, 16, 32], res[4][1:], a[1], label="L=4");
axs.plot([2, 4, 8, 16, 32], res[2][1:], a[0], label="L=2");

axs.legend();
plt.xlabel("Tree Throughput P (log scale)")
plt.ylabel("LUTs (x1,000)")
plt.xlim(1.8, 90)

plt.show()
