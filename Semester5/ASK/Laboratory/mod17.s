    .text
    .globl  mod17
    .type mod17, @function	

mod17:
        movq %rdi, %rax
        movabsq $0x0F0F0F0F0F0F0F0F, %rcx
        movabsq $0xF0F0F0F0F0F0F0F0, %rdx
        movabsq $0x1111111111111111, %r9
        andq %rcx, %rax
        andq %rdx, %rdi
        shrq $4, %rdi
        addq %r9, %rax
        subq %rdi, %rax

        movq %rax, %rdi
        shrq $32, %rdi
        addl %edi, %eax

        movl %eax, %edi
        shrl $16, %edi
        addw %di, %ax

        movw %ax, %di
        andw %cx, %ax
        andw %dx, %di
        shrw $4, %di
        addw %r9w,%ax
        subw %di, %ax
        movw %ax, %di
        
        shrw $8, %di
        addb %dil, %al

        movb %al, %dil
        andb %cl, %al
        andb %dl, %dil
        shrb $4, %dil
        addb %r9b, %al
        subb %dil, %al

        movb %al, %dil
        shrb $4, %dil
        subb %dil, %al
      
        xorq %rsi, %rsi
        movb %al, %sil
        shrb $4, %sil
        xorb %sil, %dil

        andb %cl, %al
        addb %dil, %al
    

    ret






	


