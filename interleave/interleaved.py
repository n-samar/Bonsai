for i in range(1, 2*8192):
    print (((i/16)%8)*2048 + 16*(i/8/16) + i%16);
    
