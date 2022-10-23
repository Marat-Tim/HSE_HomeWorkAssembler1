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
	
	# функция принимает в качестве первого аргумента количество элементов в массиве, в качестве второго - начало массива и печатает весь массив
	.globl write_array
write_array:
	push	rbp
	mov	rbp, rsp
	mov	ebx, edi		# ecx = первый аргумент функции
	mov	r12, rsi		# r12 = второй аргумент функции
	sub	rsp, 16			# int i(+12 лишних для выравнивания)
	mov	DWORD PTR -4[rbp], 0	# i = 0
	jmp	.L7
.L8:
	mov	eax, DWORD PTR -4[rbp]	# eax = i
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, r12
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT		# printf("%d", &r12[i])
	add	DWORD PTR -4[rbp], 1	# ++i
.L7:
	mov	eax, DWORD PTR -4[rbp]
	cmp	eax, ebx
	jl	.L8
	mov	eax, 0			# будем всегда возвращать ноль(нужно для критериев)
	leave
	ret
	
	.globl	main
	.type	main, @function
main:
	endbr64
	push	rbp
	mov	rbp, rsp
	sub	rsp, 32
	mov	DWORD PTR -20[rbp], edi	# argc
	mov	QWORD PTR -32[rbp], rsi	# argv
	lea	rax, -12[rbp]		# scanf("%d", &n1);
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	DWORD PTR -4[rbp], 0	# for(i = 0; i < n1; ++i)
	jmp	.L2			# {
.L3:					# 	scanf("%d", &ARRAY1[i]);
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY1[rip]
	add	rax, rdx
	mov	rsi, rax
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	DWORD PTR -4[rbp], 1
.L2:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L3			# }
	mov	DWORD PTR -8[rbp], 0	# n2 = 0;
	mov	DWORD PTR -4[rbp], 0	# for (i = 0; i < n1; ++i)
	jmp	.L4			# {
.L6:
	mov	eax, DWORD PTR -4[rbp]
	cdqe
	lea	rdx, 0[0+rax*4]
	lea	rax, ARRAY1[rip]
	mov	eax, DWORD PTR [rdx+rax]
	test	eax, eax
	jle	.L5			# 	if (ARRAY1[i] > 0)
	mov	eax, DWORD PTR -4[rbp]	# 	{
	cdqe				# 		ARRAY2[n2] = ARRAY1[i];
	lea	rdx, 0[0+rax*4]		# 		++n2;
	lea	rax, ARRAY1[rip]
	mov	eax, DWORD PTR [rdx+rax]
	mov	edx, DWORD PTR -8[rbp]
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]
	lea	rdx, ARRAY2[rip]
	mov	DWORD PTR [rcx+rdx], eax
	add	DWORD PTR -8[rbp], 1	# 	}
.L5:
	add	DWORD PTR -4[rbp], 1
.L4:
	mov	eax, DWORD PTR -12[rbp]
	cmp	DWORD PTR -4[rbp], eax
	jl	.L6			# }
	mov	edi, DWORD PTR -8[rbp]
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
