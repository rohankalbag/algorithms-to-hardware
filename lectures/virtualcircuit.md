# Virtual Circuit

- `AA -> VC -> VHDL`, The `AA` language has control as well as data description

```
module[foo]{
    a := (b + c) // S1 U1
    p := (b - c) // S2 U2
    v := (a * p) // S3 U3
}
```
- Each of these operations is like an entry step and exit step for a component. We should be able to pipeline these operations as well, i.e add new tokens to free stages of the pipeline. 
- There is sampling action and update action for each of the step, where Si and Ui are the sampling and update actions for the ith step.
- How to note the dependencies between the Si and Ui

```
digraph G {

  start -> S1;
  start -> S2;
  start -> U1;
  start -> U2;
  S1 -> U1[style=dotted];
  S2 -> U2[style=dotted];
  S3 -> U3[style=dotted];
  U1 -> S3[style=bold];
  U2 -> S3[style=bold];

}

```
- Dotted lines are internal dependencies for the adder units
- Bold lines are the dependencies between adder outputs and multiplier inputs
- `Sr` and `Sa` are control signals for each of the components, `Sr` is the sample request and `Sa` is the sample acknowledgement
- `Ur` and `Ua` are control signals for each of the components, `Ur` is the update request and `Ua` is the update acknowledgement

```
digraph G {
  Sr1
  Sa1
  Ua1
  Ur3
  Ua3
  Sa3
  Ua2
  Sr2 -> Sa2[style=dotted]
  Sr1 -> Sa1[style=dotted]
  Sr3 -> Sa3[style=dotted]
  Ur2 -> Sr3
  Ur1 -> Sr3

}

```

- `Sa` is combinationally dependent on `Sr` and `Sa` is causally dependent on `Sr` and can return in the same clock cycle (sampling can be immediate)
- `Ua` gets asserted one clock cycle after `Ur` is asserted, Ur` is causally dependent on `Ua`, but it will take one clock cycle to update the value of the register.

```
L1: a := (b + c)
L2: d := (a + e)
```
- `a` in L1 and `a` in L2 have a dependency intra loop
-  `a` in L2 and `a` in L1 have a dependency inter loop

```
digraph G {
 sl1
 ul1
 sl2
 ul2
 ul1 -> sl2
 sl2 -> ul1
}
```

```
digraph G {
 slr1
 sla1
 ulr1
 ula1
 slr2
 sla2
 ulr2
 ula2
 ula1 -> slr2
 sla2 -> ulr1
 ulr1 -> ula1[style=dotted]
 slr2 -> sla2[sytle=dotted]
}
```
- We see that we have a cycle in the graph, we need to make sure that there is no combinational cycle, they should be in separate clock cycles, cycles across different clock cycles are safe.
- A combinational circuit with a cycle is a latch which may have its own internal states, we need to make sure that we do not have latches or internal states in our design.