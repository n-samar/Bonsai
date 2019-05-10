SHELL:=/bin/bash
CC := gcc
VERILOG := iverilog
VVP := vvp
LIST_INPUT_SIZE := 128

clean :
	rm -f *.txt datagen *.vcd

merger_1 : MERGER.v AUTO_tb.v BITONIC_NETWORK.v FIFO.v
	iverilog -o merger FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v  AUTO_tb.v

datagen :
	gcc -o datagen datagen.c

data : datagen
	./datagen 2 $(LIST_INPUT_SIZE) 1; \
	./datagen 16 $(LIST_INPUT_SIZE) 1; \
	./datagen 32 $(LIST_INPUT_SIZE) 1; \
	./datagen 64 $(LIST_INPUT_SIZE) 1; \
	./datagen 128 $(LIST_INPUT_SIZE) 1; \
	./datagen 128 32 1; \
	cat ans_16_128.txt > ans_16_128_2.txt; \
	cat ans_16_128.txt >> ans_16_128_2.txt; \
	cat ans_16_128_2.txt > ans_16_128_4.txt; \
	cat ans_16_128_2.txt >> ans_16_128_4.txt; \
	cat ans_32_128.txt > ans_32_128_2.txt; \
	cat ans_32_128.txt >> ans_32_128_2.txt; \
	cat ans_32_128_2.txt > ans_32_128_4.txt; \
	cat ans_32_128_2.txt >> ans_32_128_4.txt; \
	cat ans_64_128.txt > ans_64_128_2.txt; \
	cat ans_64_128.txt >> ans_64_128_2.txt; \
	cat ans_64_128_2.txt > ans_64_128_4.txt; \
	cat ans_64_128_2.txt >> ans_64_128_4.txt; \
	cat ans_128_32.txt > ans_128_32_2.txt; \
	cat ans_128_32.txt >> ans_128_32_2.txt; \
	cat ans_128_32_2.txt > ans_128_32_4.txt; \
	cat ans_128_32_2.txt >> ans_128_32_4.txt; \

compile_merger_1 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v  AUTO_tb.v
	$(VERILOG) -o merger FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v  AUTO_tb.v

compile_tree_P1_L8 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_tb.v
	$(VERILOG) -o merger FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_tb.v

compile_tree_P1_L8_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_GLOBAL_RESET_tb.v
	$(VERILOG) -o merger FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_GLOBAL_RESET_tb.v

compile_tree_P1_L16 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_tb.v

compile_tree_P1_L16_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_GLOBAL_RESET_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_GLOBAL_RESET_tb.v

compile_tree_P1_L32 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_tb.v

compile_tree_P1_L32_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_GLOBAL_RESET_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_GLOBAL_RESET_tb.v

compile_tree_P1_L64 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_tb.v

compile_tree_P1_L64_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_GLOBAL_RESET_tb.v
	$(VERILOG) -o merger FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_GLOBAL_RESET_tb.v

sim_merger_1 : compile_merger_1 merger
	$(VVP) merger

sim_tree_P1_L8 : compile_tree_P1_L8 merger
	$(VVP) merger

sim_tree_P1_L8_global_reset : compile_tree_P1_L8_global_reset merger
	$(VVP) merger

sim_tree_P1_L16 : compile_tree_P1_L16 merger
	$(VVP) merger

sim_tree_P1_L16_global_reset : compile_tree_P1_L16_global_reset merger
	$(VVP) merger

sim_tree_P1_L32 : compile_tree_P1_L32 merger
	$(VVP) merger

sim_tree_P1_L32_global_reset : compile_tree_P1_L32_global_reset merger
	$(VVP) merger

sim_tree_P1_L64 : compile_tree_P1_L64 merger
	$(VVP) merger

sim_tree_P1_L64_global_reset : compile_tree_P1_L64_global_reset merger
	$(VVP) merger

filter_output_merger_1 : sim_merger_1 data
	sed '/^00000000$$/d' out_2_128.txt > out_no_zeros_2_128.txt
	sed '/^00000000$$/d' ans_2_128.txt > ans_no_zeros_2_128.txt

filter_output_tree_P1_L8 : data sim_tree_P1_L8
	sed '/^00000000$$/d' out_16_128.txt > out_no_zeros_16_128.txt
	sed '/^00000000$$/d' ans_16_128.txt > ans_no_zeros_16_128.txt

filter_output_tree_P1_L8_global_reset : data sim_tree_P1_L8_global_reset
	sed '/^00000000$$/d' out_16_128_4.txt > out_no_zeros_16_128_4.txt
	sed '/^00000000$$/d' ans_16_128_4.txt > ans_no_zeros_16_128_4.txt

filter_output_tree_P1_L16 : data sim_tree_P1_L16
	sed '/^00000000$$/d' out_32_128.txt > out_no_zeros_32_128.txt
	sed '/^00000000$$/d' ans_32_128.txt > ans_no_zeros_32_128.txt

