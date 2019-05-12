SHELL:=/bin/bash
CC := gcc
VERILOG := iverilog
VVP := vvp
LIST_INPUT_SIZE := 128

clean :
	rm -f *.txt datagen *.vcd *.txt~

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
	./datagen 2 $(LIST_INPUT_SIZE) 1 2; \
	./datagen 16 $(LIST_INPUT_SIZE) 1 2; \
	./datagen 2 $(LIST_INPUT_SIZE) 1 4; \
	cat ans_16_128.txt > ans_16_128_gl2.txt; \
	cat ans_16_128.txt >> ans_16_128_gl2.txt; \
	cat ans_16_128_gl2.txt > ans_16_128_gl4.txt; \
	cat ans_16_128_gl2.txt >> ans_16_128_gl4.txt; \
	cat ans_32_128.txt > ans_32_128_gl2.txt; \
	cat ans_32_128.txt >> ans_32_128_gl2.txt; \
	cat ans_32_128_gl2.txt > ans_32_128_gl4.txt; \
	cat ans_32_128_gl2.txt >> ans_32_128_gl4.txt; \
	cat ans_64_128.txt > ans_64_128_gl2.txt; \
	cat ans_64_128.txt >> ans_64_128_gl2.txt; \
	cat ans_64_128_gl2.txt > ans_64_128_gl4.txt; \
	cat ans_64_128_gl2.txt >> ans_64_128_gl4.txt; \
	cat ans_128_32.txt > ans_128_32_gl2.txt; \
	cat ans_128_32.txt >> ans_128_32_gl2.txt; \
	cat ans_128_32_gl2.txt > ans_128_32_gl4.txt; \
	cat ans_128_32_gl2.txt >> ans_128_32_gl4.txt; \
	cat ans_16_128_2.txt > ans_16_128_2_gl2.txt; \
	cat ans_16_128_2.txt >> ans_16_128_2_gl2.txt; \
	cat ans_16_128_2_gl2.txt > ans_16_128_2_gl4.txt; \
	cat ans_16_128_2_gl2.txt >> ans_16_128_2_gl4.txt;

compile_merger_1 : data FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v  AUTO_tb.v
	$(VERILOG) -o merger_1 FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v  AUTO_tb.v

compile_merger_2 : data FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v  MERGER_2_AUTO_tb.v
	$(VERILOG) -o merger_2 FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v  MERGER_2_AUTO_tb.v;

compile_merger_4 : data FIFO.v MERGER_4.v CONTROL.v BITONIC_NETWORK_8.v  MERGER_4_tb.v
	$(VERILOG) -o merger_4 FIFO.v MERGER_4.v CONTROL.v BITONIC_NETWORK_8.v  MERGER_4_tb.v;

compile_tree_P1_L8 : data FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_tb.v
	$(VERILOG) -o tree_P1_L8 FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_tb.v;

compile_tree_P2_L8 : data FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v MERGER_TREE_P2_L8.v MERGER_TREE_P2_L8_tb.v
	$(VERILOG) -o tree_P2_L8 FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v MERGER_TREE_P2_L8.v MERGER_TREE_P2_L8_tb.v;

compile_tree_P2_L8_global_reset : data FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v MERGER_TREE_P2_L8.v MERGER_TREE_P2_L8_GLOBAL_RESET_tb.v
	$(VERILOG) -o tree_P2_L8_gl FIFO.v MERGER_2.v CONTROL.v BITONIC_NETWORK_4.v MERGER_TREE_P2_L8.v MERGER_TREE_P2_L8_GLOBAL_RESET_tb.v;

compile_tree_P1_L8_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_GLOBAL_RESET_tb.v
	$(VERILOG) -o tree_P1_L8_gl FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L8_auto.v MERGER_TREE_P1_L8_AUTOMATIC_GLOBAL_RESET_tb.v

compile_tree_P1_L16 : data FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_tb.v
	$(VERILOG) -o tree_P1_L16 FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_tb.v

compile_tree_P1_L16_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_GLOBAL_RESET_tb.v
	$(VERILOG) -o tree_P1_L16_gl FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L16.v MERGER_TREE_P1_L16_GLOBAL_RESET_tb.v

compile_tree_P1_L32 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_tb.v
	$(VERILOG) -o tree_P1_L32 FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_tb.v

compile_tree_P1_L32_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_GLOBAL_RESET_tb.v
	$(VERILOG) -o tree_P1_L32_gl FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L32.v MERGER_TREE_P1_L32_GLOBAL_RESET_tb.v

compile_tree_P1_L64 : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_tb.v
	$(VERILOG) -o tree_P1_L64 FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_tb.v

compile_tree_P1_L64_global_reset : FIFO.v MERGER.v CONTROL.v BITONIC_NETWORK.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_GLOBAL_RESET_tb.v
	$(VERILOG) -o tree_P1_L64_gl FIFO.v BITONIC_NETWORK.v MERGER.v CONTROL.v MERGER_TREE_P1_L64.v MERGER_TREE_P1_L64_GLOBAL_RESET_tb.v

