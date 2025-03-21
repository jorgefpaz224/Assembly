.data
	msg1: .asciiz "Ingrese cantidad de numeros primos: "
	msg2: .asciiz "\nPrimo: "
	msg3: .asciiz " / 10 = "
	newline: .asciiz "\n"

.text
main:
	# Pedir cantidad de números
	li $v0, 4
	la $a0, msg1
	syscall
	
	li $v0, 5
	syscall
	move $s0, $v0 
	
	li $s1, 2      # Número actual
	li $s2, 0      # Contador de primos
	
loop_principal:
	beq $s2, $s0, fin
	
	move $a0, $s1
	j verificar_primo
	
retorno_primo:
	beqz $v0, siguiente_numero
	
	# Imprimir mensaje
	li $v0, 4
	la $a0, msg2
	syscall
	
	# Imprimir primo
	li $v0, 1
	move $a0, $s1
	syscall
	
	# Imprimir " / 10 = "
	li $v0, 4
	la $a0, msg3
	syscall
	
	# División
	move $t0, $s1
	li $t1, 0
	
division:
	sub $t0, $t0, 10
	bltz $t0, fin_division
	addi $t1, $t1, 1
	j division
	
fin_division:
	# Imprimir resultado
	li $v0, 1
	move $a0, $t1
	syscall
	
	# Punto decimal
	li $v0, 11
	li $a0, 46
	syscall
	
	# Parte decimal
	add $t0, $t0, 10
	mul $t0, $t0, 10
	
	li $v0, 1
	move $a0, $t0
	syscall
	
	# Salto línea
	li $v0, 4
	la $a0, newline
	syscall
	
	addi $s2, $s2, 1
	
siguiente_numero:
	addi $s1, $s1, 1
	j loop_principal

verificar_primo:
	li $t0, 2
	
verificar_divisor:
	bge $t0, $a0, es_primo_si
	
	move $t1, $a0
	
restar:
	sub $t1, $t1, $t0
	beqz $t1, es_primo_no
	bltz $t1, siguiente_divisor
	j restar
	
siguiente_divisor:
	addi $t0, $t0, 1
	j verificar_divisor
	
es_primo_si:
	li $v0, 1
	j retorno_primo
	
es_primo_no:
	li $v0, 0
	j retorno_primo

fin:
	li $v0, 10
	syscall



