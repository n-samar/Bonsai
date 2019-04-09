import math
import sys


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
        self.final_tuple = False
        self.done_A = False
        self.done_B = False
        self.done = False
        self.select_A = True
        self.first_toggle = False

    def update_stall_sig(self):
        if self.final_tuple:
            self.final_tuple = False
            self.done_A = False
            self.done_B = False
            self.stall = True
        elif self.out_fifo.full():
            self.stall = True                        
        elif self.internal_fifo_a.empty() and self.internal_fifo_b.empty() and self.done_A and self.done_B and not self.done:
            self.stall = False
            self.final_tuple = True
            self.done = True
        elif self.internal_fifo_a.empty() and not self.done_A:
            self.stall = True
        elif self.internal_fifo_b.empty() and not self.done_B:
            self.stall = True
        else:
            self.stall = False

    # Note: This should probably be implemented as a finite state machine
    # This would make the logic simpler when implementing in HW
    def selector_logic(self):
        if self.internal_fifo_a.empty() and self.internal_fifo_b.empty() and not self.final_tuple:
            raise Exception("Cannot run selector logic when both FIFO_A and FIFO_B are empty!")
        
        if self.final_tuple:
            self.select_A = True
        elif self.internal_fifo_a.empty() and self.done_A:
            self.first_toggle = True
            self.select_A = False
        elif self.internal_fifo_b.empty() and self.done_B:
            self.first_toggle = True            
            self.select_A = True
        elif self.toggle or \
             (self.internal_fifo_a.read().min_elem() == 0 and self.internal_fifo_b.read().min_elem() == 0):
            self.select_A = not self.select_A   # alternately dequeue from FIFO_A and FIFO_B instead of global reset
            self.done_A = True
            self.done_B = True
            self.first_toggle = False
            if not self.toggle:
                self.first_toggle = True
            if self.internal_fifo_a.read().min_elem() != 0 or self.internal_fifo_b.read().min_elem() != 0:
                self.done_A = False
                self.done_B = False
                self.toggle = False
            else:
                self.toggle = True
        elif self.internal_fifo_a.read().min_elem() == 0:
            self.done_A = True
            self.select_A = False
        elif self.internal_fifo_b.read().min_elem() == 0:
            self.done_B = True
            self.select_A = True
        elif self.internal_fifo_a.read().min_elem() <= self.internal_fifo_b.read().min_elem():
            self.select_A = True
        else:
            self.select_A = False

    def pipeline_stage_1(self):
        bml_result = None
        if not self.first_toggle:
            bml_result = sorted(self.R_A.data + self.R_B.data)[self.P:]
        else:
            bml_result = sorted(self.R_A.data + self.R_B.data)[:self.P]
        bms_input_0 = None
        self.selector_logic()            
        if not self.final_tuple and self.select_A:
            bms_input_0 = self.internal_fifo_a.read().data
        elif not self.final_tuple:
            bms_input_0 = self.internal_fifo_b.read().data
        else:
            bms_input_0 = [0] * self.P
        if not self.stall:
            if not self.first_toggle:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[:self.P]))
            else:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[self.P:]))

    def pipeline_stage_2(self):
        if self.select_A and not self.final_tuple:
            if not self.stall:
                self.R_A = self.internal_fifo_a.pop()
            if not self.in_fifo_1.empty() and not self.internal_fifo_a.full():
                self.internal_fifo_a.push(self.in_fifo_1.pop())
        elif not self.final_tuple:
            if not self.stall:
                self.R_B = self.internal_fifo_b.pop()
            if not self.in_fifo_2.empty() and not self.internal_fifo_b.full():            
                self.internal_fifo_b.push(self.in_fifo_2.pop())
                
    def simulate_pipeline_init(self):
        self.pipeline_stage_1()

    def simulate_pipeline_else(self):
        self.pipeline_stage_2()
        self.update_stall_sig()
        if not self.stall:
            self.pipeline_stage_1()
    
    # simulates merger for one clock cycle
    def simulate(self):
        if self.cycle == 0:
            self.simulate_pipeline_init()
        else:
            self.simulate_pipeline_else()
        self.cycle += 1

                
    def __str__(self):
        result = "Cycle: " + str(self.cycle) + "\n"
        result += ("R_A = " + str(self.R_A) + "\n")
        result += ("R_B = " + str(self.R_B) + "\n")
        result += ("FIFO_A = " + "\n" + str(self.internal_fifo_a) + "\n")
        result += ("FIFO_B = " + "\n" +  str(self.internal_fifo_b) + "\n")
        result += ("select_A = " + str(self.select_A))
        result += ("\n first_toggle = " + str(self.first_toggle))
        result += ("\n done_A = " + str(self.done_A))
        result += ("\n done_B = " + str(self.done_B))
        result += ("\n stall = " + str(self.stall))
        result += ("\n final tuple = " + str(self.final_tuple))
        result += ("\n out_fifo.full() = " + str(self.out_fifo.full()))        
        
        return result

