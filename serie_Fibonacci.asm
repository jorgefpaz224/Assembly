.data
	Sms_1: .asciiz "Ingrese la cantidad de terminos de la serie de Fibonacci: "
	Sms_2: .asciiz "Serie de Fibonacci\n"
	espacio: .asciiz " "
	salto: .asciiz "\n"
	
.text
main:
	#Imprimir mensaje para pedir cantidad de numeros de la seria
	li $v0, 4
	la $a0, Sms_1
	syscall
	
	#Ingresar cantidad de numeros de la serie
	li $v0, 5
	syscall
	move $t3, $v0
	
	#Imprimir Serie de Fibonacci
	li $v0, 4
	la $a0, Sms_2
	syscall
	
	#Inicializar primeros valores de la serie
	li $t0, 0	#primer numero de F(0)
	li $t1, 1	#segundo numero de F(1)
	
	#Imprimir el primer numero 
	li $v0, 1
	move $a0, $t0
	syscall
	
	#Imprimir espacio
	li $v0, 4
	la $a0, espacio
	syscall
	
	#Si es usuario solo pidio un termino (0)
	beq $t3, 1, fin
	
	#Imprimir el segundo numero (1)
	li $v0, 1
	move $a0, $t1
	syscall
	
	#Imprimir espacio
	li $v0, 4
	la $a0, espacio
	syscall
	
	#Inicializar contador de terminos
	li $t2, 2	#EL contador empieza en el tercer termino (2)
	
	
#Inicio del ciclo for para calcular la serie de Fibonacci
for:
	bge $t2, $t3, fin	#condiciones para el for
	
	#calculamos el siguiente numero de la serie Fn = F(n-1) + F(n-2)
	add $t4, $t0, $t1	#$t4 = $t0 + $t1
	
	#Imprimimos el numero calculado
	li $v0, 1
	move $a0, $t4
	syscall
	
	#Imprimir espacio
	li $v0, 4
	la $a0, espacio
	syscall
	
	#Actualizar valores de la serie
	move $t0, $t1	# 0 1 1 ?
	move $t1, $t4	# 0 1 1 ?
	
	#Incrementar contador para el ciclo for 
	add $t2, $t2, 1
	j for

#bloque de finalizacion del codigo	
fin:
	#Imprimir salto
	li $v0, 4
	la $a0, salto
	syscall
	
	li $v0, 10
	syscall