sim_merger_1 : compile_merger_1 merger
	$(VVP) merger_1

sim_merger_2 : compile_merger_2 merger
	$(VVP) merger_2

sim_merger_4 : compile_merger_4 merger
	$(VVP) merger_4

sim_tree_P1_L8 : compile_tree_P1_L8 merger
	$(VVP) tree_P1_L8;

sim_tree_P2_L8 : compile_tree_P2_L8 tree_P2_L8
	$(VVP) tree_P2_L8;

sim_tree_P2_L8_global_reset : compile_tree_P2_L8_global_reset tree_P2_L8_gl
	$(VVP) tree_P2_L8_gl;

sim_tree_P1_L8_global_reset : compile_tree_P1_L8_global_reset merger
	$(VVP) tree_P1_L8_gl;

sim_tree_P1_L16 : compile_tree_P1_L16 merger
	$(VVP) tree_P1_L16

sim_tree_P1_L16_global_reset : compile_tree_P1_L16_global_reset merger
	$(VVP) tree_P1_L16_gl

sim_tree_P1_L32 : compile_tree_P1_L32 merger
	$(VVP) tree_P1_L32

sim_tree_P1_L32_global_reset : compile_tree_P1_L32_global_reset merger
	$(VVP) tree_P1_L32_gl

sim_tree_P1_L64 : compile_tree_P1_L64 merger
	$(VVP) tree_P1_L64

sim_tree_P1_L64_global_reset : compile_tree_P1_L64_global_reset merger
	$(VVP) tree_P1_L64

filter_output_merger_1 : sim_merger_1 data
	sed '/^00000000$$/d' out_2_128.txt > out_no_zeros_2_128.txt
	sed '/^00000000$$/d' ans_2_128.txt > ans_no_zeros_2_128.txt

filter_output_merger_2 : sim_merger_4 data
	sed '/^0000000000000000$$/d' out_2_128_2.txt > out_no_zeros_2_128_2.txt
	sed '/^0000000000000000$$/d' ans_2_128_2.txt > ans_no_zeros_2_128_2.txt

filter_output_merger_4 : sim_merger_4 data
	sed '/^00000000000000000000000000000000$$/d' out_2_128_4.txt > out_no_zeros_2_128_4.txt
	sed '/^00000000000000000000000000000000$$/d' ans_2_128_4.txt > ans_no_zeros_2_128_4.txt

filter_output_tree_P1_L8 : data sim_tree_P1_L8
	sed '/^00000000$$/d' out_16_128.txt > out_no_zeros_16_128.txt
	sed '/^00000000$$/d' ans_16_128.txt > ans_no_zeros_16_128.txt

filter_output_tree_P2_L8 : data sim_tree_P2_L8
	sed '/^0000000000000000$$/d' out_16_128_2.txt > out_no_zeros_16_128_2.txt
	sed '/^0000000000000000$$/d' ans_16_128_2.txt > ans_no_zeros_16_128_2.txt

filter_output_tree_P2_L8_global_reset : data sim_tree_P2_L8_global_reset
	sed '/^0000000000000000$$/d' out_16_128_2_gl4.txt > out_no_zeros_16_128_2_gl4.txt
	sed '/^0000000000000000$$/d' ans_16_128_2_gl4.txt > ans_no_zeros_16_128_2_gl4.txt

filter_output_tree_P1_L8_global_reset : data sim_tree_P1_L8_global_reset
	sed '/^00000000$$/d' out_16_128_gl4.txt > out_no_zeros_16_128_gl4.txt
	sed '/^00000000$$/d' ans_16_128_gl4.txt > ans_no_zeros_16_128_gl4.txt

filter_output_tree_P1_L16 : data sim_tree_P1_L16
	sed '/^00000000$$/d' out_32_128.txt > out_no_zeros_32_128.txt
	sed '/^00000000$$/d' ans_32_128.txt > ans_no_zeros_32_128.txt

filter_output_tree_P1_L16_global_reset : data sim_tree_P1_L16_global_reset
	sed '/^00000000$$/d' out_32_128_gl4.txt > out_no_zeros_32_128_gl4.txt
	sed '/^00000000$$/d' ans_32_128_gl4.txt > ans_no_zeros_32_128_gl4.txt

filter_output_tree_P1_L32 : data sim_tree_P1_L32
	sed '/^00000000$$/d' out_64_128.txt > out_no_zeros_64_128.txt
	sed '/^00000000$$/d' ans_64_128.txt > ans_no_zeros_64_128.txt

filter_output_tree_P1_L32_global_reset : data sim_tree_P1_L32_global_reset
	sed '/^00000000$$/d' out_64_128_gl4.txt > out_no_zeros_64_128_gl4.txt
	sed '/^00000000$$/d' ans_64_128_gl4.txt > ans_no_zeros_64_128_gl4.txt

filter_output_tree_P1_L64 : data sim_tree_P1_L64
	sed '/^00000000$$/d' out_128_128.txt > out_no_zeros_128_128.txt
	sed '/^00000000$$/d' ans_128_128.txt > ans_no_zeros_128_128.txt

