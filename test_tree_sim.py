import unittest
import tree_sim
import random
import math
FULL_TEST = False
# DEFINITION:  Proper input means each leaf gets a non-zero multiple of 2*P of inputs AND a terminal zero tuple [0, 0]



        
class TestFIFO(unittest.TestCase):
    def test_push_full(self):
        fifo = tree_sim.FIFO(0)
        with self.assertRaises(Exception):
            fifo.push(1)

    def test_push_full_2(self):
        fifo = tree_sim.FIFO(2)
        fifo.push(1)
        fifo.push(2)
        with self.assertRaises(Exception):
            fifo.push(3)

    def test_pop_empty(self):
        fifo = tree_sim.FIFO(0)
        with self.assertRaises(Exception):
            fifo.pop()

    def test_empty(self):
        fifo = tree_sim.FIFO(1)
        self.assertTrue(fifo.empty())
        fifo.push(1)
        self.assertFalse(fifo.empty())
        fifo.pop()
        self.assertTrue(fifo.empty())

    def test_full(self):
        fifo = tree_sim.FIFO(1)
        self.assertFalse(fifo.full())
        fifo.push(1)
        self.assertTrue(fifo.full())
        fifo.pop()
        self.assertFalse(fifo.full())

    def test_push_pop(self):
        fifo = tree_sim.FIFO(2)
        self.assertEqual(fifo.data, [])
        fifo.push(1)
        self.assertEqual(fifo.data, [1])
        fifo.push(2)
        self.assertEqual(fifo.data, [2, 1])
        fifo.pop()
        self.assertEqual(fifo.data, [2])
        fifo.pop()
        self.assertEqual(fifo.data, [])

    def test_read(self):
        fifo = tree_sim.FIFO(2)
        with self.assertRaises(Exception):
            fifo.read()
        fifo.push(1)
        self.assertEqual(fifo.read(), 1)
        self.assertEqual(fifo.data, [1])


class TestTuple(unittest.TestCase):
    def test_min_elem(self):
        tuple = tree_sim.Tuple([1, 2, 3, 4, 5])
        self.assertEqual(tuple.min_elem(), 1)
        