class Coupler:
    def __init__(self, input_size, in_fifo, out_fifo):
        self.input_size = input_size
        self.in_fifo = in_fifo
        self.out_fifo = out_fifo
        self.internal_fifo = FIFO(2)

    def couple(self, tuple_1, tuple_2):
        return Tuple(tuple_1.data + tuple_2.data)
    
    def simulate(self):
        if not self.in_fifo.empty() and not self.internal_fifo.full():
            self.internal_fifo.push(self.in_fifo.pop())        
        if not self.out_fifo.full():
            if self.internal_fifo.full():
                tuple_1 = self.internal_fifo.pop()
                if tuple_1.min_elem() == 0:
                    if self.internal_fifo.read().min_elem() > 0:
                        self.out_fifo.push(self.couple(tuple_1, tuple_1))
                    else:
                        self.out_fifo.push(self.couple(tuple_1, self.internal_fifo.pop()))
                else:
                    self.out_fifo.push(self.couple(tuple_1, self.internal_fifo.pop()))

class MergerTree:
    def __init__(self, P, L):
        self.P = P
        self.L = L
        if P != L:
            raise Exception("This class only works for P == L for now!")
        if 2**math.log(L, 2) != L:
            raise Exception("L must be a power of two!")
        if 2**math.log(P, 2) != P:
            raise Exception("P must be a power of two! " + str(2**math.log(P, 2)))        
        self.mergers = []
        self.couplers = []
        self.fifos = []
        for level in range(0, int(math.log(L, 2))+1):
            self.fifos = self.fifos + [[]]
            self.couplers = self.couplers + [[]]
            for index in range(0, 2**level):
                self.fifos[level] = self.fifos[level] + [[None, None]]
                self.couplers[level] = self.couplers[level] + [None]
                # input FIFOs need to be bigger
                if level == int(math.log(L,2)):
                    self.fifos[level][index][0] = FIFO(1000000)
                else:
                    self.fifos[level][index][0] = FIFO(3)
                if level > 0 and level < math.log(L, 2):
                    self.fifos[level][index][1] = FIFO(3)
                    self.couplers[level][index] = Coupler(P/2**(level-1),
                                                          self.fifos[level][index][0],
                                                          self.fifos[level][index][1])
                else:
                    self.fifos[level][index][1] = self.fifos[level][index][0]
        for level in range(0, int(math.log(L, 2))):
            self.mergers = self.mergers + [[]]
            for merger_index in range(0, 2**level):
                self.mergers[level] = self.mergers[level] + [None]
                self.mergers[level][merger_index] = Merger(P/(2**level), self.fifos[level+1][merger_index*2][1],
                                                  self.fifos[level+1][merger_index*2+1][1],
                                                  self.fifos[level][merger_index][0])


    def simulate(self):
        for level in range(0, len(self.couplers)):
            for index in range(0, len(self.couplers[level])):
                if level > 0 and level < math.log(self.L, 2):
                    self.couplers[level][index].simulate()
                    
        for level in range(0, len(self.mergers)):
            for merger_index in range(0, len(self.mergers[level])):
                self.mergers[level][merger_index].simulate()


