




.global setjmp2

setjmp2:
	movq (%rsp), %rax #Copiar direccion de retorno
	movq %rax, (%rdi) 
	movq %rbx, 8(%rdi) #Copiar valores de registros calle saved
	movq %r10, 16(%rdi)
	movq %r13, 24(%rdi)
	movq %r14, 32(%rdi)
	movq %r15, 40(%rdi)
	movq %rsp, 48(%rdi) #Copiar valor de rsp
	movq %rbp, 56(%rdi)
	xorq %rax, %rax
	ret
	





.global longjmp2
longjmp2:
	popq %rax # Quitar direccion de retorno
	push (%rdi) #Direccion de retorno para setjmp2
	movq 8(%rdi), %rbx
	movq 16(%rdi), %r10
	movq 24(%rdi), %r13
	movq 32(%rdi), %r14
	movq 40(%rdi), %r15
	movq 48(%rdi), %rsp
	movq %rsi, %rax
	cmpq $0,%rax
	jnz fin
	incq %rax
	fin:
		ret
	



