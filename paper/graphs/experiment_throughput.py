import numpy as np
import matplotlib.pyplot as plt

# data to plot
n_groups = 4
P8_L8 = (90, 55, 40, 65)
P8_L32 = (85, 62, 54, 20)
P16_L16_single_bank = (15, 20, 92, 13)
P16_L16_double_bank = (12, 30, 100, 20)
P4_L4 = (13, 13, 2, 90)
P32_L32 = (1, 2, 3, 4)
P16_L64 = (90, 80, 70,  12)

# create plot
fig, ax = plt.subplots()
index = np.arange(n_groups)
bar_width = 0.10
opacity = 0.8

rects1 = plt.bar(index, P8_L8, bar_width,
                 alpha=opacity,
                 color='',
                 label='P8, L8', edgecolor='black')

rects2 = plt.bar(index + bar_width, P8_L32, bar_width,
                 alpha=opacity,
                 color='lightgreen',
                 label='P8, L32', edgecolor='black')

rects3 = plt.bar(index + 2*bar_width, P16_L16_single_bank, bar_width,
                 alpha=opacity,
                 color='violet',
                 label='P16, L16 (one bank)', edgecolor='black')

rects4 = plt.bar(index + 3*bar_width, P16_L16_double_bank, bar_width,
                 alpha=opacity,
                 color='goldenrod',
                 label='P16, L16 (two bank)', hatch='o', edgecolor='black')

rects5 = plt.bar(index + 4*bar_width, P4_L4, bar_width,
                 alpha=opacity,
                 color='orange',
                 label='P4, L4', hatch='//', edgecolor='black')

rects6 = plt.bar(index + 5*bar_width, P32_L32, bar_width,
                 alpha=opacity,
                 color='lightblue',
                 label='P32, L32', hatch='.', edgecolor='black')

rects2 = plt.bar(index + 6*bar_width, P16_L64, bar_width,
                 alpha=opacity,
                 color='y',
                 label='P16, L64', hatch='\\', edgecolor='black')

plt.xlabel('Input Size (N)')
plt.ylabel('Effective Throughput [GB/s]')
plt.xticks(index + bar_width*3, ('512MB', '1GB', '2GB', '8GB'))
plt.legend()

plt.tight_layout()
plt.show()
