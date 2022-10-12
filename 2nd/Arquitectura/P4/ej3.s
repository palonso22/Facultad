.text
.global potencia
potencia:
    push {ip,lr}
    mov r1, #1
    mov r1, r1, LSL r0
    mov r0, r1
    pop {ip,lr}
    bx lr
