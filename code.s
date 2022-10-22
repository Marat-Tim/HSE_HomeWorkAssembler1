	.file	"code.c"
	.intel_syntax noprefix
	.text
	.local	ARRAY1		# / int ARRAY1[10000]
	.comm	ARRAY1,40000,32 # \
	.local	ARRAY2		# / int ARRAY2[10000]
	.comm	ARRAY2,40000,32 # \
	.section	.rodata
.LC0:
	.string	"%d"
.LC1:
	.string	"%d "
	.text
	.globl	main
	.type	main, @function
main:
.LFB0:
	.cfi_startproc
	endbr64
	push	rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	mov	rbp, rsp
	.cfi_def_cfa_register 6
	sub	rsp, 48			# создаем место для переменных n1, n2, i
	mov	DWORD PTR -36[rbp], edi	# argc = edi
	mov	QWORD PTR -48[rbp], rsi	# argv = rsi
	mov	rax, QWORD PTR fs:40
	mov	QWORD PTR -8[rbp], rax
	xor	eax, eax
	lea	rax, -20[rbp]		# rax = &n1
	mov	rsi, rax		
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	mov	DWORD PTR -16[rbp], 0	# i = 0
	jmp	.L2
.L3:
	mov	eax, DWORD PTR -16[rbp]	# eax = i
	cdqe
	lea	rdx, 0[0+rax*4]		# rdx = i * 4
	lea	rax, ARRAY1[rip]	# /
	add	rax, rdx		# | rax = ARRAY1[i]
	mov	rsi, rax		# \
	lea	rax, .LC0[rip]
	mov	rdi, rax
	mov	eax, 0
	call	__isoc99_scanf@PLT
	add	DWORD PTR -16[rbp], 1	# ++i
.L2:
	mov	eax, DWORD PTR -20[rbp]	# eax = n1
	cmp	DWORD PTR -16[rbp], eax # сравниваем i и n1
	jl	.L3
	mov	DWORD PTR -12[rbp], 0	# n2 = 0
	mov	DWORD PTR -16[rbp], 0	# i = 0
	jmp	.L4
.L6:
	mov	eax, DWORD PTR -16[rbp] # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]		# /
	lea	rax, ARRAY1[rip]	# | eax = ARRAY1[i]
	mov	eax, DWORD PTR [rdx+rax]# \	
	test	eax, eax		# / Если элемент меньше или равен нулю, то пропускаем условную конструкцию
	jle	.L5			# \
	mov	eax, DWORD PTR -16[rbp]	# eax = i
	cdqe
	lea	rdx, 0[0+rax*4]		# /
	lea	rax, ARRAY1[rip]	# | eax = ARRAY1[i]
	mov	eax, DWORD PTR [rdx+rax]# \
	mov	edx, DWORD PTR -12[rbp] # edx = n2
	movsx	rdx, edx
	lea	rcx, 0[0+rdx*4]		# /
	lea	rdx, ARRAY2[rip]	# | ARRAY2[i] = eax(который равен ARRAY1[i])
	mov	DWORD PTR [rcx+rdx], eax# \
	add	DWORD PTR -12[rbp], 1	# ++n2
.L5:
	add	DWORD PTR -16[rbp], 1	# ++i
.L4:
	mov	eax, DWORD PTR -20[rbp]	# eax = n1
	cmp	DWORD PTR -16[rbp], eax	# сравниваем i и n1
	jl	.L6
	mov	DWORD PTR -16[rbp], 0	# i = 0
	jmp	.L7
.L8:
	mov	eax, DWORD PTR -16[rbp] # eax = i
	cdqe
	lea	rdx, 0[0+rax*4]		# /
	lea	rax, ARRAY2[rip]	# | esi = ARRAY2[i]
	mov	eax, DWORD PTR [rdx+rax]# |
	mov	esi, eax		# \
	lea	rax, .LC1[rip]
	mov	rdi, rax
	mov	eax, 0
	call	printf@PLT
	add	DWORD PTR -16[rbp], 1	# ++i
.L7:
	mov	eax, DWORD PTR -16[rbp]	# eax = i
	cmp	eax, DWORD PTR -12[rbp]	# сравниваем i и n2
	jl	.L8
	mov	eax, 0
	mov	rdx, QWORD PTR -8[rbp]
	sub	rdx, QWORD PTR fs:40
	je	.L10
	call	__stack_chk_fail@PLT
.L10:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
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
