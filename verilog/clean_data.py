import sys

with open(sys.argv[1], 'r') as f:
    content = f.readlines()

content = [x.strip() for x in content]

f = open(sys.argv[2], 'w+');

for x in content:
    for i in range(len(x)/8, 0, -1):
        f.write(x[8*i-8:8*i] + "\n")