class TestMerger(unittest.TestCase):
    # Example from FCCM '18 Tokyo paper
    def test_merger_basic(self):
        in_fifo_1 = tree_sim.FIFO(3)
        in_fifo_1.push(tree_sim.Tuple([1, 3, 5, 7]))
        in_fifo_1.push(tree_sim.Tuple([9, 11, 13, 15]))
        in_fifo_1.push(tree_sim.Tuple([0, 0, 0, 0]));        

        in_fifo_2 = tree_sim.FIFO(3)
        in_fifo_2.push(tree_sim.Tuple([2, 4, 6, 8]));
        in_fifo_2.push(tree_sim.Tuple([10, 12, 14, 16]));
        in_fifo_2.push(tree_sim.Tuple([0, 0, 0, 0]));        
        
        out_fifo = tree_sim.FIFO(1)

        throughput = 4

        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)
        result = []
        for i in range(0, 109):
            merger.simulate()
            if not out_fifo.empty():
                result += out_fifo.pop().data
        # print(result)
        self.assertEqual([0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16,
                          0, 0, 0, 0, \
                          0, 0, 0, 0], result)



    def test_merger_basic_reverse_input(self):
        in_fifo_1 = tree_sim.FIFO(3)
        in_fifo_1.push(tree_sim.Tuple([1, 3, 5, 7]))
        in_fifo_1.push(tree_sim.Tuple([9, 11, 13, 15]))
        in_fifo_1.push(tree_sim.Tuple([0, 0, 0, 0]));        

        in_fifo_2 = tree_sim.FIFO(3)
        in_fifo_2.push(tree_sim.Tuple([2, 4, 6, 8]));
        in_fifo_2.push(tree_sim.Tuple([10, 12, 14, 16]));
        in_fifo_2.push(tree_sim.Tuple([0, 0, 0, 0]));        
        
        out_fifo = tree_sim.FIFO(1)

        throughput = 4

        merger = tree_sim.Merger(throughput, in_fifo_2, in_fifo_1, out_fifo)
        result = []
        for i in range(0, 109):
            merger.simulate()
            if not out_fifo.empty():
                result += out_fifo.pop().data
        self.assertEqual([0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16, \
                          0, 0, 0, 0, \
                          0, 0, 0, 0], result)

        
    def test_merger_basic_global_reset(self):
        in_fifo_1 = tree_sim.FIFO(10)

        # first array
        in_fifo_1.push(tree_sim.Tuple([21, 23, 25, 27]))
        in_fifo_1.push(tree_sim.Tuple([29, 31, 33, 35]))

        # global reset
        in_fifo_1.push(tree_sim.Tuple([0, 0, 0, 0]));              

        # second array
        in_fifo_1.push(tree_sim.Tuple([1, 3, 5, 7]))
        in_fifo_1.push(tree_sim.Tuple([9, 11, 13, 15]))        

        # terminating zero padding
        in_fifo_1.push(tree_sim.Tuple([0, 0, 0, 0]));
        
        in_fifo_2 = tree_sim.FIFO(10)

        # first array
        in_fifo_2.push(tree_sim.Tuple([22, 24, 26, 28]));
        in_fifo_2.push(tree_sim.Tuple([30, 32, 34, 36]));        

        # global reset
        in_fifo_2.push(tree_sim.Tuple([0, 0, 0, 0]));

        # second array
        in_fifo_2.push(tree_sim.Tuple([2, 4, 6, 8]));
        in_fifo_2.push(tree_sim.Tuple([10, 12, 14, 16]));

        # terminating zero padding
        in_fifo_2.push(tree_sim.Tuple([0, 0, 0, 0]));        

        
        out_fifo = tree_sim.FIFO(1)

        throughput = 4

        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)
        result = []
        for i in range(0, 109):
            merger.simulate()
            if not out_fifo.empty():
                result += out_fifo.pop().data

        self.assertEqual([0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          21,22,23,24, \
                          25,26,27,28, \
                          29,30,31,32, \
                          33,34,35,36, \
                          0,0,0,0, \
                          0,0,0,0, \
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16, \
                          0, 0, 0, 0, \
                          0, 0, 0, 0], result)

    def test_merger_unbalanced_input(self):
        in_fifo_1 = tree_sim.FIFO(10)

        in_fifo_1.push(tree_sim.Tuple([1, 2, 3, 4]))
        in_fifo_1.push(tree_sim.Tuple([5, 6, 7, 8]))        
        in_fifo_1.push(tree_sim.Tuple([13, 14, 15, 16]))
        in_fifo_1.push(tree_sim.Tuple([17, 18, 19, 20]))
        in_fifo_1.push(tree_sim.Tuple([21, 22, 23, 24]))        

        # terminating zero padding
        in_fifo_1.push(tree_sim.Tuple([0, 0, 0, 0]))
        
        in_fifo_2 = tree_sim.FIFO(10)
        in_fifo_2.push(tree_sim.Tuple([9, 10, 11, 12]))        
        in_fifo_2.push(tree_sim.Tuple([0, 0, 0, 0]))      
        out_fifo = tree_sim.FIFO(1)

        throughput = 4

        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)
        result = []
        for i in range(0, 109):
            merger.simulate()
            if not out_fifo.empty():
                result += out_fifo.pop().data

        self.assertEqual([0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          0,0,0,0, \
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16, \
                          17,18,19,20, \
                          21,22,23,24, \
                          0, 0, 0, 0, \
                          0, 0, 0, 0], result)        

    def test_selector_logic_on_global_reset(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([0,0,0,0]))
        merger.internal_fifo_b.push(tree_sim.Tuple([0,0,0,0]))
        merger.select_A = False
        merger.selector_logic()
        self.assertTrue(merger.select_A)
        merger.selector_logic()
        self.assertFalse(merger.select_A)
        merger.selector_logic()
        self.assertTrue(merger.select_A)
        
    def test_selector_logic_on_A_leq(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([1,2,3,4]))
        merger.internal_fifo_b.push(tree_sim.Tuple([2,2,2,2]))
        merger.select_A = False
        merger.selector_logic()
        self.assertTrue(merger.select_A)


    def test_selector_logic_on_B_lt(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([2,2,3,4]))
        merger.internal_fifo_b.push(tree_sim.Tuple([1,2,2,2]))
        merger.select_A = False
        merger.selector_logic()
        self.assertFalse(merger.select_A)

        
