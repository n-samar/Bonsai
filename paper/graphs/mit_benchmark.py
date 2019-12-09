import matplotlib.pyplot as plt
import seaborn as sns

GB_10 = [10/10.41, 10/5.2, 10/2.6, 10/1.48]


plt.bar([1, 2, 3, 4, 5], [0.78] + GB_10, color=['orangered', 'royalblue', 'royalblue', 'royalblue', 'royalblue']);

plt.xticks([1, 2, 3, 4, 5], ["MIT 128-bit", "AMT 4 GB/s", "AMT 8 GB/s", "AMT 16 GB/s", "AMT 32 GB/s"])
plt.ylabel("Throughput [GB/s]")
plt.title("10GB, 32-bit AMT, 128-bit MIT, 130k LUTs")

plt.show()
