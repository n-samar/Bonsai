import matplotlib.pyplot as plt
import seaborn as sns

GB_1 = [1/133.0, 1/73.0, 1/50.2, 1/36.6]
GB_10 = [10/1805.0, 10/900.0, 10/840.0, 10/762.0]

fig, axs = plt.subplots(1,2);

axs[0].bar([1, 2, 3, 4], GB_1, color=['royalblue', 'royalblue', 'royalblue', 'royalblue']);

plt.sca(axs[0])
plt.xticks([1, 2, 3, 4], [1, 2, 4, 8])
plt.xlabel("Number of Threads")
plt.ylabel("Throughput [GB/s]")
plt.title("GNU Sort on u7 (1GB)")

axs[1].bar([1, 2, 3, 4], GB_10, color=['royalblue', 'royalblue', 'royalblue', 'royalblue']);

plt.sca(axs[1])
plt.xticks([1, 2, 3, 4], [1, 2, 4, 8])
plt.xlabel("Number of Threads")
plt.title("GNU Sort on u7 (10GB)")

plt.show()
