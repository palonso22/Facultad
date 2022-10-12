

.data
	cero: .float 0
.global sum
sum:
	movq %rdx,%rcx
	movq $0, %rdx
	movss cero, %xmm0
	sumar:
		movss (%rsi,%rdx,4), %xmm0
		movss (%rdi,%rdx,4), %xmm1
		addss %xmm0, %xmm1
		movss %xmm1, (%rdi,%rdx,4)
		incq %rdx
	loop sumar
	ret 
