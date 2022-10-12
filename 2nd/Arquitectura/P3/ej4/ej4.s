
.data
	fmt: .string "%d"
	entero: .long -100
	funcs: .quad f1 
		   .quad f2
		   .quad f3
.text
	f1: movl $0,%esi; movq $fmt, %rdi; call printf; jmp fin
	f2: movl $1,%esi; movq $fmt, %rdi; call printf; jmp fin
	f3: movl $2,%esi; movq $fmt, %rdi; call printf; jmp fin
.global main
	main:
		pushq %rbp;
		movq %rsp,%rbp
		## Leemos el entero
		leaq entero, %rsi
		movq $fmt, %rdi
		xorq %rax,%rax
		call scanf
		xorq %rax,%rax
		
		movl entero, %ecx #Mover entero a ecx
		movl funcs(,%ecx,8), %edx #Mover desde funcs entero*8 bytes

		jmp *%rdx

	fin:
		movq %rbp,%rsp; popq %rbp; ret
