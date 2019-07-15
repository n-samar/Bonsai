SHELL:=/bin/bash
CC := gcc
VERILOG := iverilog
VVP := vvp

clean :
	rm -f *.txt datagen *.vcd *.txt~

datagen :
	gcc -o datagen test/datagen.c


data : datagen
	python test/datagen.py
	./datagen 16 128 1;

test_tree_P4_L4_32b : data src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L4_32b.v test/MERGER_TREE_P4_L4_32b_tb.v src/COUPLER.v
	$(VERILOG) -o tree_P4_L4_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/MERGER_TREE_P4_L4_32b.v test/MERGER_TREE_P4_L4_32b_tb.v;
	$(VVP) tree_P4_L4_32b;
	sed '/^0*$$/d' out_8_4_4_1_4.txt > out_no_zeros_8_4_4_1_4.txt;
	sed '/^0*$$/d' ans_8_4_4_1_4.txt > ans_no_zeros_8_4_4_1_4.txt;
	if [[ $$(diff -u out_no_zeros_8_4_4_1_4.txt ans_no_zeros_8_4_4_1_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P4_L4_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P4_L4_32b' 1>&2; \
	fi

test_tree_P8_L8_32b : data src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8_32b.v test/MERGER_TREE_P8_L8_32b_tb.v src/COUPLER.v
	$(VERILOG) -o tree_P8_L8_32b src/COUPLER.v src/FIFO.v src/MERGER.v src/MERGER_8.v src/MERGER_4.v src/MERGER_2.v src/CONTROL.v src/BITONIC_NETWORK.v src/BITONIC_NETWORK_4.v src/BITONIC_NETWORK_8.v src/BITONIC_NETWORK_16.v src/MERGER_TREE_P8_L8_32b.v test/MERGER_TREE_P8_L8_32b_tb.v;
	$(VVP) tree_P8_L8_32b;	
	sed '/^0*$$/d' out_16_128_1_8.txt > out_no_zeros_16_128_1_8.txt;
	sed '/^0*$$/d' ans_16_128_1_8.txt > ans_no_zeros_16_128_1_8.txt;
	if [[ $$(diff -u out_no_zeros_16_128_1_8.txt ans_no_zeros_16_128_1_8.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P8_L8_32b' 1>&2; \
	else \
		echo 'SUCESS! tree_P8_L8_32b' 1>&2; \
	fi

test_all : test_tree_P4_L4_32b test_tree_P8_L8_32b
	echo "All tests run." 1>&2;
