	.file	"M.c"
	.text
	.globl	M
	.type	M, @function
M:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movq	%rdi, -8(%rbp)
	cmpq	$0, -8(%rbp)
	jne	.L2
	movl	$0, %edx
	jmp	.L3
.L2:
	movq	-8(%rbp), %rax
	subq	$1, %rax
	movq	%rax, %rdi
	call	M
	movq	%rax, %rdi
	call	F
	movq	-8(%rbp), %rdx
	subq	%rax, %rdx
.L3:
	movq	%rdx, %rax
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	M, .-M
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