class TestCoupler(unittest.TestCase):
    def setUp(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)
        
    def test_nominal_behavior(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)        
        self.in_fifo.push(tree_sim.Tuple([1, 2, 3, 4]))
        self.coupler.simulate()
        self.coupler.simulate()
        self.assertTrue(self.out_fifo.empty())
        self.in_fifo.push(tree_sim.Tuple([5, 6, 7, 8]))
        self.coupler.simulate()
        self.assertFalse(self.out_fifo.empty())
        self.assertEqual([1,2,3,4,5,6,7,8], self.out_fifo.pop().data)
        self.coupler.simulate()
        self.assertTrue(self.out_fifo.empty())

    def test_out_fifo_full(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)        
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)        
        self.in_fifo.push(tree_sim.Tuple([1,2,3,4]))
        self.in_fifo.push(tree_sim.Tuple([5,6,7,8]))
        self.in_fifo.push(tree_sim.Tuple([9,10,11,12]))                          
        self.out_fifo.push(tree_sim.Tuple([5,6,7,8]))
        self.out_fifo.push(tree_sim.Tuple([5,6,7,8]))
        self.out_fifo.push(tree_sim.Tuple([5,6,7,8]))        
        self.coupler.simulate()
        self.coupler.simulate()
        self.coupler.simulate()
        self.assertTrue(self.coupler.internal_fifo.pop().data, [1, 2, 3, 4])
        self.assertTrue(self.coupler.internal_fifo.pop().data, [5, 6, 7, 8])

    def test_in_fifo_empty(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)        
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)
        self.coupler.simulate()
        self.coupler.simulate()
        self.coupler.simulate()
        self.assertTrue(self.coupler.internal_fifo.empty())
        self.assertTrue(self.out_fifo.empty())

    def test_first_input_zero(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)        
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)
        self.in_fifo.push(tree_sim.Tuple([0, 0, 0, 0]))
        self.in_fifo.push(tree_sim.Tuple([1,2,3,4]))
        self.coupler.simulate()
        self.coupler.simulate()
        self.assertFalse(self.out_fifo.empty())
        self.assertEqual(self.out_fifo.pop().data, [0,0,0,0,0,0,0,0])
        self.assertFalse(self.coupler.internal_fifo.empty())
        self.assertEqual(self.coupler.internal_fifo.pop().data, [1,2,3,4])
        
    def test_second_input_zero(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)        
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)
        self.in_fifo.push(tree_sim.Tuple([1,2,3,4]))
        self.in_fifo.push(tree_sim.Tuple([0, 0, 0, 0]))        
        self.coupler.simulate()
        self.coupler.simulate()
        self.assertFalse(self.out_fifo.empty())
        self.assertEqual(self.out_fifo.pop().data, [1,2,3,4,0,0,0,0])
        self.assertTrue(self.coupler.internal_fifo.empty())

    def test_in_fifo_emptied(self):
        self.in_fifo = tree_sim.FIFO(3)
        self.out_fifo = tree_sim.FIFO(3)
        self.coupler = tree_sim.Coupler(4, self.in_fifo, self.out_fifo)
        self.in_fifo.push(tree_sim.Tuple([1,2,3,4]))
        self.in_fifo.push(tree_sim.Tuple([5,6,7,8]))
        self.coupler.simulate()
        self.assertEqual(self.in_fifo.read().data, [5,6,7,8])
        self.coupler.simulate()
        self.assertTrue(self.in_fifo.empty())

