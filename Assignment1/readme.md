
## EE789 Assignment 2

### Name : Rohan Rajesh Kalbag, Roll No. 20D170033

This project is divided into two main parts, each addressing a specific problem statement outlined in the `muldiv.pdf` document.

## Instructions to run the code

- To run any project do the following (make sure that the Docker container is running)

```bash
cd project_folder
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

## Question 1: Shift and Subtract Multiplier Circuit

The solution for this problem can be found in the `Question_1` directory. This includes all the necessary files and documentation related to the design of a shift and add multiplier and shift.

## Question 2: Shift and Subtract Divider Circuit 

The solution for this problem is located in the `Question_2` directory. This includes all the necessary files and documentation related to the shift and subtract divider circuit using AA.

Please refer to the respective directories for detailed information and instructions on each problem.