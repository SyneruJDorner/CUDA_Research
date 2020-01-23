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

	//Limit for block size x <= 65536, y <= 2^32-1, z <= 65536
	dim3 block(8, 2); //Number of Dimension 3 blocks/threads within each grid

	//Limit for grid size x <= 1024, y <= 1024, z <= 64
	//AND
	//Limit for grid size x * y * z <= 1024
	dim3 grid(nx / block.x, ny / block.y); //Number of Dimension 3 grids on the GPU

	hello_cuda <<<grid, block>>>();
	cudaDeviceSynchronize(); //Call above is async without this function call!

	cudaDeviceReset();
	return 0;
}