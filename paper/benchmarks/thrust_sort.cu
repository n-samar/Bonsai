#include <thrust/host_vector.h>
#include <thrust/device_vector.h>
#include <thrust/generate.h>
#include <thrust/copy.h>
#include <cstdlib>
#include <time.h>

int main(void) {
    clock_t start, end;
    clock_t start_gen, end_gen;
    double total_time, total_time_gen;

    start_gen = clock();
    // generate 4GB of 32-bit random data
    thrust::host_vector<int> h_vec(16ul << 26);
    thrust::generate(h_vec.begin(), h_vec.end(), rand);
    end_gen = clock();
    printf("HELLO\n");

    start = clock();
    for (int i = 0; i<10; i++) {
    	//transfer data to the device
	thrust::device_vector<int> d_vec = h_vec;

	// sort data on the device
	thrust::sort(d_vec.begin(), d_vec.end());

	// transfer data back to host
	thrust::copy(d_vec.begin(), d_vec.end(), h_vec.begin());
    }			    
    end = clock();
    total_time = (end-start)/(double)CLOCKS_PER_SEC/10.0;
    total_time_gen = (end_gen-start_gen)/(double)CLOCKS_PER_SEC;
    printf("\nAverage time to sort 4GB of 32-bit integers: %fsec\n", total_time);
    printf("Total time to generate 4GB of 32-bit integers: %fsec\n", total_time_gen);    
    return 0;
}