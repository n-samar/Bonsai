SHELL:=/bin/bash
CC := gcc
VERILOG := iverilog
VVP := vvp

clean :
	rm -f *.txt datagen *.vcd *.txt~

test_tree_P4_L4_32b : src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L4_32b.v test/MERGER_TREE_P4_L4_32b_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=32 --value_bits=0 --leaf_count=8 --runs=4 --elems_per_run=4 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L4_32b";
	$(VERILOG) -o tree_P4_L4_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L4_32b.v test/MERGER_TREE_P4_L4_32b_tb.v;
	$(VVP) tree_P4_L4_32b;
	sed '/^0*$$/d' out_P4_L4_32b.txt > out_no_zeros_P4_L4_32b.txt;
	sed '/^0*$$/d' ans_P4_L4_32b.txt > ans_no_zeros_P4_L4_32b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L4_32b.txt ans_no_zeros_P4_L4_32b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L4_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L4_32b' 1>&2; \
	fi

test_tree_P8_L8_32b : src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8_32b.v test/MERGER_TREE_P8_L8_32b_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=32 --value_bits=0 --leaf_count=16 --runs=1 --elems_per_run=127 --o_elems_per_line=8 --i_elems_per_line=1 --suff="P8_L8_32b";
	$(VERILOG) -o tree_P8_L8_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8_32b.v test/MERGER_TREE_P8_L8_32b_tb.v;
	$(VVP) tree_P8_L8_32b;	
	sed '/^0*$$/d' out_P8_L8_32b.txt > out_no_P8_L8_32b.txt;
	sed '/^0*$$/d' ans_P8_L8_32b.txt > ans_no_zeros_P8_L8_32b.txt;
	if [[ $$(diff -u out_no_zeros_P8_L8_32b.txt ans_no_zeros_P8_L8_32b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P8_L8_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P8_L8_32b' 1>&2; \
	fi


test_tree_P8_L8_128b : src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8.v test/MERGER_TREE_P8_L8_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=80 --value_bits=48 --leaf_count=16 --runs=1 --elems_per_run=15 --o_elems_per_line=8 --i_elems_per_line=1 --suff="P8_L8_128b";
	$(VERILOG) -o tree_P8_L8 src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8.v test/MERGER_TREE_P8_L8_tb.v;
	$(VVP) tree_P8_L8;	
	sed '/^0*$$/d' out_P8_L8_128b.txt > out_no_zeros_P8_L8_128b.txt;
	sed '/^0*$$/d' ans_P8_L8_128b.txt > ans_no_zeros_P8_L8_128b.txt;
	if [[ $$(diff -u out_no_zeros_P8_L8_128b.txt ans_no_zeros_P8_L8_128b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P8_L8_128b' 1>&2; \
	else \
		echo 'SUCESS! tree_P8_L8_128b' 1>&2; \
	fi

test_tree_P4_L4_128b : src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L4.v test/MERGER_TREE_P4_L4_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=80 --value_bits=48 --leaf_count=8 --runs=1 --elems_per_run=15 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L4_128b";
	$(VERILOG) -o tree_P4_L4 src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L4.v test/MERGER_TREE_P4_L4_tb.v;
	$(VVP) tree_P4_L4;	
	sed '/^0*$$/d' out_P4_L4_128b.txt > out_no_zeros_P4_L4_128b.txt;
	sed '/^0*$$/d' ans_P4_L4_128b.txt > ans_no_zeros_P4_L4_128b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L4_128b.txt ans_no_zeros_P4_L4_128b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L4_128b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L4_128b' 1>&2; \
	fi


test_tree_P4_L16_32b : src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L16_32b.v test/MERGER_TREE_P4_L16_32b_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=32 --value_bits=0 --leaf_count=32 --runs=4 --elems_per_run=4 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L16_32b";
	$(VERILOG) -o tree_P4_L16_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L16_32b.v test/MERGER_TREE_P4_L16_32b_tb.v;
	$(VVP) tree_P4_L16_32b;
	sed '/^0*$$/d' out_P4_L16_32b.txt > out_no_zeros_P4_L16_32b.txt;
	sed '/^0*$$/d' ans_P4_L16_32b.txt > ans_no_zeros_P4_L16_32b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L16_32b.txt ans_no_zeros_P4_L16_32b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L16_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L16_32b' 1>&2; \
	fi

test_tree_P4_L16_128b : src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L16.v test/MERGER_TREE_P4_L16_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=80 --value_bits=48 --leaf_count=32 --runs=1 --elems_per_run=15 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L16_128b";
	$(VERILOG) -o tree_P4_L16 src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L16.v test/MERGER_TREE_P4_L16_tb.v;
	$(VVP) tree_P4_L16;	
	sed '/^0*$$/d' out_P4_L16_128b.txt > out_no_zeros_P4_L16_128b.txt;
	sed '/^0*$$/d' ans_P4_L16_128b.txt > ans_no_zeros_P4_L16_128b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L16_128b.txt ans_no_zeros_P4_L16_128b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L16_128b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L16_128b' 1>&2; \
	fi



test_tree_P4_L64_32b : src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L64_32b.v test/MERGER_TREE_P4_L64_32b_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=32 --value_bits=0 --leaf_count=128 --runs=2 --elems_per_run=4 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L64_32b";
	$(VERILOG) -o tree_P4_L64_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L64_32b.v test/MERGER_TREE_P4_L64_32b_tb.v;
	$(VVP) tree_P4_L64_32b;
	sed '/^0*$$/d' out_P4_L64_32b.txt > out_no_zeros_P4_L64_32b.txt;
	sed '/^0*$$/d' ans_P4_L64_32b.txt > ans_no_zeros_P4_L64_32b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L64_32b.txt ans_no_zeros_P4_L64_32b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L64_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L64_32b' 1>&2; \
	fi


test_tree_P4_L64_128b : src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L64.v test/MERGER_TREE_P4_L64_tb.v src/COUPLER.v test/datagen.py
	python test/datagen.py --seed=1 --key_bits=80 --value_bits=48 --leaf_count=128 --runs=1 --elems_per_run=7 --o_elems_per_line=4 --i_elems_per_line=1 --suff="P4_L64_128b";
	$(VERILOG) -o tree_P4_L64 src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P4_L64.v test/MERGER_TREE_P4_L64_tb.v;
	$(VVP) tree_P4_L64;	
	sed '/^0*$$/d' out_P4_L64_128b.txt > out_no_zeros_P4_L64_128b.txt;
	sed '/^0*$$/d' ans_P4_L64_128b.txt > ans_no_zeros_P4_L64_128b.txt;
	if [[ $$(diff -u out_no_zeros_P4_L64_128b.txt ans_no_zeros_P4_L64_128b.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L64_128b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L64_128b' 1>&2; \
	fi


test_all : test_tree_P4_L4_32b test_tree_P4_L4_32b test_tree_P8_L8_128b test_tree_P4_L16_32b test_tree_P4_L16_128b test_tree_P4_L64_32b test_tree_P4_L64_128b
	echo "All tests run." 1>&2;
