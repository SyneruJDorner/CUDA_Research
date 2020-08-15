#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<stdio.h>

__global__ void unique_grid_id_calculation_2d(int* data)
{
	int thread_id = threadIdx.x;
	int block_offset = blockIdx.x * blockDim.x;
	int row_offset = blockDim.x * gridDim.x * blockIdx.y;
	int grid_id = row_offset + block_offset + thread_id;
	printf("blockIdx.x: %d, blockIdx.y: %d, threadIdx.x: %d, grid ID: %d, - data : %d \n",
		blockIdx.x, blockIdx.y, thread_id, grid_id, data[grid_id]);
}

/*
int main()
{
	int array_size = 16;
	int array_byte_size = sizeof(int) * array_size;
	int h_data[] = { 23, 9, 4, 53, 65, 12, 1, 33, 87, 45, 23, 12, 342, 56, 44, 99 };

	int* d_data;
	cudaMalloc((void**)&d_data, array_byte_size);
	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);

	dim3 block(4);
	dim3 grid(2, 2);

	unique_grid_id_calculation_2d<<<grid, block>>>(d_data);
	cudaDeviceSynchronize();

	cudaDeviceReset();
	return 0;
}
*/