class TestMergerTree(unittest.TestCase):

    def random_proper_input_global_reset_test(self, P, array_size, num_tests, num_arrays = 2, L = -1):
        if L == -1:
            L = P
        assert(array_size % (2*P) == 0)
        assert(array_size > 2*P*L)
        out_prefix_zeros = [0] * int(P*(8*math.log(P, 2) - 1) + 2*7*L-2*7*P+L+P+L-2*P)
        out_suffix_zeros = [0] * (2*L)
        out_array = [x for x in range(1, array_size+1)]
        
        for test in range(0, num_tests):
            # print test
            random.seed(test)
            in_array = [x for x in range(1, array_size+1)]
            random.shuffle(in_array)
            split_array = []
            accu = 0
            while True:
                split_array = []
                accu = 0            
                try:
                    for array_indx in range(0, num_arrays):
                        split_array.append([0])
                        accu = 0                        
                        for i in range(0, L-1):
                            new_num = random.randrange(accu+1, min(array_size/(2*P), accu + array_size/(2*P)/L * 2))
                            assert(new_num - accu > 0)
                            split_array[array_indx].append(new_num)
                            accu = new_num
                        assert(array_size / (2*P) > accu)
                        split_array[array_indx].append(array_size / (2*P))
                        # print(split_array[array_indx])
                    break
                except:
                    print "Another one!"                    

            input_list = []

            for i in range(0, L):
                input_array = []
                for array_indx in range(0, num_arrays):
                    input_array += (sorted(in_array[ split_array[array_indx][i]*(2*P):split_array[array_indx][i+1]*(2*P) ]) \
                                    + [0, 0])
                input_list += [input_array]

            # print(input_list)
            input_tuples = [[]]
            for i in range(0, L):
                # print(input_list[i])
                # print("-------------------------------------------------")
                for tuple_index in range(0, len(input_list[i])/2):
                    input_tuples[i].append(tree_sim.Tuple(input_list[i][tuple_index*2:tuple_index*2+2]))
                input_tuples.append([])        

            merger_tree = tree_sim.MergerTree(P, L)
            for i in range(0, L):
                for tuple_index in range(0, len(input_list[i])/2):
                    merger_tree.fifos[int(math.log(L, 2))][i][0].push(input_tuples[i][tuple_index])

            result = []
            stall_counter = 0
            while stall_counter < 50:
                merger_tree.simulate()
                # print("merger_tree.mergers[0][0]")
                # print(merger_tree.mergers[2][3])
                # if not merger_tree.mergers[2][3].out_fifo.empty():
                #    print("NEW OUTPUT: " + str(merger_tree.mergers[2][3].out_fifo.read().data))
                '''                                
                print("merger_tree.mergers[1][0]")                                
                print(merger_tree.mergers[1][0])
                print("merger_tree.mergers[1][1]")                                
                print(merger_tree.mergers[1][1])
                print("merger_tree.mergers[2][0]")                                
                print(merger_tree.mergers[2][0])
                print("merger_tree.mergers[2][1]")                                
                print(merger_tree.mergers[2][1])
                print("merger_tree.mergers[2][2]")                                
                print(merger_tree.mergers[2][2])
                print("merger_tree.mergers[2][3]")                                                                               
                '''
                if not merger_tree.fifos[0][0][1].empty():
                    new_tuple = merger_tree.fifos[0][0][1].pop().data
                    # print("NEW TUPLE: " + str(new_tuple))
                    stall_counter = 0
                    result += new_tuple
                else:
                    stall_counter += 1

            # print(result)
            # print(test)
            # print(out_prefix_zeros + num_arrays * (out_array + out_suffix_zeros))
            self.assertEqual(result, out_prefix_zeros + num_arrays * (out_array + out_suffix_zeros))

    
    def test_4_2_random_proper_input_global(self):
        print("4_2_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(2, 256, 10, 3, 4)
        else:
            self.random_proper_input_global_reset_test(2, 1024, 100, 3, 4)            

    def test_8_2_random_proper_input_global(self):
        print("8_2_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(2, 1024, 10, 3, 8)
        else:
            self.random_proper_input_global_reset_test(2, 1024, 100, 3, 8)            

    def test_16_2_random_proper_input_global(self):
        print("16_2_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(2, 1024, 10, 3, 16)
        else:
            self.random_proper_input_global_reset_test(2, 1024, 100, 3, 16)            

    def test_32_2_random_proper_input_global(self):
        print("32_2_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(2, 1024, 10, 3, 32)
        else:
            self.random_proper_input_global_reset_test(2, 1024, 100, 3, 32)            

    def test_1024_2_random_proper_input_global(self):
        print("1024_2_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(2, 8*1024, 1, 2, 1024)
        else:
            self.random_proper_input_global_reset_test(2, 8*1024, 100, 2, 1024)
            
    def test_1024_4_random_proper_input_global(self):
        print("1024_4_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(4, 16*1024, 1, 2, 1024)
        else:
            self.random_proper_input_global_reset_test(4, 16*1024, 100, 2, 1024)

    def test_512_8_random_proper_input_global(self):
        print("512_8_proper_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(8, 16*1024, 1, 2, 512)
        else:
            self.random_proper_input_global_reset_test(8, 16*1024, 100, 2, 512)        

    def test_init_4_2_proper_input(self):
        merger_tree = tree_sim.MergerTree(2, 4)
        
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_1, merger_tree.fifos[1][0][1])
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_2, merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[0][0][0])
        self.assertEqual(merger_tree.fifos[1][0][0], merger_tree.fifos[1][0][1], str(merger_tree.fifos))
        self.assertEqual(merger_tree.fifos[1][1][0], merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.fifos[0][0][0], merger_tree.fifos[0][0][1])
        self.assertNotEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[1][1][1],
                            str(merger_tree.fifos))
        self.assertNotEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[1][0][1])
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0,0]))


        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0,0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0,0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0,0]))        
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            # print(merger_tree.mergers[0][0])
            if not merger_tree.fifos[0][0][1].empty():
                # print("NEW TUPLE: " + str(merger_tree.fifos[0][0][1].read().data))
                result+=merger_tree.fifos[0][0][1].pop().data
        # print(result)
        self.assertEqual(result, [0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  1, 2, \
                                  2, 2, \
                                  3, 4, \
                                  4, 4, \
                                  5, 6, \
                                  6, 6, \
                                  7, 8, \
                                  8, 8, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0, \
                                  0, 0])






            
    def test_2_2_random_proper_input_global_reset_10_arrays(self):
        print("2_2_global_10")        
        self.random_proper_input_global_reset_test(2, 256, 100, 1)

    def test_4_4_random_proper_input_global_reset_10_arrays(self):
        print("4_4_global_10")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(4, 256, 10, 10)
        else:
            self.random_proper_input_global_reset_test(4, 256, 100, 10)            

    def test_8_8_random_proper_input_global_reset_10_arrays(self):
        if FULL_TEST:
            print("8_8_global_10")
            self.random_proper_input_global_reset_test(8, 256*16, 3, 3)

    def test_16_16_random_proper_input_global_reset_10_arrays(self):
        if FULL_TEST:
            print("16_16_global_10")
            self.random_proper_input_global_reset_test(16, 4*4096, 1, 10)                
        
            
    def test_2_2_random_proper_input(self):
        print("2_2")
        self.random_proper_input_global_reset_test(2, 256, 100, 1)

    def test_2_2_random_proper_input_global_reset(self):
        print("2_2_global")        
        self.random_proper_input_global_reset_test(2, 256, 100, 2)    

    def test_4_4_random_proper_input_global_reset(self):
        print("4_4_global")
        self.random_proper_input_global_reset_test(4, 256, 100, 2)

    def test_8_8_random_proper_input_global_reset(self):
        print("8_8_global")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(8, 256, 10, 2)
        else:
            self.random_proper_input_global_reset_test(8, 256, 100, 2)            

    def test_4_4_random_proper_input(self):
        print("4_4")                        
        self.random_proper_input_global_reset_test(4, 2*256, 100, 1)

    def test_8_8_random_proper_input(self):
        print("8_8")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(8, 4*256, 10, 1)
        else:
            self.random_proper_input_global_reset_test(8, 4*256, 100, 1)

    def test_16_16_random_proper_input(self):
        print("16_16")
        if not FULL_TEST:
            self.random_proper_input_global_reset_test(16, 4*256, 10, 1)
        else:
            self.random_proper_input_global_reset_test(16, 4*256, 100, 1)        

    def test_32_32_random_proper_input(self):
        print("32_32")                                
        self.random_proper_input_global_reset_test(32, 4*4096, 1, 1)

    def test_64_64_random_proper_input(self):
        if FULL_TEST:
            print("64_64")            
            self.random_proper_input_global_reset_test(64, 8*4096, 1, 1)



        
    def test_init_2_2_proper_input(self):               
        merger_tree = tree_sim.MergerTree(2, 2)
        
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_1, merger_tree.fifos[1][0][1])
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_2, merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[0][0][0])
        self.assertEqual(merger_tree.fifos[1][0][0], merger_tree.fifos[1][0][1], str(merger_tree.fifos))
        self.assertEqual(merger_tree.fifos[1][1][0], merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.fifos[0][0][0], merger_tree.fifos[0][0][1])
        self.assertNotEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[1][1][1],
                            str(merger_tree.fifos))
        self.assertNotEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[1][0][1])
        
        merger_tree.fifos[1][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[1][0][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[1][0][0].push(tree_sim.Tuple([0,0]))


        merger_tree.fifos[1][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[1][1][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[1][1][0].push(tree_sim.Tuple([0,0]))
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data
        self.assertEqual(result, [0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  0, 0,\
                                  1, 2,\
                                  3, 4,\
                                  5, 6,\
                                  7, 8,\
                                  0, 0,\
                                  0, 0])


    def test_init_4_4_unbalanced(self):
        merger_tree = tree_sim.MergerTree(4, 4)

        self.assertEqual(merger_tree.mergers[1][0].in_fifo_1, merger_tree.fifos[2][0][1])
        self.assertEqual(merger_tree.mergers[1][0].in_fifo_2, merger_tree.fifos[2][1][1])
        self.assertEqual(merger_tree.mergers[1][0].out_fifo, merger_tree.fifos[1][0][0])

        self.assertEqual(merger_tree.mergers[1][1].in_fifo_1, merger_tree.fifos[2][2][1])
        self.assertEqual(merger_tree.mergers[1][1].in_fifo_2, merger_tree.fifos[2][3][1])
        self.assertEqual(merger_tree.mergers[1][1].out_fifo, merger_tree.fifos[1][1][0])

        self.assertEqual(merger_tree.mergers[0][0].in_fifo_1, merger_tree.fifos[1][0][1])
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_2, merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[0][0][0])                
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))        

        
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([9, 11]))        
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([10, 12]))        
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))

        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data

        self.assertEqual(result, [0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  9, 10, 11, 12, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0])

    def test_init_4_4_balanced(self):
        merger_tree = tree_sim.MergerTree(4, 4)            
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([6, 8]))        
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data

        self.assertEqual(result, [0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0])


    def test_init_4_4_proper_input(self):
        merger_tree = tree_sim.MergerTree(4, 4)            
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([9, 10]))        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([11, 15]))        
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([12, 14]))                
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([13, 16]))        
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()

            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data

        self.assertEqual(result, [0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0, \
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  9, 10, 11, 12, \
                                  13, 14, 15, 16, \
                                  0, 0, 0, 0, \
                                  0, 0, 0, 0])        

    


            
    def test_init_16_16_proper_input(self):
        merger_tree = tree_sim.MergerTree(16, 16)

        self.assertEqual(merger_tree.mergers[1][0].in_fifo_1, merger_tree.fifos[2][0][1])
        self.assertEqual(merger_tree.mergers[1][0].in_fifo_2, merger_tree.fifos[2][1][1])
        self.assertEqual(merger_tree.mergers[1][0].out_fifo, merger_tree.fifos[1][0][0])

        self.assertEqual(merger_tree.mergers[1][1].in_fifo_1, merger_tree.fifos[2][2][1])
        self.assertEqual(merger_tree.mergers[1][1].in_fifo_2, merger_tree.fifos[2][3][1])
        self.assertEqual(merger_tree.mergers[1][1].out_fifo, merger_tree.fifos[1][1][0])

        self.assertEqual(merger_tree.mergers[0][0].in_fifo_1, merger_tree.fifos[1][0][1])
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_2, merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[0][0][0])                

        merger_tree.fifos[4][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[4][0][0].push(tree_sim.Tuple([9, 10]))
        merger_tree.fifos[4][0][0].push(tree_sim.Tuple([29, 30]))
        merger_tree.fifos[4][0][0].push(tree_sim.Tuple([31, 32]))        
        merger_tree.fifos[4][0][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[4][1][0].push(tree_sim.Tuple([11, 15]))
        merger_tree.fifos[4][1][0].push(tree_sim.Tuple([17, 19]))
        merger_tree.fifos[4][1][0].push(tree_sim.Tuple([21, 23]))        
        merger_tree.fifos[4][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][2][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[4][2][0].push(tree_sim.Tuple([12, 14]))                
        merger_tree.fifos[4][2][0].push(tree_sim.Tuple([18, 24]))
        merger_tree.fifos[4][2][0].push(tree_sim.Tuple([26, 27]))                
        merger_tree.fifos[4][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][3][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[4][3][0].push(tree_sim.Tuple([13, 16]))
        merger_tree.fifos[4][3][0].push(tree_sim.Tuple([20, 22]))
        merger_tree.fifos[4][3][0].push(tree_sim.Tuple([25, 28]))        
        merger_tree.fifos[4][3][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][4][0].push(tree_sim.Tuple([33, 37]))
        merger_tree.fifos[4][4][0].push(tree_sim.Tuple([41, 50]))        
        merger_tree.fifos[4][4][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][5][0].push(tree_sim.Tuple([34, 36]))
        merger_tree.fifos[4][5][0].push(tree_sim.Tuple([49, 51]))                
        merger_tree.fifos[4][5][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][6][0].push(tree_sim.Tuple([35, 38]))
        merger_tree.fifos[4][6][0].push(tree_sim.Tuple([42, 44]))        
        merger_tree.fifos[4][6][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][7][0].push(tree_sim.Tuple([39, 40]))
        merger_tree.fifos[4][7][0].push(tree_sim.Tuple([43, 45]))                
        merger_tree.fifos[4][7][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][8][0].push(tree_sim.Tuple([61, 62]))
        merger_tree.fifos[4][8][0].push(tree_sim.Tuple([63, 64]))                
        merger_tree.fifos[4][8][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][9][0].push(tree_sim.Tuple([46, 48]))
        merger_tree.fifos[4][9][0].push(tree_sim.Tuple([56, 80]))                
        merger_tree.fifos[4][9][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][10][0].push(tree_sim.Tuple([47, 53]))
        merger_tree.fifos[4][10][0].push(tree_sim.Tuple([58, 76]))                
        merger_tree.fifos[4][10][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][11][0].push(tree_sim.Tuple([52, 68]))
        merger_tree.fifos[4][11][0].push(tree_sim.Tuple([70, 71]))                
        merger_tree.fifos[4][11][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][12][0].push(tree_sim.Tuple([54, 60]))
        merger_tree.fifos[4][12][0].push(tree_sim.Tuple([69, 72]))                
        merger_tree.fifos[4][12][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][13][0].push(tree_sim.Tuple([55, 57]))
        merger_tree.fifos[4][13][0].push(tree_sim.Tuple([73, 74]))                
        merger_tree.fifos[4][13][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][14][0].push(tree_sim.Tuple([59, 65]))
        merger_tree.fifos[4][14][0].push(tree_sim.Tuple([66, 75]))                
        merger_tree.fifos[4][14][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[4][15][0].push(tree_sim.Tuple([67, 77]))
        merger_tree.fifos[4][15][0].push(tree_sim.Tuple([78, 79]))                
        merger_tree.fifos[4][15][0].push(tree_sim.Tuple([0, 0]))                    
        
        result = []
        for i in range(0, 500):
            merger_tree.simulate()                    
            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data
        # print("result test_init_16_16_proper_input: " + str(result))
        self.assertEqual(result, [0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  1, 2, 3, 4, 5, 6, 7, 8, 9, 10, 11, 12, 13, 14, 15, 16, \
                                  17, 18, 19, 20, 21, 22, 23, 24, 25, 26, 27, 28, 29, 30, 31, 32, \
                                  33, 34, 35, 36, 37, 38, 39, 40, 41, 42, 43, 44, 45, 46, 47, 48, \
                                  49, 50, 51, 52, 53, 54, 55, 56, 57, 58, 59, 60, 61, 62, 63, 64, \
                                  65, 66, 67, 68, 69, 70, 71, 72, 73, 74, 75, 76, 77, 78, 79, 80, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0, 0])                              

    def test_init_32_32(self):
        merger_tree = tree_sim.MergerTree(32, 32)


if __name__ == "__main__":
    unittest.main()
