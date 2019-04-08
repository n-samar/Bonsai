import unittest
import tree_sim

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
        self.assertEqual([0,0,0,0, \
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
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16,
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
                          1,2,3,4, \
                          5,6,7,8, \
                          9,10,11,12, \
                          13,14,15,16, \
                          17,18,19,20, \
                          21,22,23,24, \
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


    def test_selector_logic_on_A_and_B_empty(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.select_A = False
        with self.assertRaises(Exception):
            merger.selector_logic()
        
    def test_selector_logic_on_B_empty(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(3)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([2,2,3,4]))
        merger.internal_fifo_a.push(tree_sim.Tuple([5,6,7,8]))
        merger.internal_fifo_a.push(tree_sim.Tuple([9,10,11,12]))                
        merger.select_A = False
        merger.selector_logic()
        self.assertTrue(merger.select_A)
 
    def test_selector_logic_on_B_empty(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_b.push(tree_sim.Tuple([2,2,3,4]))
        merger.select_A = False
        merger.selector_logic()
        self.assertFalse(merger.select_A)                    

    def test_selector_logic_on_B_zero(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([2,2,3,4]))
        merger.internal_fifo_b.push(tree_sim.Tuple([0,0,0,0]))
        merger.select_A = False
        merger.selector_logic()
        self.assertTrue(merger.select_A)             

    def test_selector_logic_on_A_zero(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(1)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(1)
        merger.internal_fifo_b = tree_sim.FIFO(1)        
        merger.internal_fifo_a.push(tree_sim.Tuple([0,0,0,0]))
        merger.internal_fifo_b.push(tree_sim.Tuple([1,2,3,3]))
        merger.select_A = False
        merger.selector_logic()
        self.assertFalse(merger.select_A)

    def test_selector_logic_toggle_behavior(self):
        in_fifo_1 = tree_sim.FIFO(2)
        in_fifo_2 = tree_sim.FIFO(2)
        out_fifo = tree_sim.FIFO(20)
        throughput = 4
        merger = tree_sim.Merger(throughput, in_fifo_1, in_fifo_2, out_fifo)

        merger.internal_fifo_a = tree_sim.FIFO(3)
        merger.internal_fifo_b = tree_sim.FIFO(3)        
        merger.internal_fifo_a.push(tree_sim.Tuple([0,0,0,1]))
        merger.internal_fifo_b.push(tree_sim.Tuple([0,0,0,2]))        
        merger.internal_fifo_a.push(tree_sim.Tuple([0,0,0,3]))
        merger.internal_fifo_b.push(tree_sim.Tuple([0,0,0,4]))        
        merger.internal_fifo_a.push(tree_sim.Tuple([1,1,1,1]))
        merger.internal_fifo_b.push(tree_sim.Tuple([1,1,1,2]))
        merger.select_A = False
        merger.toggle = False
        self.assertEqual(merger.internal_fifo_a.read().data, [0,0,0,1])
        self.assertEqual(merger.internal_fifo_b.read().data, [0,0,0,2])        
        merger.simulate()
        self.assertTrue(merger.toggle)
        self.assertTrue(merger.first_toggle)
        self.assertTrue(merger.select_A)
        merger.simulate()        
        self.assertEqual(merger.internal_fifo_a.read().data, [0,0,0,3])
        self.assertEqual(merger.internal_fifo_b.read().data, [0,0,0,2])                
        self.assertFalse(merger.select_A)
        self.assertTrue(merger.toggle)
        merger.simulate()
        self.assertEqual(merger.internal_fifo_a.read().data, [0,0,0,3])
        self.assertEqual(merger.internal_fifo_b.read().data, [0,0,0,4])                
        self.assertTrue(merger.select_A)
        self.assertTrue(merger.toggle)
        merger.simulate()
        self.assertEqual(merger.internal_fifo_a.read().data, [1,1,1,1])
        self.assertEqual(merger.internal_fifo_b.read().data, [0,0,0,4])                
        self.assertFalse(merger.select_A)
        self.assertFalse(merger.toggle)
        merger.simulate()
        self.assertEqual(merger.internal_fifo_a.read().data, [1,1,1,1])
        self.assertEqual(merger.internal_fifo_b.read().data, [1,1,1,2])        
        self.assertTrue(merger.select_A)
        self.assertFalse(merger.toggle)
        merger.simulate()
        self.assertFalse(merger.select_A)
        self.assertFalse(merger.toggle)
        
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
    def test_init_2_2(self):               
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
        self.assertEqual(result, [0,0,0,0,0,0,0,0,0,0,0,0,0,0,1,2,3,4,5,6,7,8,0,0])


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
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))
        
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))        

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))        

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))        
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            '''
            print("---------------------------------------------------------------------------")
            print("CYCLE: " + str(i))
            for level in range(0, len(merger_tree.fifos)):
                for index in range(0, len(merger_tree.fifos[level])):
                    for fifo_indx in [0,1]:
                        print("fifo[" + str(level) + "][" + str(index) + "]["+ str(fifo_indx) \
                              + "]: " + str([x.data for x in merger_tree.fifos[level][index][fifo_indx].data]))

            for level in range(0, len(merger_tree.mergers)):
                for index in range(0, len(merger_tree.mergers[level])):
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_A: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_a.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_B: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_b.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].R_A: " \
                              + str(merger_tree.mergers[level][index].R_A.data))                        
                        print("mergers[" + str(level) + "][" + str(index) + "].R_B: " \
                              + str(merger_tree.mergers[level][index].R_B.data))                        
                    
            '''
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
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  0, 0, 0, 0])

    def test_init_4_4_balanced(self):
        merger_tree = tree_sim.MergerTree(4, 4)            
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))                

        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([6, 8]))        
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            '''
            print("---------------------------------------------------------------------------")
            print("CYCLE: " + str(i))
            for level in range(0, len(merger_tree.fifos)):
                for index in range(0, len(merger_tree.fifos[level])):
                    for fifo_indx in [0,1]:
                        print("fifo[" + str(level) + "][" + str(index) + "]["+ str(fifo_indx) \
                              + "]: " + str([x.data for x in merger_tree.fifos[level][index][fifo_indx].data]))

            for level in range(0, len(merger_tree.mergers)):
                for index in range(0, len(merger_tree.mergers[level])):
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_A: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_a.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_B: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_b.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].R_A: " \
                              + str(merger_tree.mergers[level][index].R_A.data))                        
                        print("mergers[" + str(level) + "][" + str(index) + "].R_B: " \
                              + str(merger_tree.mergers[level][index].R_B.data))                        
                    
            '''
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
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  0, 0, 0, 0])


    def test_init_4_4_balanced_bigger(self):
        merger_tree = tree_sim.MergerTree(4, 4)            
        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([9, 10]))        
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][0][0].push(tree_sim.Tuple([0, 0]))                

        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([11, 15]))        
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][1][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([12, 14]))                
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][2][0].push(tree_sim.Tuple([0, 0]))

        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([13, 16]))        
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[2][3][0].push(tree_sim.Tuple([0, 0]))
        
        result = []
        for i in range(0, 100):
            merger_tree.simulate()
            '''
            print("---------------------------------------------------------------------------")
            print("CYCLE: " + str(i))
            for level in range(0, len(merger_tree.fifos)):
                for index in range(0, len(merger_tree.fifos[level])):
                    for fifo_indx in [0,1]:
                        print("fifo[" + str(level) + "][" + str(index) + "]["+ str(fifo_indx) \
                              + "]: " + str([x.data for x in merger_tree.fifos[level][index][fifo_indx].data]))

            for level in range(0, len(merger_tree.mergers)):
                for index in range(0, len(merger_tree.mergers[level])):
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_A: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_a.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_B: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_b.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].R_A: " \
                              + str(merger_tree.mergers[level][index].R_A.data))                        
                        print("mergers[" + str(level) + "][" + str(index) + "].R_B: " \
                              + str(merger_tree.mergers[level][index].R_B.data))                        
                    
            '''
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
                                  1, 2, 3, 4, \
                                  5, 6, 7, 8, \
                                  9, 10, 11, 12, \
                                  13, 14, 15, 16, \
                                  0, 0, 0, 0])        

    
    def test_init_8_8(self):
        merger_tree = tree_sim.MergerTree(8, 8)

        self.assertEqual(merger_tree.mergers[1][0].in_fifo_1, merger_tree.fifos[2][0][1])
        self.assertEqual(merger_tree.mergers[1][0].in_fifo_2, merger_tree.fifos[2][1][1])
        self.assertEqual(merger_tree.mergers[1][0].out_fifo, merger_tree.fifos[1][0][0])

        self.assertEqual(merger_tree.mergers[1][1].in_fifo_1, merger_tree.fifos[2][2][1])
        self.assertEqual(merger_tree.mergers[1][1].in_fifo_2, merger_tree.fifos[2][3][1])
        self.assertEqual(merger_tree.mergers[1][1].out_fifo, merger_tree.fifos[1][1][0])

        self.assertEqual(merger_tree.mergers[0][0].in_fifo_1, merger_tree.fifos[1][0][1])
        self.assertEqual(merger_tree.mergers[0][0].in_fifo_2, merger_tree.fifos[1][1][1])
        self.assertEqual(merger_tree.mergers[0][0].out_fifo, merger_tree.fifos[0][0][0])                
        
        merger_tree.fifos[3][0][0].push(tree_sim.Tuple([1, 3]))
        merger_tree.fifos[3][0][0].push(tree_sim.Tuple([5, 7]))
        merger_tree.fifos[3][0][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[3][0][0].push(tree_sim.Tuple([0, 0]))
        
        merger_tree.fifos[3][1][0].push(tree_sim.Tuple([2, 4]))
        merger_tree.fifos[3][1][0].push(tree_sim.Tuple([6, 8]))
        merger_tree.fifos[3][1][0].push(tree_sim.Tuple([0, 0]))
        merger_tree.fifos[3][1][0].push(tree_sim.Tuple([0, 0]))        
        
        result = []
        for i in range(0, 30):
            merger_tree.simulate()
            print("---------------------------------------------------------------------------")
            print("CYCLE: " + str(i))
            for level in range(0, len(merger_tree.fifos)):
                for index in range(0, len(merger_tree.fifos[level])):
                    for fifo_indx in [0,1]:
                        print("fifo[" + str(level) + "][" + str(index) + "]["+ str(fifo_indx) \
                              + "]: " + str([x.data for x in merger_tree.fifos[level][index][fifo_indx].data]))

            for level in range(0, len(merger_tree.mergers)):
                for index in range(0, len(merger_tree.mergers[level])):
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_A: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_a.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].FIFO_B: " \
                              + str([x.data for x in merger_tree.mergers[level][index].internal_fifo_b.data]))
                        print("mergers[" + str(level) + "][" + str(index) + "].R_A: " \
                              + str(merger_tree.mergers[level][index].R_A.data))                        
                        print("mergers[" + str(level) + "][" + str(index) + "].R_B: " \
                              + str(merger_tree.mergers[level][index].R_B.data))                        
                    
            if not merger_tree.fifos[0][0][1].empty():
                result+=merger_tree.fifos[0][0][1].pop().data
        print("RESuLT: " + str(result))
        self.assertEqual(result, [0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  0, 0, 0, 0, 0, 0, 0, 0, \
                                  1, 2, 3, 4, 5, 6, 7, 8])        


            
    def test_init_16_16(self):
        merger_tree = tree_sim.MergerTree(16, 16)

    def test_init_32_32(self):
        merger_tree = tree_sim.MergerTree(32, 32)        

if __name__ == "__main__":
    unittest.main()
