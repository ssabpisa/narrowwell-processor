#--------------------------------------
# Test branch and jumps
#--------------------------------------
  org 0x0000
  ori   $1, $zero, 0xBA5C
  ori   $2, $0, 0xF0
  sw    $1, 0($2)
  halt
