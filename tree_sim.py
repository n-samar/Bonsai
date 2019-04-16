import math
import sys

STALL_AMOUNT = 5
INTERNAL_FIFO_DEPTH = 3
INPUT_FIFO_DEPTH = 100000

STATE_FINAL_FINAL_TUPLE = -1
STATE_TOGGLE = 0
STATE_NOMINAL = 1
STATE_DONE_A = 2
STATE_DONE_B = 3
STATE_FINAL_TUPLE = 4
STATE_STALL_COUNTDOWN_5 = 5
STATE_STALL_COUNTDOWN_4 = 6
STATE_STALL_COUNTDOWN_3 = 7
STATE_STALL_COUNTDOWN_2 = 8
STATE_STALL_COUNTDOWN_1 = 9

def get_state(state):
    if state == STATE_TOGGLE:
        return "TOGGLE"
    elif state == STATE_DONE_A:
        return "DONE_A"
    elif state == STATE_DONE_B:
        return "DONE_B"
    elif state == STATE_FINAL_TUPLE:
        return "FINAL_TUPLE"
    elif state == STATE_NOMINAL:
        return "NOMINAL"
    elif state == STATE_FINAL_TUPLE:
        return "FINAL_TUPLE"
    elif state == STATE_STALL_COUNTDOWN_5:
        return "STALL_COUNTDOWN_5"
    elif state == STATE_STALL_COUNTDOWN_4:
        return "STALL_COUNTDOWN_4"    
    elif state == STATE_STALL_COUNTDOWN_3:
        return "STALL_COUNTDOWN_3"
    elif state == STATE_STALL_COUNTDOWN_2:
        return "STALL_COUNTDOWN_2"    
    elif state == STATE_STALL_COUNTDOWN_1:
        return "STALL_COUNTDOWN_1"
    elif state == STATE_FINAL_FINAL_TUPLE:
        return "FINAL_FINAL_TUPLE"
    return "<NO STATE!>"

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
        self.internal_fifo_a = FIFO(INTERNAL_FIFO_DEPTH)  # simulating the delay between output/input
        self.internal_fifo_b = FIFO(INTERNAL_FIFO_DEPTH)  # simulating the delay between output/input

        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))
        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))
        self.internal_fifo_a.push(Tuple([0] * self.P))
        self.internal_fifo_b.push(Tuple([0] * self.P))        

        self.R_A = Tuple([0] * self.P)
        self.R_B = Tuple([0] * self.P)

        self.cycle = 0

        # State signals 
        self.toggle = False    # True when we want to toggle outputs from FIFO_A and FIFO_B on global reset
        self.stall = False    # True when the merger is stalled
        self.final_tuple = False    # True when we want to push a final  0-tuple out of the merger on the last list
        self.done_A = False    # True when all inputs for current list are read from FIFO_A
        self.done_B = False    # True when all inputs for current list are read from FIFO_B
        self.select_A = True
        self.switch_output = False
        self.curr_state = STATE_TOGGLE
        self.stall_countdown = STALL_AMOUNT

        # used to simulate pipelining
        self.pop_1 = False
        self.pop_2 = False
        self.new_R_A = False
        self.new_R_B = False

    def update_stall_sig(self):
        self.stall = (self.curr_state == STATE_FINAL_FINAL_TUPLE) or \
                     (self.out_fifo.full()) or \
                     (self.curr_state == STATE_NOMINAL and (self.internal_fifo_a.empty() or self.internal_fifo_b.empty())) or \
                     (self.curr_state == STATE_DONE_B and not self.stall) or \
                     (self.curr_state == STATE_DONE_A and not self.stall) or \
                     (self.curr_state >= STATE_STALL_COUNTDOWN_5)  # checks if we are in one of the STALL_COUNTDOWN_X states
        if  self.curr_state == STATE_STALL_COUNTDOWN_5:
            self.curr_state = STATE_STALL_COUNTDOWN_4
        elif  self.curr_state == STATE_STALL_COUNTDOWN_4:
            self.curr_state = STATE_STALL_COUNTDOWN_3
        elif  self.curr_state == STATE_STALL_COUNTDOWN_3:
            self.curr_state = STATE_STALL_COUNTDOWN_2
        elif  self.curr_state == STATE_STALL_COUNTDOWN_2:
            self.curr_state = STATE_STALL_COUNTDOWN_1
        elif  self.curr_state == STATE_STALL_COUNTDOWN_1:
            if self.internal_fifo_a.empty() and self.internal_fifo_b.empty():
                self.curr_state = STATE_FINAL_FINAL_TUPLE
                self.stall = False                
            elif self.internal_fifo_a.empty() or self.internal_fifo_b.empty():
                self.curr_state = STATE_FINAL_TUPLE
                self.stall = False
            elif not self.internal_fifo_a.empty() and self.internal_fifo_a.read().min_elem() == 0:
                self.curr_state = STATE_DONE_A
            elif not self.internal_fifo_b.empty() and self.internal_fifo_b.read().min_elem() == 0:
                self.curr_state = STATE_DONE_B
            else:
                self.curr_state = STATE_NOMINAL
        if not self.stall:
            self.selector_logic()

    # Note: This should probably be implemented as a finite state machine
    # This would make the logic simpler when implementing in HW
    def selector_logic(self):
        if self.curr_state == STATE_NOMINAL:
            if self.internal_fifo_a.read().min_elem() == 0:
                self.curr_state = STATE_DONE_A
            elif self.internal_fifo_b.read().min_elem() == 0:
                self.curr_state = STATE_DONE_B
        elif self.curr_state == STATE_DONE_A:
            if self.internal_fifo_b.empty():
                self.curr_state = STATE_STALL_COUNTDOWN_5
                self.stall = True
            elif self.internal_fifo_b.read().min_elem() == 0:
                self.curr_state = STATE_TOGGLE
        elif self.curr_state == STATE_DONE_B:
            if self.internal_fifo_a.empty():
                self.curr_state = STATE_STALL_COUNTDOWN_5
                self.stall = True
            elif self.internal_fifo_a.read().min_elem() == 0:
                self.curr_state = STATE_TOGGLE
        elif self.curr_state == STATE_TOGGLE:        
            if self.internal_fifo_a.empty():
                self.curr_state = STATE_DONE_A
            elif self.internal_fifo_b.empty():
                self.curr_state = STATE_DONE_B
            elif self.internal_fifo_a.read().min_elem() != 0 or self.internal_fifo_b.read().min_elem() != 0:
                self.curr_state = STATE_NOMINAL
        elif self.curr_state == STATE_FINAL_TUPLE:
            if self.internal_fifo_a.empty() and self.internal_fifo_b.empty():
                self.curr_state = STATE_FINAL_FINAL_TUPLE
        self.switch_output = (self.curr_state == STATE_TOGGLE) and (not self.switch_output)
        self.select_A = (self.curr_state == STATE_NOMINAL and \
                         self.internal_fifo_a.read().min_elem() <= self.internal_fifo_b.read().min_elem()) or \
                        (self.curr_state == STATE_DONE_B) or \
                        (self.curr_state == STATE_TOGGLE and (not self.select_A)) or \
                        (self.curr_state == STATE_FINAL_TUPLE and (not self.internal_fifo_a.empty()))
        self.final_tuple = (self.curr_state == STATE_FINAL_FINAL_TUPLE)


                        

    def pipeline_stage_1(self):
        bml_result = sorted(self.R_A.data + self.R_B.data)[self.P:]
        bms_input_0 = None
        if not self.stall:
            if self.final_tuple and self.internal_fifo_a.empty() and self.internal_fifo_b.empty():
                bms_input_0 = [0] * self.P            
            elif self.select_A:
                bms_input_0 = self.internal_fifo_a.read().data
            else:
                bms_input_0 = self.internal_fifo_b.read().data


            if not self.switch_output:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[:self.P]))
            else:
                self.out_fifo.push(Tuple(sorted(bml_result + bms_input_0)[self.P:]))

    def pipeline_stage_2(self):
        if not (self.final_tuple and self.internal_fifo_a.empty() and self.internal_fifo_b.empty()):
            if self.select_A:
                if not self.stall:
                    self.new_R_A = True
            else:
                if not self.stall:
                    self.new_R_B = True
                    
        if not self.in_fifo_2.empty() and not self.internal_fifo_b.full():
            self.pop_2 = True
        if not self.in_fifo_1.empty() and not self.internal_fifo_a.full():
            self.pop_1 = True
                
    def simulate_pipeline_init(self):
        self.pipeline_stage_1()
        
    def simulate_pipeline_else(self):
        self.update_stall_sig()
        self.pipeline_stage_2()                                
        if not self.stall:
            self.pipeline_stage_1()
    
    # simulates merger for one clock cycle
    def simulate(self):
        if self.cycle == 0:
            self.simulate_pipeline_init()
        else:
            self.simulate_pipeline_else()

        ########################## SIMULATING PIPELINING

        if self.pop_2:
            self.internal_fifo_b.push(self.in_fifo_2.pop())
        if self.pop_1:
            self.internal_fifo_a.push(self.in_fifo_1.pop())
        if self.new_R_A:
            self.R_A = self.internal_fifo_a.pop()
        if self.new_R_B:
            self.R_B = self.internal_fifo_b.pop()

        self.new_R_B = False
        self.new_R_A = False
        self.pop_1 = False
        self.pop_2 = False
        
        self.cycle += 1

                
    def __str__(self):
        result = "Cycle: " + str(self.cycle) + "\n"
        result += ("R_A = " + str(self.R_A) + "\n")
        result += ("R_B = " + str(self.R_B) + "\n")
        result += ("FIFO_A = " + "\n" + str(self.internal_fifo_a) + "\n")
        result += ("FIFO_B = " + "\n" +  str(self.internal_fifo_b) + "\n")
        result += ("select_A = " + str(self.select_A))
        result += ("\nstall = " + str(self.stall))        
        result += ("\ncurr_state = " + str(get_state(self.curr_state)))
        result += ("\nswitch_output = " + str(self.switch_output))        
        
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
                    self.fifos[level][index][0] = FIFO(INPUT_FIFO_DEPTH)
                else:
                    self.fifos[level][index][0] = FIFO(INTERNAL_FIFO_DEPTH)
                if level > 0 and level < math.log(P, 2):
                    self.fifos[level][index][1] = FIFO(INTERNAL_FIFO_DEPTH)
                    self.couplers[level][index] = Coupler(P/2**(level-1),
                                                          self.fifos[level][index][0],
                                                          self.fifos[level][index][1])
                else:
                    self.fifos[level][index][1] = self.fifos[level][index][0]
        for level in range(0, int(math.log(L, 2))):
            self.mergers = self.mergers + [[]]
            for merger_index in range(0, 2**level):
                self.mergers[level] = self.mergers[level] + [None]
                self.mergers[level][merger_index] = Merger(max(2, P/(2**level)), self.fifos[level+1][merger_index*2][1],
                                                  self.fifos[level+1][merger_index*2+1][1],
                                                  self.fifos[level][merger_index][0])


    def simulate(self):
        for level in range(0, len(self.couplers)):
            for index in range(0, len(self.couplers[level])):
                if level > 0 and level < math.log(self.P, 2):
                    self.couplers[level][index].simulate()
                    
        for level in range(0, len(self.mergers)):
            for merger_index in range(0, len(self.mergers[level])):
                self.mergers[level][merger_index].simulate()


