// This is a generated file. Use and modify at your own risk.
////////////////////////////////////////////////////////////////////////////////

/*******************************************************************************
Vendor: Xilinx
Associated Filename: main.c
#Purpose: This example shows a basic vector add +1 (constant) by manipulating
#         memory inplace.
*******************************************************************************/

#include <fcntl.h>
#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <math.h>
#include <unistd.h>
#include <assert.h>
#include <stdbool.h>
#include <sys/types.h>
#include <sys/stat.h>
#include <sys/time.h>
#include <CL/opencl.h>
#include <CL/cl_ext.h>
#include "xclhal2.h"

////////////////////////////////////////////////////////////////////////////////

#define NUM_WORKGROUPS (1)
#define WORKGROUP_SIZE (256)
#define MAX_LENGTH 8192

#if defined(SDX_PLATFORM) && !defined(TARGET_DEVICE)
#define STR_VALUE(arg)      #arg
#define GET_STRING(name) STR_VALUE(name)
#define TARGET_DEVICE GET_STRING(SDX_PLATFORM)
#endif

////////////////////////////////////////////////////////////////////////////////
//------------------alloc aligned memory---------------------
void *allocate_aligned(size_t size, size_t alignment)
{
   const size_t mask = alignment - 1;
   const uintptr_t mem = (uintptr_t) calloc(size + alignment, 1);
    return (void *) ((mem + mask) & ~mask);
}

int load_file_to_memory(const char *filename, char **result)
{
    uint size = 0;
    FILE *f = fopen(filename, "rb");
    if (f == NULL) {
        *result = NULL;
        return -1; // -1 means file opening fail
    }
    fseek(f, 0, SEEK_END);
    size = ftell(f);
    fseek(f, 0, SEEK_SET);
    *result = (char *)malloc(size+1);
    if (size != fread(*result, sizeof(char), size, f)) {
        free(*result);
        return -2; // -2 means file reading fail
    }
    fclose(f);
    (*result)[size] = 0;
    return size;
}

