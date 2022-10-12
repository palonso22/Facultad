




.data
    msg: .asciz "El estado de la bandera es %d"
    cont: .long 0

.text


.global main


main:
    movq $msg, %rdi
    movq $0, %rsi
    movq $11, %rax
    ROR %rax
    adc %rax, cont
    movq cont, %rsi
    xorq %rax, %rax
    call printf
    
    
