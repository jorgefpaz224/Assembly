.data
    menu_msg:       .asciiz "\n--- Menu Principal ---\n1. Cubos de Nicomaco\n2. Sucesion 4/2^n\n3. Salir\nElige una opcion: "
    result_msg:     .asciiz "\nEl resultado es: "
    newline:        .asciiz "\n"
    input_n_msg:    .asciiz "\nDame el valor de n: "
    space:          .asciiz " "
    float_format:   .asciiz "%.3f "
    cuatro:         .float 4.0
    dos:            .float 2.0

.text
.globl main

main:
    # Menu principal
    menu:
        li $v0, 4           # Imprimir menu
        la $a0, menu_msg    
        syscall

        # Leer que quiere hacer el usuario
        li $v0, 5           
        syscall
        move $t0, $v0       # Guardar lo que eligio

        # Ver que opcion escogio
        beq $t0, 1, nicomaco
        beq $t0, 2, sucesion
        beq $t0, 3, exit
        j menu              # Si puso otra cosa, mostrar menu otra vez

nicomaco:
    # Pedir hasta donde quiere calcular
    li $v0, 4
    la $a0, input_n_msg
    syscall
    
    li $v0, 5              
    syscall
    move $t1, $v0          # Guardar n
    
    li $t2, 1              # i empieza en 1
    
    nicomaco_loop:
        bgt $t2, $t1, menu  # Si ya acabamos, volver al menu
        
        # Sacar el cubo: i*i*i
        mul $t3, $t2, $t2   # primero i*i
        mul $t3, $t3, $t2   # luego por i otra vez
        
        # Mostrar resultado
        li $v0, 1
        move $a0, $t3
        syscall
        
        # Poner un espacio
        li $v0, 4
        la $a0, space
        syscall
        
        addi $t2, $t2, 1    # siguiente numero
        j nicomaco_loop

sucesion:
    # Preguntar cuantos numeros quiere
    li $v0, 4
    la $a0, input_n_msg
    syscall
    
    li $v0, 5              
    syscall
    move $t1, $v0          # Guardar cuantos quiere
    
    li $t2, 0              # Empezar a contar desde 0
    
    # Preparar los numeros para dividir
    l.s $f2, cuatro       # Empezamos con 4
    l.s $f3, dos          # Vamos a dividir entre 2
    
    sucesion_loop:
        bge $t2, $t1, menu  # Si ya acabamos, volver
        
        # Mostrar el numero
        li $v0, 2
        mov.s $f12, $f2
        syscall
        
        # Poner espacio
        li $v0, 4
        la $a0, space
        syscall
        
        # Siguiente numero es la mitad
        div.s $f2, $f2, $f3
        
        addi $t2, $t2, 1    # Contar uno mas
        j sucesion_loop

exit:
    li $v0, 10             # Salir del programa
    syscall 