int main(int argc, char** argv)
{

    cl_int err;                            // error code returned from api calls
    int check_status = 0;
    const uint number_of_words = 148;       // 


    cl_platform_id platform_id;         // platform id
    cl_device_id device_id;             // compute device id
    cl_context context;                 // compute context
    cl_command_queue commands;          // compute command queue
    cl_program program;                 // compute programs
    cl_kernel kernel;                   // compute kernel

    char cl_platform_vendor[1001];
    char target_device_name[1001] = TARGET_DEVICE;

    int h_input_00[number_of_words];                   // host memory for inut vector 00
    int h_input_01[number_of_words];                   // host memory for inut vector 01
    int h_input_02[number_of_words];                   // host memory for inut vector 02
    int h_input_03[number_of_words];                   // host memory for inut vector 03
    int h_input_04[number_of_words];                   // host memory for inut vector 04
    int h_input_05[number_of_words];                   // host memory for inut vector 05
    int h_input_06[number_of_words];                   // host memory for inut vector 06
    int h_input_07[number_of_words];                   // host memory for inut vector 07
    int h_output[MAX_LENGTH];
    
    cl_mem d_00;                                // device memory used for a vector 00
    cl_mem d_01;                                // device memory used for a vector 01
    cl_mem d_02;                                // device memory used for a vector 02
    cl_mem d_03;                                // device memory used for a vector 03
    cl_mem d_04;                                // device memory used for a vector 04
    cl_mem d_05;                                // device memory used for a vector 05
    cl_mem d_06;                                // device memory used for a vector 06
    cl_mem d_07;                                // device memory used for a vector 07
    cl_mem d_08;                                // device memory used for a vector 08

    //int h_software[MAX_LENGTH];                 // software output vector for validation

    FILE *File_0 = fopen("/curr/wkqiao/tmp/merger/file_0.txt", "r");
    FILE *File_1 = fopen("/curr/wkqiao/tmp/merger/file_1.txt", "r");
    FILE *File_2 = fopen("/curr/wkqiao/tmp/merger/file_2.txt", "r");
    FILE *File_3 = fopen("/curr/wkqiao/tmp/merger/file_3.txt", "r");
    FILE *File_4 = fopen("/curr/wkqiao/tmp/merger/file_4.txt", "r");
    FILE *File_5 = fopen("/curr/wkqiao/tmp/merger/file_5.txt", "r");
    FILE *File_6 = fopen("/curr/wkqiao/tmp/merger/file_6.txt", "r");
    FILE *File_7 = fopen("/curr/wkqiao/tmp/merger/file_7.txt", "r");
    FILE *hardFile = fopen("hard_output.txt", "w");

    unsigned char *buffer;
    buffer = (unsigned char *)malloc(1331);

    if (argc != 2) {
        printf("Usage: %s xclbin\n", argv[0]);
        return EXIT_FAILURE;
    }

    // prepare the input data for 8 leaves
    int i = 0;
    fread(buffer, 1, 1331, File_0);
    for(i = 0; i < number_of_words; i++) {
        h_input_00[i] = 0;
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_00[i] = (h_input_00[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_1);
    for(i = 0; i < number_of_words; i++) {
        h_input_01[i] = 0;
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_01[i] = (h_input_01[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_2);
    for(i = 0; i < number_of_words; i++) {
        h_input_02[i] = 0;
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_02[i] = (h_input_02[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_3);
    for(i = 0; i < number_of_words; i++) {
        h_input_03[i] = 0;
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_03[i] = (h_input_03[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_4);
    for(i = 0; i < number_of_words; i++) {
        h_input_04[i] = 0;
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_04[i] = (h_input_04[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_5);
    for(i = 0; i < number_of_words; i++) {
        h_input_05[i] = 0;
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_05[i] = (h_input_05[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_6);
    for(i = 0; i < number_of_words; i++) {
        h_input_06[i] = 0;
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_06[i] = (h_input_06[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }
    fread(buffer, 1, 1331, File_7);
    for(i = 0; i < number_of_words; i++) {
        h_input_07[i] = 0;
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+0] > '9' ? (buffer[9*i+0] - 87) : (buffer[9*i+0] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+1] > '9' ? (buffer[9*i+1] - 87) : (buffer[9*i+1] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+2] > '9' ? (buffer[9*i+2] - 87) : (buffer[9*i+2] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+3] > '9' ? (buffer[9*i+3] - 87) : (buffer[9*i+3] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+4] > '9' ? (buffer[9*i+4] - 87) : (buffer[9*i+4] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+5] > '9' ? (buffer[9*i+5] - 87) : (buffer[9*i+5] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+6] > '9' ? (buffer[9*i+6] - 87) : (buffer[9*i+6] - '0'));
        h_input_07[i] = (h_input_07[i] << 4) + (buffer[9*i+7] > '9' ? (buffer[9*i+7] - 87) : (buffer[9*i+7] - '0'));
    }

    // Fill our data sets with pattern
    for(i = 0; i < MAX_LENGTH; i++) {
        h_output[i] = 0; 
    }

   // Get all platforms and then select Xilinx platform
    cl_platform_id platforms[16];       // platform id
    cl_uint platform_count;
    int platform_found = 0;
    err = clGetPlatformIDs(16, platforms, &platform_count);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to find an OpenCL platform!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    printf("INFO: Found %d platforms\n", platform_count);

    // Find Xilinx Plaftorm
    for (unsigned int iplat=0; iplat<platform_count; iplat++) {
        err = clGetPlatformInfo(platforms[iplat], CL_PLATFORM_VENDOR, 1000, (void *)cl_platform_vendor,NULL);
        if (err != CL_SUCCESS) {
            printf("Error: clGetPlatformInfo(CL_PLATFORM_VENDOR) failed!\n");
            printf("Test failed\n");
            return EXIT_FAILURE;
        }
        if (strcmp(cl_platform_vendor, "Xilinx") == 0) {
            printf("INFO: Selected platform %d from %s\n", iplat, cl_platform_vendor);
            platform_id = platforms[iplat];
            platform_found = 1;
        }
    }
    if (!platform_found) {
        printf("ERROR: Platform Xilinx not found. Exit.\n");
        return EXIT_FAILURE;
    }

   // Get Accelerator compute device
    cl_uint num_devices;
    unsigned int device_found = 0;
    cl_device_id devices[16];  // compute device id
    char cl_device_name[1001];
    err = clGetDeviceIDs(platform_id, CL_DEVICE_TYPE_ACCELERATOR, 16, devices, &num_devices);
    printf("INFO: Found %d devices\n", num_devices);
    if (err != CL_SUCCESS) {
        printf("ERROR: Failed to create a device group!\n");
        printf("ERROR: Test failed\n");
        return -1;
    }

    //iterate all devices to select the target device.
    for (uint i=0; i<num_devices; i++) {
        err = clGetDeviceInfo(devices[i], CL_DEVICE_NAME, 1024, cl_device_name, 0);
        if (err != CL_SUCCESS) {
            printf("Error: Failed to get device name for device %d!\n", i);
            printf("Test failed\n");
            return EXIT_FAILURE;
        }
        printf("CL_DEVICE_NAME %s\n", cl_device_name);
        if(strcmp(cl_device_name, target_device_name) == 0) {
            device_id = devices[i];
            device_found = 1;
            printf("Selected %s as the target device\n", cl_device_name);
       }
    }

    if (!device_found) {
        printf("Target device %s not found. Exit.\n", target_device_name);
        return EXIT_FAILURE;
    }

    // Create a compute context
    //
    context = clCreateContext(0, 1, &device_id, NULL, NULL, &err);
    if (!context) {
        printf("Error: Failed to create a compute context!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    // Create a command commands
    commands = clCreateCommandQueue(context, device_id, 0, &err);
    if (!commands) {
        printf("Error: Failed to create a command commands!\n");
        printf("Error: code %i\n",err);
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    int status;

    // Create Program Objects
    // Load binary from disk
    unsigned char *kernelbinary;
    char *xclbin = argv[1];

    //------------------------------------------------------------------------------
    // xclbin
    //------------------------------------------------------------------------------
    printf("INFO: loading xclbin %s\n", xclbin);
    int n_i0 = load_file_to_memory(xclbin, (char **) &kernelbinary);
    if (n_i0 < 0) {
        printf("failed to load kernel from xclbin: %s\n", xclbin);
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    size_t n0 = n_i0;

    // Create the compute program from offline
    program = clCreateProgramWithBinary(context, 1, &device_id, &n0,
                                        (const unsigned char **) &kernelbinary, &status, &err);

    if ((!program) || (err!=CL_SUCCESS)) {
        printf("Error: Failed to create compute program from binary %d!\n", err);
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    // Build the program executable
    //
    err = clBuildProgram(program, 0, NULL, NULL, NULL, NULL);
    if (err != CL_SUCCESS) {
        size_t len;
        char buffer[2048];

        printf("Error: Failed to build program executable!\n");
        clGetProgramBuildInfo(program, device_id, CL_PROGRAM_BUILD_LOG, sizeof(buffer), buffer, &len);
        printf("%s\n", buffer);
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    // Create the compute kernel in the program we wish to run
    //
     kernel = clCreateKernel(program, "merger_tree", &err);
    if (!kernel || err != CL_SUCCESS) {
        printf("Error: Failed to create compute kernel!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    // Create structs to define memory bank mapping
    cl_mem_ext_ptr_t mem_ext;
    mem_ext.obj = NULL;
    mem_ext.param = kernel;


    mem_ext.flags = 8;
    d_00 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 9;
    d_01 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 10;
    d_02 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 11;
    d_03 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 12;
    d_04 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 13;
    d_05 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 14;
    d_06 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 15;
    d_07 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words, &mem_ext, NULL);
    mem_ext.flags = 16;
    d_08 = clCreateBuffer(context,  CL_MEM_READ_WRITE | CL_MEM_EXT_PTR_XILINX,  sizeof(int) * number_of_words * 8, &mem_ext, NULL);


    if (!(d_00 && d_01 && d_02 && d_03 && d_04 && d_05 && d_06 && d_07 && d_08)) {
        printf("Error: Failed to allocate device memory!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }


    err = clEnqueueWriteBuffer(commands, d_00, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_00, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_00!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_01, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_01, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_01!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_02, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_02, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_02!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_03, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_03, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_03!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_04, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_04, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_04!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_05, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_05, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_05!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_06, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_06, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_06!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }
    err = clEnqueueWriteBuffer(commands, d_07, CL_TRUE, 0, sizeof(int) * number_of_words, h_input_07, 0, NULL, NULL);
    if (err != CL_SUCCESS) {
        printf("Error: Failed to write to source array h_input_07!\n");
        printf("Test failed\n");
        return EXIT_FAILURE;
    }


    // Set the arguments to our compute kernel
    // int vector_length = MAX_LENGTH;
    err = 0;
    cl_uint insize00 = 592;
    cl_uint insize01 = 592;
    cl_uint insize02 = 592;
    cl_uint insize03 = 592;
    cl_uint insize04 = 592;
    cl_uint insize05 = 592;
    cl_uint insize06 = 592;
    cl_uint insize07 = 592;
    err |= clSetKernelArg(kernel, 0, sizeof(cl_uint), &insize00); 
    err |= clSetKernelArg(kernel, 1, sizeof(cl_uint), &insize01); 
    err |= clSetKernelArg(kernel, 2, sizeof(cl_uint), &insize02); 
    err |= clSetKernelArg(kernel, 3, sizeof(cl_uint), &insize03); 
    err |= clSetKernelArg(kernel, 4, sizeof(cl_uint), &insize04); 
    err |= clSetKernelArg(kernel, 5, sizeof(cl_uint), &insize05); 
    err |= clSetKernelArg(kernel, 6, sizeof(cl_uint), &insize06); 
    err |= clSetKernelArg(kernel, 7, sizeof(cl_uint), &insize07); 
    err |= clSetKernelArg(kernel, 8, sizeof(cl_mem), &d_00); 
    err |= clSetKernelArg(kernel, 9, sizeof(cl_mem), &d_01); 
    err |= clSetKernelArg(kernel, 10, sizeof(cl_mem), &d_02); 
    err |= clSetKernelArg(kernel, 11, sizeof(cl_mem), &d_03); 
    err |= clSetKernelArg(kernel, 12, sizeof(cl_mem), &d_04); 
    err |= clSetKernelArg(kernel, 13, sizeof(cl_mem), &d_05); 
    err |= clSetKernelArg(kernel, 14, sizeof(cl_mem), &d_06); 
    err |= clSetKernelArg(kernel, 15, sizeof(cl_mem), &d_07); 
    err |= clSetKernelArg(kernel, 16, sizeof(cl_mem), &d_08); 

    if (err != CL_SUCCESS) {
        printf("Error: Failed to set kernel arguments! %d\n", err);
        printf("Test failed\n");
        return EXIT_FAILURE;
    }

    // Execute the kernel over the entire range of our 1d input data set
    // using the maximum number of work group items for this device

    err = clEnqueueTask(commands, kernel, 0, NULL, NULL);
    if (err) {
            printf("Error: Failed to execute kernel! %d\n", err);
            printf("Test failed\n");
            return EXIT_FAILURE;
        }

    // Read back the results from the device to verify the output
    //
    cl_event readevent;
    clFinish(commands);

    err = 0;
    err |= clEnqueueReadBuffer( commands, d_08, CL_TRUE, 0, sizeof(int) * 8 * 128, h_output, 0, NULL, &readevent );


    if (err != CL_SUCCESS) {
            printf("Error: Failed to read output array! %d\n", err);
            printf("Test failed\n");
            return EXIT_FAILURE;
        }
    clWaitForEvents(1, &readevent);

    // store the hardware sorted input data into text file
	for(i = 0; i < MAX_LENGTH; i++) {
		fprintf(hardFile, "%08x\n", h_output[i]);
	}

    /*
    // Check Results
    for (uint i = 0; i < number_of_words/16; i++) {
        for (uint j = 0; j < 16; j++)
        {
            if (h_software[16*i + j] != h_output[16*i + j]) {
                printf("%d group %d element is not equal, software is %08x, hardware is %08x\n", i, j, h_software[16*i + j], h_output[16*i + j]);
                check_status = 1;
            }
        }       
    }
    */

    //--------------------------------------------------------------------------
    // Shutdown and cleanup
    //-------------------------------------------------------------------------- 
    clReleaseMemObject(d_00);
    clReleaseMemObject(d_01);
    clReleaseMemObject(d_02);
    clReleaseMemObject(d_03);
    clReleaseMemObject(d_04);
    clReleaseMemObject(d_05);
    clReleaseMemObject(d_06);
    clReleaseMemObject(d_07);
    clReleaseMemObject(d_08);


    clReleaseProgram(program);
    clReleaseKernel(kernel);
    clReleaseCommandQueue(commands);
    clReleaseContext(context);

    fclose(File_0);
    fclose(File_1);
    fclose(File_2);
    fclose(File_3);
    fclose(File_4);
    fclose(File_5);
    fclose(File_6);
    fclose(File_7);
    //fclose(softFile);
    fclose(hardFile);
    printf("end test\n");
    /*
    if (check_status) {
        printf("INFO: Test failed\n");
        return EXIT_FAILURE;
    } else {
        printf("INFO: Test completed successfully.\n");
        return EXIT_SUCCESS;
    }
    */

} // end of main
