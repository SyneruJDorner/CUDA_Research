#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>

__global__ void hello_cuda()
{
	printf("Hello World from CUDA!\n");
}

int main()
{
	int nx = 16, ny = 4;

	dim3 block(8, 2); //Number of Dimension 3 blocks/threads within each grid
	dim3 grid(nx / block.x, ny / block.y); //Number of Dimension 3 grids on the GPU

	hello_cuda <<<grid, block>>>();
	cudaDeviceSynchronize(); //Call above is async without this function call!

	cudaDeviceReset();
	return 0;
}