filter_output_tree_P1_L64_global_reset : data sim_tree_P1_L64_global_reset
	sed '/^00000000$$/d' out_128_32_gl4.txt > out_no_zeros_128_32_gl4.txt
	sed '/^00000000$$/d' ans_128_32_gl4.txt > ans_no_zeros_128_32_gl4.txt

test_merger_1 : compile_merger_1 sim_merger_1 filter_output_merger_1 out_no_zeros_2_128.txt ans_no_zeros_2_128.txt
	if [[ $$(diff -u out_no_zeros_2_128.txt ans_no_zeros_2_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST MERGER_1' 1>&2; \
	else \
		echo 'SUCESS! merger_1' 1>&2; \
	fi

test_merger_2 : data compile_merger_2 sim_merger_2 filter_output_merger_2 out_no_zeros_2_128_2.txt ans_no_zeros_2_128_2.txt merger
	if [[ $$(diff -u out_no_zeros_2_128_2.txt ans_no_zeros_2_128_2.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST MERGER_2' 1>&2; \
	else \
		echo 'SUCESS! merger_2' 1>&2; \
	fi

test_merger_4 : data compile_merger_4 sim_merger_4 filter_output_merger_4 out_no_zeros_2_128_4.txt ans_no_zeros_2_128_4.txt merger
	if [[ $$(diff -u out_no_zeros_2_128_4.txt ans_no_zeros_2_128_4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST MERGER_4' 1>&2; \
	else \
		echo 'SUCESS! merger_4' 1>&2; \
	fi

test_tree_P1_L8 : compile_tree_P1_L8 filter_output_tree_P1_L8 out_no_zeros_16_128.txt ans_no_zeros_16_128.txt sim_tree_P1_L8 merger 
	if [[ $$(diff -u out_no_zeros_16_128.txt ans_no_zeros_16_128.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L8' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L8' 1>&2; \
	fi

test_tree_P2_L8 : data compile_tree_P2_L8 sim_tree_P2_L8 filter_output_tree_P2_L8 out_no_zeros_16_128_2.txt ans_no_zeros_16_128_2.txt
	if [[ $$(diff -u out_no_zeros_16_128_2.txt ans_no_zeros_16_128_2.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P2_L8' 1>&2; \
	else \
		echo 'SUCESS! tree_P2_L8' 1>&2; \
	fi

test_tree_P2_L8_global_reset : data compile_tree_P2_L8_global_reset sim_tree_P2_L8_global_reset filter_output_tree_P2_L8_global_reset out_no_zeros_16_128_2_gl4.txt ans_no_zeros_16_128_2_gl4.txt
	if [[ $$(diff -u out_no_zeros_16_128_2_gl4.txt ans_no_zeros_16_128_2_gl4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P2_L8_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P2_L8_global_reset' 1>&2; \
	fi

test_tree_P1_L8_global_reset : compile_tree_P1_L8 filter_output_tree_P1_L8_global_reset out_no_zeros_16_128_gl4.txt ans_no_zeros_16_128_gl4.txt sim_tree_P1_L8 merger 
	if [[ $$(diff -u out_no_zeros_16_128_gl4.txt ans_no_zeros_16_128_gl4.txt) ]]; then \
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

test_tree_P1_L16_global_reset : filter_output_tree_P1_L16_global_reset out_no_zeros_32_128_gl4.txt ans_no_zeros_32_128_gl4.txt sim_tree_P1_L16 merger 
	if [[ $$(diff -u out_no_zeros_32_128_gl4.txt ans_no_zeros_32_128_gl4.txt) ]]; then \
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

test_tree_P1_L32_global_reset : filter_output_tree_P1_L32_global_reset out_no_zeros_64_128_gl4.txt ans_no_zeros_64_128_gl4.txt sim_tree_P1_L32 merger 
	if [[ $$(diff -u out_no_zeros_64_128_gl4.txt ans_no_zeros_64_128_gl4.txt) ]]; then \
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

test_tree_P1_L64_global_reset : filter_output_tree_P1_L64_global_reset out_no_zeros_128_32_gl4.txt ans_no_zeros_128_32_gl4.txt sim_tree_P1_L64 merger 
	if [[ $$(diff -u out_no_zeros_128_32_gl4.txt ans_no_zeros_128_32_gl4.txt) ]]; then \
		echo 'ERROR! OUTPUT MISMATCH FOR TEST TREE_P1_L64_GLOBAL_RESET' 1>&2; \
	else \
		echo 'SUCESS! tree_P1_L64_global_reset' 1>&2; \
	fi

test_all : test_merger_4 test_tree_P2_L8_global_reset test_tree_P2_L8 test_merger_2 test_tree_P1_L64_global_reset test_tree_P1_L64 test_tree_P1_L32_global_reset test_tree_P1_L32 test_tree_P1_L16_global_reset test_tree_P1_L16 data test_tree_P1_L8 test_tree_P1_L8_global_reset test_merger_1 
	echo "All tests run." 1>&2;
