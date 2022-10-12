

.text


.global buscar_caracter

buscar_caracter:
	movq %rdx, %rcx #rcx = rdx
	movb %sil, %al #rax = rdi
	repne scasb #Comparar mientras no coincidan
	jz iguales
	movq $-1, %rax #No se encontro
    ret

iguales:#Calcular posicion
	subq %rcx, %rdx
	decq %rdx
	movq %rdx, %rax
    ret


.global comparar_cadena
comparar_cadena:
	cmp %rdx, %rcx #Chequear que tengan la misma longitud
	jz compara #Si lo son comparar cadena
	movq $0, %rax # Si no retornar 0
	ret

compara:
	repe cmpsb #Comparar mientras coincidan
	jz iguales2 
    movq $0, %rax
    ret

iguales2:
	movq $1, %rax
	ret






.global fuerza_bruta

.data
	msg: .asciz ""
	
.text
fuerza_bruta:
	movq %rdi, %r8 #Almacenar valores
	movq %rsi, %r9
	movq %rdx, %r10
	movq %rcx, %r13
	
	buscar_sub_cadena:
	
	movb (%r9), %sil #Guardar el primer caracter
	call buscar_caracter #Buscar la primer ocurrencia del primer caracter de cadena 2 en cadena 1
	cmp $-1, %rax 
	je no_contenida #Si no se encontro retornar
	movq %rax, %r14 #Preservamos la pos del caracter
	
	addq %r14, %r8 # Mover hasta el caracter encontrado
	
	movq %r8, %rdi #Restaurar
	movq %r9, %rsi
	
	incq %rdi #Mover uno mas pues este ya lo vimos
	incq %rsi #Aca tambien
	
	decq %r13 #Acomodar longitudes
	movq %r13, %rcx
	movq %r13, %rdx
	
	
	
	call comparar_cadena #Comparar si la subcadena de la cadena 1 es igual a la cadena 2
	cmp $1, %rax
	jz fin3 #Caso afirmativo retornar
	subq %r13, %r10 #Actualizar longitud del primer argumento
	subq %r14, %r10
	movq %r10, %rdx
	movq %r9, %rsi
	jmp buscar_sub_cadena

no_contenida:
	movq $0, %rax

fin3:
	ret










	







