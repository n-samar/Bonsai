import matplotlib.pyplot as plt
import seaborn as sns


LUT = {}
data_1 = {1: 300, 2: 978, 4: 2346, 8: 5107, 16: 10530, 32: 21420, 64: 43224, 128: 87365}
L_1 = sorted(list(data_1.keys()))
LUT[1] = [x/1000 for x in sorted(list(data_1.values()))]

data_2 = {1: 622, 2: 1225, 4: 2890, 8: 5618, 16: 11025, 32: 21875, 64: 43765, 128: 86702}
L_2 = sorted(list(data_2.keys()))
LUT[2] = [x/1000 for x in sorted(list(data_2.values()))]

data_4 = {1: 1555, 2: 3384, 4: 5139, 8: 7879, 16: 13394, 32: 24105, 64: 45763, 128: 89011}
L_4 = sorted(list(data_4.keys()))
LUT[4] = [x/1000 for x in sorted(list(data_4.values()))]

data_8 = {1: 3620, 2: 7912, 4: 11427, 8: 15068, 16: 20308, 32: 31152, 64: 52978, 128: 96262}
L_8 = sorted(list(data_8.keys()))
LUT[8] = [x/1000 for x in sorted(list(data_8.values()))]

data_16 = {1: 8500, 2: 17875, 4: 26050, 8: 33669, 16: 40239, 32: 51079, 64: 73275, 128: 115325}
L_16 = sorted(list(data_16.keys()))
LUT[16] = [x/1000 for x in sorted(list(data_16.values()))]

data_32 = {1: 18853, 2: 39761, 4: 58483, 8: 75165, 16: 89480, 32: 103600, 64: 130000, 128: 169724}
L_32 = sorted(list(data_32.keys()))
LUT[32] = [x/1000 for x in sorted(list(data_32.values()))]

res = {}



fig, axs = plt.subplots();

a = ['b.', 'r+', 'gv', 'mx', '^', 's', '<']


res[2] = [LUT[x][1] for x in [1, 2, 4, 8, 16, 32]]
res[4] = [LUT[x][2] for x in [1, 2, 4, 8, 16, 32]]
res[8] = [LUT[x][3] for x in [1, 2, 4, 8, 16, 32]]
res[16] = [LUT[x][4] for x in [1, 2, 4, 8, 16, 32]]
res[32] = [LUT[x][5] for x in [1, 2, 4, 8, 16, 32]]
res[64] = [LUT[x][6] for x in [1, 2, 4, 8, 16, 32]]
res[128] = [LUT[x][7] for x in [1, 2, 4, 8, 16, 32]]

plt.xscale('log', basex=2)

axs.plot([2, 4, 8, 16, 32], res[128][1:], a[6], label="L=128");
axs.plot([2, 4, 8, 16, 32], res[64][1:], a[5], label="L=64");
axs.plot([2, 4, 8, 16, 32], res[32][1:], a[4], label="L=32");
axs.plot([2, 4, 8, 16, 32], res[16][1:], a[3], label="L=16");
axs.plot([2, 4, 8, 16, 32], res[8][1:], a[2], label="L=8");
axs.plot([2, 4, 8, 16, 32], res[4][1:], a[1], label="L=4");
axs.plot([2, 4, 8, 16, 32], res[2][1:], a[0], label="L=2");


axs.legend(loc="upper left");
plt.xlabel("Tree Throughput P (log scale)")
plt.ylabel("LUTs (x1,000)")
plt.xlim(1.8, 35)

plt.show()
