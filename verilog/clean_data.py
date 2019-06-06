import sys

with open(sys.argv[1], 'r') as f:
    content = f.readlines()

content = [x.strip() for x in content]

f = open(sys.argv[2], 'w');

for x in content:
    for i in range(0, len(x)/8):
        f.write(x[8*i:8*i+8] + "\n")
