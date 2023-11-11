# Pipelines in AA

- A pipeline has many stages, where the work done in each stage has to be balanced and independent of each other.
- Suppose we have three stages A, B and C in a pipeline

```
while(1){
    y = A(x)
    z = B(y)
    w = Z(z)
}
```
```
y0 = A(x0)
-----------------------
z0 = B(y0) | y1 = A(x1)
---------------------------------
w0 = Z(z0) | z1 = B(y1) | y2 = A(x2)

```
## "A loop if implemented correctly can be a pipeline and we can ilicit parallelism"

- Suppose A takes 1 unit of time, B takes 2 units of time and C takes 1 unit of time
- We are limited by the resource which takes the maximal delay. C is idle for some cycles waiting for B
```
C |   X O M
B | XXOOMM
A |XOM
```
- One way we can address this by splitting B into two stages B1, B2
- Another way (if we cannot split B), is to create two instances of B (Bo, Be) and odd jobs to one and even jobs to the other

```
$branchblock[loop]{
    $dopipeline $depth 7 $fullrate
    $merge $entry $loopback $endmerge
    a := in_data
    b := (a + 1)
    c := (b*b)
    out_data := c
    $while 1
}
```
- Specifying the depth as 7, we tell the compiler to keep 7 iterations alive at the same time (4 $\le$ 7), hence the pipeline works, the compiler can provide hints on what to choose this as, it is a design choice.
```
=> | RD | S1 | S2 | WR | =>
// S1 does a + 1
// S2 does b * b

R0
S10 | R1  |
S20 | S11 | R2
W0  | S21 | S12
    | W0  | S22

```

- If we have the need for forwarding of a variable to a later stage, we use a buffering stage to make sure that the early variable reaches in time whenever required by the computation (`AaOpt` performs such optimizations) 

```
$branchblock[loop]{
    $dopipeline $depth 31 $fullrate
        $merge $entry $loopback 
            $phi I := $zero<8> $on $entry nI $on $loopback
        $endmerge
        $volatile nI := I + 1 //combinational logic
        $volatile continue_flag := (I < (order  - 1))
        C[I] := (A[I] * B[I])
    $while 1
}

```

```mermaid
graph TD;
    I-->Load A[I];
    I-->Load B[I];
    Load A[I]-->*;
    Load B[I]-->*;
    * --> Store C[I];
```
- The load and store operations take more time than the `*` operation