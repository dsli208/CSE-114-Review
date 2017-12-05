.data

newline:  .asciiz "\n"
##################################################################
# Arguments for test cases. You should change these to create your own tests.
indexOf_msg: .asciiz "##### Testing indexOf #####"
indexOf_str: .asciiz "Testingt"
indexOf_ch: .asciiz "g"
indexOf_startIndex: .word 3

replaceAllChar_msg: .asciiz "\n##### Testing replaceAllChar #####"
replaceAllChar_str: .asciiz "Stony Brook"
replaceAllChar_pattern: .asciiz "oBhy"
replaceAllChar_replacement: .ascii "q"

countOccurrences_msg: .asciiz "\n##### Testing countOccurrences #####"
countOccurrences_str: .asciiz "Let's Go Seawolves!"
countOccurrences_searchChars: .asciiz "qsgo!"

replaceAllSubstr_msg: .asciiz "\n##### Testing replaceAllSubstr #####"
replaceAllSubstr_dst: .ascii "whatsupwithyou"
replaceAllSubstr_dstLen: .word 15
replaceAllSubstr_str: .asciiz "dingbat"
replaceAllSubstr_findStr: .asciiz "GrPQ"
replaceAllSubstr_replaceStr: .asciiz "Ugh"

split_msg: .asciiz "\n##### Testing split #####"
.align 2
split_dst: .space 40
split_dstLen: .word 3
split_str: .asciiz "hokus pokus smokus!"
split_delimiter: .ascii "k"


##################################################################
# Constants
.eqv QUIT 10
.eqv PRINT_STRING 4
.eqv PRINT_INT 1

.text
.globl main

####################################################################
# This is the "main" of your program; Everything starts here.
####################################################################

main:

    ##########################
    # indexOf
    ##########################
    la $a0, indexOf_msg
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    la $a0, indexOf_str
    la $a1, indexOf_ch
    lbu $a1, 0($a1)
    lw $a2, indexOf_startIndex
    jal indexOf
    # print return value
    move $a0, $v0
    li $v0, PRINT_INT
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    ##########################
    # replaceAllChar
    ##########################
    la $a0, replaceAllChar_msg
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    la $a0, replaceAllChar_str
    la $a1, replaceAllChar_pattern
    la $a2, replaceAllChar_replacement
    lbu $a2, 0($a2)
    jal replaceAllChar
    # print return values
    move $a0, $v0
    move $t1, $v1
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall
    move $a0, $t1
    li $v0, PRINT_INT
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    ##########################
    # countOccurrences
    ##########################
    la $a0, countOccurrences_msg
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    la $a0, countOccurrences_str
    la $a1, countOccurrences_searchChars
    jal countOccurrences
    # print return value
    move $a0, $v0
    li $v0, PRINT_INT
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    ##########################
    # replaceAllSubstr
    ##########################
    la $a0, replaceAllSubstr_msg
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    la $a0, replaceAllSubstr_dst
    lw $a1, replaceAllSubstr_dstLen
    la $a2, replaceAllSubstr_str
    la $a3, replaceAllSubstr_findStr
    addi $sp, $sp, -4
    la $t0, replaceAllSubstr_replaceStr
    sw $t0, 0($sp)
    jal replaceAllSubstr
    addi $sp, $sp, 4
    # print return values
    move $a0, $v0
    move $t1, $v1
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall
    move $a0, $t1
    li $v0, PRINT_INT
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    ##########################
    # split
    ##########################
    la $a0, split_msg
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    la $a0, split_dst
    lw $a1, split_dstLen
    la $a2, split_str
    la $a3, split_delimiter
    lbu $a3, 0($a3)
    jal split
    # print return values
    move $a0, $v0
    move $t0, $v0
    move $t1, $v1
    li $v0, PRINT_INT
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall

    # Once you have implemented the split() function, uncomment the code below
    # to print the tokens that your function found.

    li $t2, 0 # $t2 = i
    la $t3, split_dst # $t3 = pointer to split_dst[i]
loop:
    beq $t2, $t0, done_printing
    lw $a0, 0($t3)
    li $v0, PRINT_STRING
    syscall
    la $a0, newline
    li $v0, PRINT_STRING
    syscall
    addi $t2, $t2, 1
    addi $t3, $t3, 4
    j loop
done_printing:
####################################################################

    # Exit the program
    li	$v0, 10
    syscall

####################################################################
# End of MAIN program
####################################################################


####################################################################
# Student defined functions will be included starting here
####################################################################

.include "hw3.asm"
