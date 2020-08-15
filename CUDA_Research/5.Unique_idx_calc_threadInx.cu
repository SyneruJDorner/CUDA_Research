#include "cuda_runtime.h"
#include "device_launch_parameters.h"
#include<stdio.h>

__global__ void unique_idx_calc_threadInx(int* input)
{
	int thread_id = threadIdx.x;
	printf("threadIdx: %d, value: %d \n", thread_id, input[thread_id]);
}

__global__ void unique_grid_calculation(int* input)
{
	int thread_id = threadIdx.x;
	int offset = blockIdx.x * blockDim.x;
	int grid_id = thread_id + offset;
	printf("blockIdx.x: %d, threadIdx: %d, gid: %d, value: %d \n",
		blockIdx.x, thread_id, grid_id, input[grid_id]);
}

/*
int main()
{
	int array_size = 16;
	int array_byte_size = sizeof(int) * array_size;
	int h_data[] = { 23, 9, 4, 53, 65, 12, 1, 33, 87, 45, 23, 12, 342, 56, 44, 99 };

	for (int i = 0; i < array_size; i++)
	{
		printf("%d ", h_data[i]);
	}

	printf("\n\n");

	int* d_data;
	cudaMalloc((void**)&d_data, array_byte_size);
	cudaMemcpy(d_data, h_data, array_byte_size, cudaMemcpyHostToDevice);

	dim3 block(4);
	dim3 grid(4);

	unique_grid_calculation<<<grid, block>>>(d_data);
	cudaDeviceSynchronize();

	cudaDeviceReset();
	return 0;
}
*/