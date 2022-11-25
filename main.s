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
	push	rbp
	mov	rbp, rsp
	sub	rsp, 144
	mov	DWORD PTR -132[rbp], edi        # argc <=> -132[rbp]
	mov	QWORD PTR -144[rbp], rsi        # argv <=> -144[rbp]
	cmp	DWORD PTR -132[rbp], 1          # if (argc == 1) ..
	jne	.L2
	lea	rdi, .LC0[rip]
	call	puts@PLT                    # printf("Enter precision..")
	lea	rax, -28[rbp]                   # precision <=> -28[rbp]
	mov	rsi, rax
	lea	rdi, .LC1[rip]
	mov	eax, 0
	call	__isoc99_scanf@PLT          # scanf("%d", &precision)
	call	__errno_location@PLT        # errno
	mov	eax, DWORD PTR [rax]
	test	eax, eax                    #       ==? 0
	jne	.L3
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, 9                          # precision >? 9
	jg	.L3
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax                    # precision <? 1
	jg	.L4
.L3:
	lea	rdi, .LC2[rip]
	call	puts@PLT                    # printf("Error: incorrect input data\n");
	mov	eax, 1
	jmp	.L17                            # return 1
.L2:
	cmp	DWORD PTR -132[rbp], 2          # if (argc == 2)
	jne	.L6
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8                          # argv[1]
	mov	rax, QWORD PTR [rax]
	lea	rcx, -40[rbp]                   # char *p
	mov	edx, 10
	mov	rsi, rcx
	mov	rdi, rax
	call	strtol@PLT                  # strtol(rdi,      rsi, edx)
	                        # precision = strtol(argv[1],  &p,  10)
	mov	DWORD PTR -28[rbp], eax
	call	__errno_location@PLT        # errno
	mov	eax, DWORD PTR [rax]
	test	eax, eax                    # errno != 0
	jne	.L7
	mov	rax, QWORD PTR -40[rbp]
	movzx	eax, BYTE PTR [rax]
	test	al, al                      # *p != '\0'
	jne	.L7
	mov	eax, DWORD PTR -28[rbp]
	cmp	eax, 9                          # precision > 9
	jg	.L7
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax                    # precision < 1
	jg	.L4
.L7:
	lea	rdi, .LC3[rip]
	call	puts@PLT                    # printf("Error: incorrect terminal argument\n")
	mov	eax, 1
	jmp	.L17
.L6:
	cmp	DWORD PTR -132[rbp], 3          # else if (argc == 3) {
	jne	.L9
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 8
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT                   # f_input = fopen(argv[1], "r");
	mov	QWORD PTR -8[rbp], rax          # f_input <=> -8[rbp]
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16
	mov	rax, QWORD PTR [rax]
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT                   # f_output = fopen(argv[2], "w");
	mov	QWORD PTR -16[rbp], rax         # f_output <=> -16[rbp]
	cmp	QWORD PTR -8[rbp], 0            # if (f_input == NULL
	je	.L10
	cmp	QWORD PTR -16[rbp], 0           #                     || f_output == NULL) {
	jne	.L11
.L10:
	mov	QWORD PTR -128[rbp], 3092014    # char s1[80] <=> -128[rbp]
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
	mov	rdx, QWORD PTR [rax]            # argv[1]
	lea	rax, -128[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT                  # strcat(s1, argv[1])
	lea	rsi, .LC4[rip]
	mov	rdi, rax
	call	fopen@PLT                   # fopen(strcat(s1, argv[1]), "r");
	mov	QWORD PTR -8[rbp], rax
	mov	BYTE PTR -125[rbp], 0           # s1[3] = '\0';
	mov	rax, QWORD PTR -144[rbp]
	add	rax, 16                         # argv[2];
	mov	rdx, QWORD PTR [rax]
	lea	rax, -128[rbp]
	mov	rsi, rdx
	mov	rdi, rax
	call	strcat@PLT                  # strcat(s1, argv[2])
	lea	rsi, .LC5[rip]
	mov	rdi, rax
	call	fopen@PLT                   # f_output = fopen(strcat(s1, argv[2]), "w");
	mov	QWORD PTR -16[rbp], rax
	cmp	QWORD PTR -8[rbp], 0            # if (f_input == NULL
	je	.L12
	cmp	QWORD PTR -16[rbp], 0           #                     || f_output == NULL) {
	jne	.L11
.L12:
	lea	rdi, .LC6[rip]
	call	puts@PLT                    # printf("Cannot open file.\n");
	mov	eax, 0
	jmp	.L17
.L11:
	lea	rdx, -28[rbp]                   # precision
	mov	rax, QWORD PTR -8[rbp]
	lea	rsi, .LC1[rip]                  # "%d"
	mov	rdi, rax                        # f_input
	mov	eax, 0
	call	__isoc99_fscanf@PLT         # fscanf(f_input, "%d", &precision);
	mov	rax, QWORD PTR -8[rbp]          # f_input
	mov	rdi, rax
	call	fclose@PLT                  # fclose(f_input);
	call	__errno_location@PLT        # errno
	mov	eax, DWORD PTR [rax]
	test	eax, eax
	jne	.L14
	mov	eax, DWORD PTR -28[rbp]         # precision
	cmp	eax, 9
	jg	.L14
	mov	eax, DWORD PTR -28[rbp]
	test	eax, eax
	jg	.L4
.L14:
	lea	rdi, .LC7[rip]
	call	puts@PLT                    # printf("Error: incorrect data in input file\n");
	mov	eax, 0
	jmp	.L17
.L9:
	mov	eax, DWORD PTR -132[rbp]
	sub	eax, 1
	mov	esi, eax
	lea	rdi, .LC8[rip]
	mov	eax, 0
	call	printf@PLT                  # printf("Error: incorrect number of args: expected 0, 1 or 2, have %d: \n", argc - 1);
	mov	eax, 0
	jmp	.L17
.L4:
	mov	eax, DWORD PTR -28[rbp]         # precision
	mov	edi, eax
	call	find_zero@PLT               # find_zero(precision);
	movq	rax, xmm0
	mov	QWORD PTR -24[rbp], rax         # double result <=> -24[rbp]
	cmp	DWORD PTR -132[rbp], 3          # if (argc != 3) {
	je	.L15
	mov	eax, DWORD PTR -28[rbp]         # precision
	mov	rdx, QWORD PTR -24[rbp]         # result
	movq	xmm0, rdx
	mov	esi, eax
	lea	rdi, .LC9[rip]                  # "%.*f\n"
	mov	eax, 1
	call	printf@PLT                  # printf("%.*f\n", precision, result);
	jmp	.L16
.L15:
	mov	edx, DWORD PTR -28[rbp]         # precision
	mov	rcx, QWORD PTR -24[rbp]         # result
	mov	rax, QWORD PTR -16[rbp]         # f_output
	movq	xmm0, rcx
	lea	rsi, .LC9[rip]
	mov	rdi, rax
	mov	eax, 1
	call	fprintf@PLT                 # fprintf(f_output, "%.*f\n", precision, result);
.L16:
	mov	eax, 0
.L17:
	leave
	ret
