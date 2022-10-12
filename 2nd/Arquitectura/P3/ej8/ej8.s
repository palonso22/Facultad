



.global sumsse
sumsse:
	movq %rdx, %rcx #Mover el tamaño de los arreglos en el contador
	movq $0, %rdx #rdx será nuestro indice en el arreglo
	
	sumar_de_a_4:
		movaps (%rdi,%rdx,4), %xmm0 #Mover de a 4 flotantes al xmm0
		movaps (%rsi,%rdx,4), %xmm1 # Lo mismo para el otro arreglo
		addps %xmm0, %xmm1 # Sumar los 4 flotantes al mismo tiempo
		movaps %xmm1, (%rdi,%rdx,4) # Mover resultados al arreglo
 		addq $4, %rdx #Aumentar el indice para operar con los proximos 4 floats
		subq $4, %rcx #Restar 4 al iterador
		
		cmp $4, %rcx #Comparar 
		jge sumar_de_a_4 # Si quedan al menos 4 floats en el arreglo repetir
		cmp $0, %rcx
		jz fin #Si no quedan floats para operar finalizar 
	
	#Si quedan menos de 4 floats por arreglo sin operar  realizar la suma tomando de a uno
	sumar_de_a_uno:
		movq (%rdi,%rdx,4), %xmm0 #Mover el proximo float al xmm0
		movq (%rsi,%rdx,4), %xmm1 #Aca a xmm1
		addss %xmm0, %xmm1 # Sumar 
		movss %xmm1, (%rdi,%rdx,4) #Mover la suma al primer registro
		incq %rdx 
		decq %rcx
		cmp $0, %rcx 
		jnz sumar_de_a_uno #Si quedan floats para operar  repetir
	
	
	fin:
		ret
	

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
