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
    def test_init(self):
        with self.assertRaises(Exception):
            tuple = tree_sim.Tuple([5, 4, 3, 2, 1])

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
        print(result)
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
        
        
if __name__ == "__main__":
    unittest.main()
