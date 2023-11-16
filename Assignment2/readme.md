## EE789 Assignment 2

### Name : Rohan Rajesh Kalbag, Roll No. 20D170033

- The problem statements can be found in `mmul.pdf`
- Detailed information on the logic, code and benchmarking results can be found in `Solution.pdf`

## Instructions to run the code

- To run any project do the following (make sure that the Docker container is running)

```bash
cd <project_name>
make
```
- Create two terminals and run the following commands in each of them

```bash
./testbench_hw
```
```bash
./ahir_system_testbench --wave=waveform.ghw
``` 
> The output as expected by the testbench.c file which was provided will be seen on the terminal, the testbench has not been modified
- Open the waveform in gtkwave on the host system

```bash
gtkwave waveform.ghw
```

## Question 1
- The original implementation provided of the dot product can be found in `/dot_product`
- The unrolled implementation can be found in `/dot_product_unroll`
- The parallelized and unrolled implementation can be found in `/dot_product_parallel_unroll`

## Question 2
- The original implementation dividing the matrix into 4 parts can be found in `/divide_into_four_impl`
- The unrolled implementation can be found in `/divide_into_four_impl_unroll`
- The parallelized and unrolled implementation can be found in `/divide_into_four_impl_parallel_unroll`

## Question 3
- The original implementation performing matrix multiplication as a sum of outer products can be found in `/sum_of_outer_products`
- The unrolled implementation can be found in `/sum_of_outer_products_unroll`
- The parallelized and unrolled implementation can be found in `/sum_of_outer_products_parallel_unroll`