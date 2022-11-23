pow10:
	.long	0
	.long	1072693248
	.long	2576980378
	.long	1069128089
	.long	1202590843
	.long	1065646817
	.long	3539053052
	.long	1062232653
	.long	3944497965
	.long	1058682594
	.long	2296604913
	.long	1055193269
	.long	2696277389
	.long	1051772663
	.long	2596056904
	.long	1048238066
	.long	3794832442
	.long	1044740494
	.long	3894859413
	.long	1041313291
	.long	3654794683
	.long	1037794527
	.text
	.globl	function
	.type	function, @function
function:
	endbr64
	push	rbp
	mov	rbp, rsp
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR -8[rbp]
	mulsd	xmm0, xmm0
	movapd	xmm1, xmm0
	mulsd	xmm1, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR -8[rbp]
	movapd	xmm2, xmm0
	mulsd	xmm2, xmm0
	movsd	xmm0, QWORD PTR .LC0[rip]
	mulsd	xmm0, xmm2
	subsd	xmm1, xmm0
	movsd	xmm2, QWORD PTR -8[rbp]
	movsd	xmm0, QWORD PTR .LC1[rip]
	mulsd	xmm0, xmm2
	addsd	xmm0, xmm1
	movsd	xmm1, QWORD PTR .LC2[rip]
	subsd	xmm0, xmm1
	pop	rbp
	ret
	.size	function, .-function
	.globl	find_zero
	.type	find_zero, @function
find_zero:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	DWORD PTR -36[rbp], edi
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR -8[rbp], xmm0
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -16[rbp], xmm0
	mov	eax, DWORD PTR -36[rbp]
	add	eax, 1
	cdqe
	lea	rdx, 0[0+rax*8]
	lea	rax, pow10[rip]
	movsd	xmm0, QWORD PTR [rdx+rax]
	movsd	QWORD PTR -24[rbp], xmm0
	jmp	.L4
.L7:
	movsd	xmm0, QWORD PTR -16[rbp]
	addsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC5[rip]
	divsd	xmm0, xmm1
	movsd	QWORD PTR -32[rbp], xmm0
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	function
	pxor	xmm1, xmm1
	comisd	xmm1, xmm0
	jbe	.L10
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -8[rbp], xmm0
	jmp	.L4
.L10:
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -16[rbp], xmm0
.L4:
	movsd	xmm0, QWORD PTR -16[rbp]
	subsd	xmm0, QWORD PTR -8[rbp]
	comisd	xmm0, QWORD PTR -24[rbp]
	ja	.L7
	movsd	xmm0, QWORD PTR -16[rbp]
	leave
	ret
	.size	find_zero, .-find_zero
	.section	.rodata
	.align 8
.LC0:
	.long	0
	.long	1071644672
	.align 8
.LC1:
	.long	2576980378
	.long	1070176665
	.align 8
.LC2:
	.long	0
	.long	1074790400
	.align 8
.LC3:
	.long	0
	.long	1072693248
	.align 8
.LC4:
	.long	0
	.long	1074266112
	.align 8
.LC5:
	.long	0
	.long	1073741824
	.ident	"GCC: (Ubuntu 9.3.0-10ubuntu2) 9.3.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	 1f - 0f
	.long	 4f - 1f
	.long	 5
0:
	.string	 "GNU"
1:
	.align 8
	.long	 0xc0000002
	.long	 3f - 2f
2:
	.long	 0x3
3:
	.align 8
4:
