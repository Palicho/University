	.file	"problem3.10.c"
	.text
	.globl	arith3
	.type	arith3, @function
arith3:
.LFB0:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	movl	%esi, %ecx
	movl	%edx, %eax
	movl	%edi, %edx
	movw	%dx, -20(%rbp)
	movl	%ecx, %edx
	movw	%dx, -24(%rbp)
	movw	%ax, -28(%rbp)
	movzwl	-24(%rbp), %eax
	orw	-28(%rbp), %ax
	movw	%ax, -2(%rbp)
	movzwl	-2(%rbp), %eax
	sarw	$9, %ax
	movw	%ax, -4(%rbp)
	movzwl	-4(%rbp), %eax
	notl	%eax
	movw	%ax, -6(%rbp)
	movzwl	-24(%rbp), %eax
	movzwl	-6(%rbp), %edx
	subl	%edx, %eax
	movw	%ax, -8(%rbp)
	movzwl	-8(%rbp), %eax
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE0:
	.size	arith3, .-arith3
	.ident	"GCC: (GNU) 12.2.1 20221121 (Red Hat 12.2.1-4)"
	.section	.note.GNU-stack,"",@progbits
