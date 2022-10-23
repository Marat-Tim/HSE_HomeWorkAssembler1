	.file	"code.c"
	.intel_syntax noprefix
	.text
	.local	ARRAY1
	.comm	ARRAY1,40000,32
	.local	ARRAY2
	.comm	ARRAY2,40000,32
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"%d "
	.text
	
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	lea	rax, -12[rbp]		# scanf("%d", &n1);
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	r14d, -12[rbp]
	mov	r15d, 0			# for(i = 0; i < n1; ++i)
	jmp	.L2			# {
.L3:					# 	scanf("%d", &ARRAY1[i]);
	mov	eax, r15d
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY1[rip]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	r15d, 1
.L2:
	mov	eax, r14d
	cmp	r15d, eax
	jl	.L3			# }
	mov	r13d, 0			# n2 = 0;
	mov	r15d, 0			# for (i = 0; i < n1; ++i)
	jmp	.L4			# {
.L6:
	mov	eax, r15d
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY1[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jle	.L5			# 	if (ARRAY1[i] > 0)
	mov	eax, r15d		# 	{
	cdqe				# 		ARRAY2[n2] = ARRAY1[i];
	lea	rdx, 0[0+rax*4]		# 		++n2;
	lea	rax, ARRAY1[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, r13d
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, ARRAY2[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	r13d, 1			# 	}
.L5:
	add	r15d, 1
.L4:
	mov	eax, r14d
	cmp	r15d, eax
	jl	.L6			# }
	mov	edi, r13d
	lea	rsi, ARRAY2[rip]
	call	write_array		# вызов функции
	mov	eax, 0
	leave
	ret
	.size	main, .-main
	.ident	"GCC: (Ubuntu 11.2.0-19ubuntu1) 11.2.0"
	.section	.note.GNU-stack,"",@progbits
	.section	.note.gnu.property,"a"
	.align 8
	.long	1f - 0f
	.long	4f - 1f
	.long	5
0:
	.string	"GNU"
1:
	.align 8
	.long	0xc0000002
	.long	3f - 2f
2:
	.long	0x3
3:
	.align 8
4:
