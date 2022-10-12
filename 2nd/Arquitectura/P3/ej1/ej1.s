




.data
    msg1: .asciz "1) valor de rsp %ld\n"
    msg2: .asciz "2)direccion de la cadena de formato %d\n"
    msg3: .asciz "3)direccion de la cadena de formato en hexadecimal %p\n"
    msg4: .asciz "4)quad en el tope de la pila %d\n"
    msg5: .asciz "5)quad ubicado en la direccion rsp+8 %ld\n" 
    msg6: .asciz "6)valor de i: %p\n"
    msg7: .asciz "7)la direccion de i: %p\n"
    i: .quad 0xdeadbeef
.text
.global main
main:
	#1
    movq $msg1, %rdi # el primer argumento es el formato
    movq %rsp, %rsi # el valor a imprimir
    xorq %rax, %rax # cantidad de valores de punto flotante
    call printf
    
    #2
    movq $msg2, %rdi #el primer argumento es el formato
    movq $msg2, %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
   
    #3
    movq $msg3, %rdi #el primer argumento es el formato
    movq $msg2, %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
    
    #4
    pushq $25 #Guardamos un valor en el tope de la pila
    movq $msg4, %rdi #el primer argumento es el formato
    popq %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
    
    #5
    movq $111, 8(%rsp)#Guardamos un valor en rsp+8
    movq $msg5, %rdi #el primer argumento es el formato
    movq 8(%rsp), %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
    
    #6
    movq $msg6, %rdi #el primer argumento es el formato
    movq i, %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
    
    #7
    movq $msg7, %rdi #el primer argumento es el formato
    movq $i, %rsi #el segundo es el valor a imprimir
    xorq %rax, %rax #cantidad de valores en punto flotante
    call printf
    
    ret
    
    
    

	
    
    
    
    
