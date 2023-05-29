Compilation Order
0	dmem.vhd 
	I'm not using my dmem.vhd for testing in lab three, so you don't need to compile it, or you can let the later dmem_le.vhd to overwrite it. 
1	xorgate.vhd  
2	half_adder.vhd  
3	full_adder.vhd  
4	adder64.vhd  
5	add.vhd  
6	mux5.vhd  
7	mux64.vhd  
8	alu.vhd  
9	alucontrol.vhd  
10	and2.vhd  
11	cpucontrol.vhd  
12	shiftleft2.vhd  
14	signextend.vhd  
14	zeromux.vhd  
15	pc.vhd  
16	registers.vhd  
17	dmem_le.vhd  
18	imem.vhd (To test LSL, LSR, CBNZ, ORR)  
19	singlecyclecpu.vhd  
20	singlecyclecpu_tb.vhd  
21	imem_comp.vhd (To test computation)  
22	imem_ldstr.vhd (To test communication)  
23	imem_p1.vhd (To test final)  
	Following tbs are for part of my updated components, you don't need to compile them.
24	signextend_tb.vhd   
25	alu_tb.vhd  
26	alucontrol_tb.vhd  
