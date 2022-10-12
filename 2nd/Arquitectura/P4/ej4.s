.text
.global det
det:
    push {ip,lr}
    push {r0,r1,r2,r3}
    vpop {s0,s1,s2,s3 }
    vmul.f32 s0, s0, s3
    vmul.f32 s1, s1, s2
    vsub.f32 s0, s0, s1
    vpush {s0}
    pop {r0}
    pop {ip,lr}
    bx lr
