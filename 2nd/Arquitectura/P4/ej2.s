.text
.global campesino_ruso
campesino_ruso:
    push {ip,lr} 
    mov r4, #0
    mientras:
        tst r1, #1
        addne r4, r0, r4
        subne r1, r1, #1
        moveq r0, r0, LSL #1
        moveq r1, r1, LSR #1
        cmp r1, #0
        bhi mientras
    mov r0, r4
    pop {ip,lr}
    bx lr
    