filter_output_tree_P1_L16_global_reset : data sim_tree_P1_L16_global_reset
	sed '/^00000000$$/d' out_32_128_4.txt > out_no_zeros_32_128_4.txt
	sed '/^00000000$$/d' ans_32_128_4.txt > ans_no_zeros_32_128_4.txt

filter_output_tree_P1_L32 : data sim_tree_P1_L32
	sed '/^00000000$$/d' out_64_128.txt > out_no_zeros_64_128.txt
	sed '/^00000000$$/d' ans_64_128.txt > ans_no_zeros_64_128.txt

filter_output_tree_P1_L32_global_reset : data sim_tree_P1_L32_global_reset
	sed '/^00000000$$/d' out_64_128_4.txt > out_no_zeros_64_128_4.txt
	sed '/^00000000$$/d' ans_64_128_4.txt > ans_no_zeros_64_128_4.txt

filter_output_tree_P1_L64 : data sim_tree_P1_L64
	sed '/^00000000$$/d' out_128_128.txt > out_no_zeros_128_128.txt
	sed '/^00000000$$/d' ans_128_128.txt > ans_no_zeros_128_128.txt

filter_output_tree_P1_L64_global_reset : data sim_tree_P1_L64_global_reset
	sed '/^00000000$$/d' out_128_32_4.txt > out_no_zeros_128_32_4.txt
	sed '/^00000000$$/d' ans_128_32_4.txt > ans_no_zeros_128_32_4.txt

test_merger_1 : compile_merger_1 sim_merger_1 filter_output_merger_1 out_no_zeros_2_128.txt ans_no_zeros_2_128.txt
	if [[ $$(diff -u out_no_zeros_2_128.txt ans_no_zeros_2_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST MERGER_1' 1>&2; \
	else \
		echo 'SUCESS! merger_1' 1>&2; \
	fi

test_tree_P1_L8 : compile_tree_P1_L8 filter_output_tree_P1_L8 out_no_zeros_16_128.txt ans_no_zeros_16_128.txt sim_tree_P1_L8 merger 
	if [[ $$(diff -u out_no_zeros_16_128.txt ans_no_zeros_16_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L8' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L8' 1>&2; \
	fi

test_tree_P1_L8_global_reset : compile_tree_P1_L8 filter_output_tree_P1_L8_global_reset out_no_zeros_16_128_4.txt ans_no_zeros_16_128_4.txt sim_tree_P1_L8 merger 
	if [[ $$(diff -u out_no_zeros_16_128_4.txt ans_no_zeros_16_128_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L8_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L8_global_reset' 1>&2; \
	fi


test_tree_P1_L16 : compile_tree_P1_L16 filter_output_tree_P1_L16 out_no_zeros_32_128.txt ans_no_zeros_32_128.txt sim_tree_P1_L16 merger 
	if [[ $$(diff -u out_no_zeros_32_128.txt ans_no_zeros_32_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L16' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L16' 1>&2; \
	fi

test_tree_P1_L16_global_reset : filter_output_tree_P1_L16_global_reset out_no_zeros_32_128_4.txt ans_no_zeros_32_128_4.txt sim_tree_P1_L16 merger 
	if [[ $$(diff -u out_no_zeros_32_128_4.txt ans_no_zeros_32_128_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L16_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L16_global_reset' 1>&2; \
	fi

test_tree_P1_L32 : compile_tree_P1_L32 filter_output_tree_P1_L32 out_no_zeros_64_128.txt ans_no_zeros_64_128.txt sim_tree_P1_L32 merger 
	if [[ $$(diff -u out_no_zeros_64_128.txt ans_no_zeros_64_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L32' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L32' 1>&2; \
	fi

test_tree_P1_L32_global_reset : filter_output_tree_P1_L32_global_reset out_no_zeros_64_128_4.txt ans_no_zeros_64_128_4.txt sim_tree_P1_L32 merger 
	if [[ $$(diff -u out_no_zeros_64_128_4.txt ans_no_zeros_64_128_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L32_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L32_global_reset' 1>&2; \
	fi

test_tree_P1_L64 : compile_tree_P1_L64 filter_output_tree_P1_L64 out_no_zeros_128_128.txt ans_no_zeros_128_128.txt sim_tree_P1_L64 merger 
	if [[ $$(diff -u out_no_zeros_128_128.txt ans_no_zeros_128_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L64' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L64' 1>&2; \
	fi

test_tree_P1_L64_global_reset : filter_output_tree_P1_L64_global_reset out_no_zeros_128_32_4.txt ans_no_zeros_128_32_4.txt sim_tree_P1_L64 merger 
	if [[ $$(diff -u out_no_zeros_128_32_4.txt ans_no_zeros_128_32_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L64_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L64_global_reset' 1>&2; \
	fi

test_all : test_tree_P1_L64 test_tree_P1_L32_global_reset test_tree_P1_L32 test_tree_P1_L16_global_reset test_tree_P1_L16 data test_tree_P1_L8 test_tree_P1_L8_global_reset test_merger_1 
	echo "All tests run." 1>&2;
