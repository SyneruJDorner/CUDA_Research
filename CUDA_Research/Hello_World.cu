#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void hello_cuda()
{
	printf("Hello World from CUDA!");
}

int main()
{
	//How to call the cuda function
	//P1 = 
	//P2 = number of threads to the GPU that is called.
	hello_cuda <<<1, 1>>>();
	cudaDeviceSynchronize(); //Call above is async without this function call!

	cudaDeviceReset();
	return 0;
}