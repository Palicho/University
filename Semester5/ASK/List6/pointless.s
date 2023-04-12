	.global pointless
	
	.text
pointless:
	pushq %r14
	pushq %rbx
	pushq %rax
	movq %rsi, %r14
	movq %rdi, %rbx
	testq %rdi, %rdi
	jle .L1
	leaq (%rbx, %rbx), %rdi
	movq %rsp, %rsi
	callq pointless
	addq (%rsp), %rax
	jmp .L3
.L1:	xorl %eax, %eax
.L3:	addq %rax, %rbx
	movq %rbx, (%r14)
	addq $8, %rsp
	popq %rbx
	popq %r14
	retq

