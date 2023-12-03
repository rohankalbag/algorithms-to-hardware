# High Level Synthesis using Algorithmic Assembly

## EE789 : Algorithmic Design of Digital Systems

### Course Instructor : Prof. Madhav P Desai

> [Algorithmic Assembly (AA)](https://github.com/madhavPdesai/ahir) is an Intermediate Representation (IR) for the AHIRv2 C to VHDL compiler which was developed at IIT Bombay 

This contains my solutions to the course assignments 
1. Design of [Shift and Add Multiplier](https://github.com/rohankalbag/ee789-iitb/blob/main/Assignment1/Question_1/Solution.pdf) and [Shift and Subtract Divider](https://github.com/rohankalbag/ee789-iitb/blob/main/Assignment1/Question_2/Solution.pdf) Circuit using AA
2. Hardware Acceleration of [Matrix Multiplication](https://github.com/rohankalbag/ee789-iitb/blob/main/Assignment2/Solution.pdf) using Loop Optimizations, Parallelism in AA

### Frequently Used Commands 

```bash
tar -xvzf path/filename.tgz
docker exec -it container_name /bin/bash
```

```bash
# for x86 based Processors
sudo docker run -it -v $(pwd)/:/home/examples/ ee789_ahir_img
```

```bash
# for arm64 based Apple Silicon
sudo docker run --platform linux/amd64 -it -v $(pwd)/:/home/examples/ ee789_ahir_img
```
