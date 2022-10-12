
.global ver_si_es_sol_ecu_dos
ver_si_es_sol_ecu_dos:
	mulss %xmm3, %xmm0 # xmm0 = d*x
	mulss %xmm4, %xmm1 # xmm1 = e*y
	addss %xmm1, %xmm0 # xmm0 = d*x + e*y
	subss %xmm5, %xmm0 # xmm0 = d*x + e*y - f
	ret

.data
	uno: .float 1
	menos_uno: .float -1
	cero: .float 0
.global solve
solve:
	
	#Calcular determinante de la matriz de coeficientes
	movss %xmm0, %xmm8  # xmm8 = a
	mulss %xmm4, %xmm8  # xmm8 = a*e
	
	movss %xmm1, %xmm9 # xmm9 = b 
	mulss %xmm3, %xmm9 # xmm9 = b*d
	subss %xmm9, %xmm8 # xmm8 = a*e - b*d
	
	
	ucomiss cero ,%xmm8
	jnz compatible_determinado # a*e - b*d != 0
	
	#En este punto el sistema es incompatible indeterminado o compatible indeterminado
	#Veremos cual teniendo en cuenta las sgtes prop:
	#- si  el sistema es compatible indeterminado (tiene inf sol) por lo tanto basta  encontrar un pto en alguna ecu
	# y ver si es solucion de la otra
	#- sino es incompatible indeterminado (no tiene sol)
	
	a_es_cero:
		ucomiss cero,%xmm0
		jz b_es_cero
		#si a != 0 tomamos y = 1 y calculamos x = (c-b)/a
		subss %xmm1, %xmm2 # xmm2 = c-b
		divss %xmm0, %xmm2 # xmm2 = (c-b)/a
		movss %xmm2, %xmm0 
		movss uno, %xmm1
		movss %xmm0, %xmm8
		movss %xmm1, %xmm9
		call ver_si_es_sol_ecu_dos
		ucomiss cero,%xmm0
		jz retornar_sol
		jmp incompatible_indeterminado
	
	
	b_es_cero:
		ucomiss cero,%xmm1
		jz c_es_cero
		#si b!= 0 tomamos x = 1 y calculamos y = c/b
		divss %xmm1, %xmm2 # xmm2 = c/b
		movss uno, %xmm0 # x = 1
		movss %xmm2, %xmm1 # y = xmm1
		movss %xmm0, %xmm8
		movss %xmm1, %xmm9
		call ver_si_es_sol_ecu_dos
		ucomiss cero,%xmm0
		jz retornar_sol
		jmp incompatible_indeterminado
	
	
	c_es_cero:
		ucomiss cero,%xmm2
		jz d_es_cero
		jmp incompatible_indeterminado
	
	
	d_es_cero:
		ucomiss cero,%xmm3
		jz e_es_cero
		#si d != 0 tomamos y = 1 y calculamos x = (f-e)/d
		subss %xmm4, %xmm5 # xmm5 = f-e
		divss %xmm3, %xmm5 # xmm5 = (f-e)/d
		movss %xmm5, %xmm8 # x = (f-e)/d
		movss uno,%xmm9 # y = 1
		jmp retornar_sol
	
	
	e_es_cero:
		ucomiss cero,%xmm4
		jz f_es_cero
		#si e != 0 tomamos x = 1 y calculamos y = f/e
		divss %xmm4,%xmm5 # xmm5 = f/e
		movss uno, %xmm8 # x = 1
		movss %xmm5, %xmm9 # y = f/e
		jmp retornar_sol 
		
	
	f_es_cero:
		ucomiss cero,%xmm5
		jnz incompatible_indeterminado
		movss cero, %xmm8
		movss cero, %xmm9
		jmp retornar_sol
		
	
	retornar_sol:
		movss %xmm8, (%rdi)
		movss %xmm9, (%rsi)
		jmp fin2
	
	
	incompatible_indeterminado:
		movss cero, %xmm0 # xmm0 = 0
		movss cero, %xmm1 # xmm1 = 0
		divss %xmm0, %xmm1 # xmm1 = 0/0
		movss %xmm1, (%rdi) # x = NaN
		movss %xmm1, (%rsi)	# y = NaN	
		jmp fin2
	
	
	#El sistema tiene unica sol
	compatible_determinado:
		#Calcular x con la siguiente formula
		# x = (b*f-e*c)/(d*b-a*e)
		
		mulss menos_uno, %xmm8 # xmm8 = -1 * (a*e - b*d) = (d*b-a*e) 
		movss %xmm1, %xmm9 # xmm9 = b
		mulss %xmm5, %xmm9 # xmm9 = b*f
		movss %xmm2, %xmm10 # xmm10 = c
		mulss %xmm4, %xmm10 # xmm10 = c*e
		subss %xmm10, %xmm9 # xmm9 = b*f - e*c
		divss %xmm8, %xmm9 # xmm9 = (b*f-e*c)/(d*b-a*e)
		movss %xmm9, (%rdi)  # x* = xmm9
		
		#Calcular y
		#Si b != 0, y = (c-a*x)/b
		#Sino  y = (f-d*x) / e (b y e no pueden ser simultaneamente nulos)
		
		ucomiss cero, %xmm1 
		jz else
		
		mulss %xmm0, %xmm9 # xmm9 = a*x
		subss %xmm9, %xmm2 # xmm2 = c - a*x
		divss %xmm1, %xmm2 # xmm2 = (c - a*x)/b
		movss %xmm2, (%rsi) # y* = (c-a*x)/b
		jmp fin
		
		else:
			mulss %xmm3, %xmm9 # xmm9 = d*x
			subss %xmm9, %xmm5 # xmm5 = f - d*x
			divss %xmm4, %xmm5 # xmm4 = (f - d*x)/e
			movss %xmm5, (%rsi)
			
		fin:
			movq $0, %rax
			ret
		
		fin2:
			movq $-1, %rax
			ret
