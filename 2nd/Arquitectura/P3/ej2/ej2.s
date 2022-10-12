 




  

.global count_ones
count_ones:
   movq $0, %rsi
   movq %rdi, %rax
   movq $64, %rcx 
    l1:	
        rol %rax
        adc $0, %rsi
        loop l1
   movq %rsi, %rax
   ret



