
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

    def read(self):
        if self.empty():
            raise Exception('Attempting to pop from empty FIFO!')
        return self.data[-1]

    def __str__(self):
        result = ""
        for i in range(0, len(self.data)):
            result += str(self.data[i]) + "\n"
        return result

class Tuple:
    def __init__(self, data):
        if data != sorted(data):
            raise Exception("Tuples must be sorted!")
        self.data = data
    
    def min_elem(self):
        return self.data[0]

    def __str__(self):
        result = "["
        for i in range(0, len(self.data)-1):
            result += (str(self.data[i]) + ", ")
        result += str(self.data[-1]) + "]"
        return result
    
class Merger:
    def __init__(self, throughput, in_fifo_1, in_fifo_2, out_fifo):
        self.P = throughput
        self.in_fifo_1 = in_fifo_1
        self.in_fifo_2 = in_fifo_2
        self.out_fifo = out_fifo
        self.internal_fifo_a = FIFO(3)  # simulating the delay between output/input
        self.internal_fifo_b = FIFO(3)  # simulating the delay between output/input

        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))
        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))
        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))        

        self.R_A = Tuple([0] * self.P)
        self.R_B = Tuple([0] * self.P)

        self.cycle = 0
        self.toggle = False
        self.stall = False

        self.select_A = False
        self.first_toggle = False

    def update_stall_sig(self):
        if self.internal_fifo_a.empty() and self.internal_fifo_b.empty():
            self.stall = True
        elif self.out_fifo.full():
            self.stall = True
        else:
            self.stall = False

    def selector_logic(self):
        if self.internal_fifo_a.empty() and self.internal_fifo_b.empty():
            raise Exception("Cannot run selector logic when both FIFO_A and FIFO_B are empty!")
        if self.internal_fifo_a.empty():
            self.select_A = False
        elif self.internal_fifo_b.empty():
            self.select_A = True
        elif self.toggle or \
             (self.internal_fifo_a.read().min_elem() == 0 and self.internal_fifo_b.read().min_elem() == 0):
            self.select_A = not self.select_A   # alternately dequeue from FIFO_A and FIFO_B instead of global reset
            self.first_toggle = False
            if not self.toggle:
                self.first_toggle = True
            if self.internal_fifo_a.read().min_elem() != 0 or self.internal_fifo_b.read().min_elem() != 0:
                self.toggle = False
            else:
                self.toggle = True
        elif self.internal_fifo_a.read().min_elem() == 0:
            self.select_A = False
        elif self.internal_fifo_b.read().min_elem() == 0:
            self.select_A = True
        elif self.internal_fifo_a.read().min_elem() <= self.internal_fifo_b.read().min_elem():
            self.select_A = True
        else:
            self.select_A = False
                
            
    # simulates merger for one clock cycle
    def simulate(self):
        self.update_stall_sig()
        self.cycle += 1
        if not self.stall:
            bml_result = None
            if not self.first_toggle:
                bml_result = sorted(self.R_A.data + self.R_B.data)[self.P:]
            else:
                bml_result = sorted(self.R_A.data + self.R_B.data)[:self.P]
            bms_input_0 = None

            self.selector_logic()
            
            if self.select_A:
                bms_input_0 = self.internal_fifo_a.read().data
                self.R_A = self.internal_fifo_a.pop()
                if not self.in_fifo_1.empty():
                    self.internal_fifo_a.push(self.in_fifo_1.pop())
            else:
                bms_input_0 = self.internal_fifo_b.read().data
                self.R_B = self.internal_fifo_b.pop()
                if not self.in_fifo_2.empty():            
                    self.internal_fifo_b.push(self.in_fifo_2.pop())

            if not self.first_toggle:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[:self.P]))
            if self.first_toggle:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[self.P:]))
                
    def __str__(self):
        result = "Cycle: " + str(self.cycle) + "\n"
        result += ("R_A = " + str(self.R_A) + "\n")
        result += ("R_B = " + str(self.R_B) + "\n")
        result += ("FIFO_A = " + "\n" + str(self.internal_fifo_a) + "\n")
        result += ("FIFO_B = " + "\n" +  str(self.internal_fifo_b) + "\n")
        return result
