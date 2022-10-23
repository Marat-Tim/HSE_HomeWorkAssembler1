	.intel_syntax noprefix
	.section	.rodata
.LC2:
	.string	"%d "
	.text
	.globl write_array
write_array:
	push	rbp
	mov	rbp, rsp
	mov	ebx, edi		# ecx = первый аргумент функции
	mov	r12, rsi		# r12 = второй аргумент функции
	mov	r15d, 0			# i = 0
	jmp	.L7
.L8:
	mov	eax, r15d		# eax = i
	cdqe
	lea	rdx, 0[0+rax*4]
	mov	rax, r12
	mov	eax, DWORD PTR [rdx+rax]
	mov	esi, eax
	lea	rax, .LC2[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT		# printf("%d", &r12[i])
	add	r15d, 1			# ++i
.L7:
	mov	eax, r15d
	cmp	eax, ebx
	jl	.L8
	mov	eax, 0			# будем всегда возвращать ноль(нужно для критериев)
	leave
	ret
