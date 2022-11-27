	.file	"functions.c"
	.intel_syntax noprefix
	.text
	.data
	.align 32
	.type	pow10, @object
	.size	pow10, 88
pow10:                      # набор констант для разной точности
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
function:                               # xmm0 = x
	push	rbp
	mov	rbp, rsp
	movapd	xmm1, xmm0
	mulsd	xmm1, xmm1                  # xmm1 := x^2
    movapd	xmm2, xmm1                  # xmm2 := x^2
	mulsd	xmm2, xmm0                  # xmm2 = x^3

	movsd	xmm3, QWORD PTR .LC0[rip]   # xmm3 := 0.5
	mulsd	xmm3, xmm1                  # xmm3 = x^2 * 0.5
	subsd	xmm2, xmm3                  # xmm2 = x^3 - x^2 * 0.5

	movsd	xmm3, QWORD PTR .LC1[rip]   # xmm3 := 0.2
	mulsd	xmm3, xmm0                  # xmm3 = x * 0.2
	addsd	xmm2, xmm3                  # xmm2 = x^3 - x^2 * 0.5 + x * 0.2

	movsd	xmm1, QWORD PTR .LC2[rip]   # xmm1 := 4
	movapd  xmm0, xmm2
	subsd	xmm0, xmm1                  # xmm0 = x^3 - x^2 * 0.5 + x * 0.2 - 4
	pop	rbp                             # f(x)
	ret

	.size	function, .-function
	.globl	find_zero
	.type	find_zero, @function
find_zero:
	push	rbp
	mov	rbp, rsp
	sub	rsp, 40
	mov	DWORD PTR -36[rbp], edi             # int precision <=> -36[rbp]
	movsd	xmm0, QWORD PTR .LC3[rip]
	movsd	QWORD PTR -8[rbp], xmm0         # double l = 1
	                                        # l <=> -8[rbp]
	movsd	xmm0, QWORD PTR .LC4[rip]
	movsd	QWORD PTR -16[rbp], xmm0        # double r = 3
                                            # r <=> -16[rbp]
	mov	eax, DWORD PTR -36[rbp]
	add	eax, 1                              # ..[precision+1]
	lea	rdx, 0[0+rax*8]
	lea	rax, pow10[rip]
	movsd	xmm0, QWORD PTR [rdx+rax]       # pow10[precision+1]
	movsd	QWORD PTR -24[rbp], xmm0        # double step = pow10[precision+1]
	                                        # step <=> -24[rbp]
	jmp	.L4
.L7:
	movsd	xmm0, QWORD PTR -16[rbp]
	addsd	xmm0, QWORD PTR -8[rbp]
	movsd	xmm1, QWORD PTR .LC5[rip]       # xmm1 := 2
	divsd	xmm0, xmm1                      # xmm0 := (r + l) / 2
	movsd	QWORD PTR -32[rbp], xmm0        # double m = (r + l) / 2
	                                        # double m <=> -32[rbp]
	mov	rax, QWORD PTR -32[rbp]
	movq	xmm0, rax
	call	function                        # if (function(m)..
	pxor	xmm1, xmm1
	comisd	xmm1, xmm0
	jbe	.L10                                 #                .. < 0
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -8[rbp], xmm0         # l := m
	jmp	.L4
.L10:
	movsd	xmm0, QWORD PTR -32[rbp]
	movsd	QWORD PTR -16[rbp], xmm0        # r := m
.L4:
	movsd	xmm0, QWORD PTR -16[rbp]        # xmm0 := r
	subsd	xmm0, QWORD PTR -8[rbp]         #           - l
	comisd	xmm0, QWORD PTR -24[rbp]        #                 >? step
	ja	.L7
	movsd	xmm0, QWORD PTR -16[rbp]        # xmm0 := r
	leave
	ret                                     # return r

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
