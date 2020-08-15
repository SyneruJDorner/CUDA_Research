#include "cuda_runtime.h"
#include "device_launch_parameters.h"

#include <stdio.h>
#include <stdlib.h>
#include <cstring>
#include <time.h>

__global__ void mem_transfer_test(int* input)
{
	int grid_id = blockIdx.x * blockDim.x + threadIdx.x;
	printf("thread ID: %d, grid ID: %d, value: %d\n", threadIdx.x, grid_id, input[grid_id]);
}

__global__ void mem_transfer_test2(int* input, int size)
{
	int grid_id = blockIdx.x * blockDim.x + threadIdx.x;

	if (grid_id < size)
		printf("thread ID: %d, grid ID: %d, value: %d\n", threadIdx.x, grid_id, input[grid_id]);
}

int main()
{
	int size = 150;
	int byte_size = size * sizeof(int);

	int* host_input;
	host_input = (int*)malloc(byte_size);

	time_t t;
	srand((unsigned)time(&t));

	for (int i = 0; i < size; i++)
	{
		host_input[i] = (int)(rand() & 0xff);
	}

	int* device_input;
	cudaMalloc((void**)&device_input, byte_size);
	cudaMemcpy(device_input, host_input, byte_size, cudaMemcpyHostToDevice);

	dim3 block(32);
	dim3 grid(5);

	mem_transfer_test2<<<grid , block>>>(device_input, size);
	cudaDeviceSynchronize();

	cudaFree(device_input);
	free(host_input);

	cudaDeviceReset();
	return 0;
}