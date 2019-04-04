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

class TestMerger(unittest.TestCase):

    
if __name__ == "__main__":
    unittest.main()
