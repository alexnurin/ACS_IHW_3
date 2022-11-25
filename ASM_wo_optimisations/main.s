	.file	"main.c"
	.intel_syntax noprefix
	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Enter precision - the number of decimal places (from 1 to 9): "    # строковые константы:
.LC1:
	.string	"%d"
.LC2:
	.string	"Error: incorrect input data"
	.align 8
.LC3:
	.string	"Error: incorrect terminal argument"
.LC4:
	.string	"r"
.LC5:
	.string	"w"
.LC6:
	.string	"Cannot open file."
	.align 8
.LC7:
	.string	"Error: incorrect data in input file"
	.align 8
.LC8:
	.string	"Error: incorrect number of args: expected 0, 1 or 2, have %d: \n"
.LC9:
	.string	"%.*f\n"

	.text
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144
	mov	DWORD PTR -132[rbp], edi        # argc <=> -132[rbp]
	mov	QWORD PTR -144[rbp], rsi        # argv <=> -80[rbp]
	cmp	DWORD PTR -132[rbp], 1
	jne	.L2
	lea	rdi, .LC0[rip]
	call	puts@PLT
	lea	rax, -28[rbp]
	mov	rsi, rax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT
	call	__errno_location@PLT
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L3
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, 9
	jg	.L3
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax
	jg	.L4
.L3:
	lea	rdi, .LC2[rip]
	call	puts@PLT
	mov	eax, 1
	jmp	.L17
.L2:
	cmp	DWORD PTR -132[rbp], 2
	jne	.L6
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rcx, -40[rbp]
	mov	edx, 10
	mov	rsi, rcx
	mov	rdi, rax
	call	strtol@PLT
	mov	DWORD PTR -28[rbp], eax
	call	__errno_location@PLT
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L7
	mov	rax, QWORD PTR -40[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al
	jne	.L7
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, 9
	jg	.L7
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax
	jg	.L4
.L7:
	lea	rdi, .LC3[rip]
	call	puts@PLT
	mov	eax, 1
	jmp	.L17
.L6:
	cmp	DWORD PTR -132[rbp], 3
	jne	.L9
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	je	.L10
	cmp	QWORD PTR -16[rbp], 0
	jne	.L11
.L10:
	mov	QWORD PTR -128[rbp], 3092014
	mov	QWORD PTR -120[rbp], 0
	mov	QWORD PTR -112[rbp], 0
	mov	QWORD PTR -104[rbp], 0
	mov	QWORD PTR -96[rbp], 0
	mov	QWORD PTR -88[rbp], 0
	mov	QWORD PTR -80[rbp], 0
	mov	QWORD PTR -72[rbp], 0
	mov	QWORD PTR -64[rbp], 0
	mov	QWORD PTR -56[rbp], 0
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rdx, QWORD PTR [rax]
	lea	rax, -128[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -8[rbp], rax
	mov	BYTE PTR -125[rbp], 0
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rdx, QWORD PTR [rax]
	lea	rax, -128[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 0
	je	.L12
	cmp	QWORD PTR -16[rbp], 0
	jne	.L11
.L12:
	lea	rdi, .LC6[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L17
.L11:
	lea	rdx, -28[rbp]
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_fscanf@PLT
	mov	rax, QWORD PTR -8[rbp]
	mov	rdi, rax
	call	fclose@PLT
	call	__errno_location@PLT
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L14
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, 9
	jg	.L14
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax
	jg	.L4
.L14:
	lea	rdi, .LC7[rip]
	call	puts@PLT
	mov	eax, 0
	jmp	.L17
.L9:
	mov	eax, DWORD PTR -132[rbp]
	sub	eax, 1
	mov	esi, eax
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT
	mov	eax, 0
	jmp	.L17
.L4:
	mov	eax, DWORD PTR -28[rbp]
	mov	edi, eax
	call	find_zero@PLT
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax
	cmp	DWORD PTR -132[rbp], 3
	je	.L15
	mov	eax, DWORD PTR -28[rbp]
	mov	rdx, QWORD PTR -24[rbp]
	movq	xmm0, rdx
	mov	esi, eax
	lea	rdi, .LC9[rip]
	mov	eax, 1
	call	printf@PLT
	jmp	.L16
.L15:
	mov	edx, DWORD PTR -28[rbp]
	mov	rcx, QWORD PTR -24[rbp]
	mov	rax, QWORD PTR -16[rbp]
	movq	xmm0, rcx
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT
.L16:
	mov	eax, 0
.L17:
	leave
	ret
	.size	main, .-main
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
