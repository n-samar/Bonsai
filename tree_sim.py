class FIFO:
    def __init__(self, capacity):
        self.capacity = capacity
        self.data = []

    def full(self):
        return (len(self.data) >= self.capacity)

    def empty(self):
        return (len(self.data) == 0)
            
    def push(self, elem):
        if self.full():
            raise Exception('Attempting to push to full FIFO!')
        self.data = [elem] + self.data

    def pop(self):
        if self.empty():
            raise Exception('Attempting to pop from empty FIFO!')
        result = self.data[-1]
        self.data = self.data[:-1]
        return result

class Merger:
    def __init__(self, throughput, in_fifo_1, in_fifo_2, out_fifo):
        self.P = throughput
        self.in_fifo_1 = in_fifo_1
        self.in_fifo_2 = in_fifo_2
        self.out_fifo = out_fifo

    # simulates merger for one clock cycle
    def simulate():
        
