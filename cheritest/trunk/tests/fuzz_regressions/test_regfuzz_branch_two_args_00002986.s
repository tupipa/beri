#-
# Copyright (c) 2012 Robert M. Norton
# All rights reserved.
#
# @BERI_LICENSE_HEADER_START@
#
# Licensed to BERI Open Systems C.I.C. (BERI) under one or more contributor
# license agreements.  See the NOTICE file distributed with this work for
# additional information regarding copyright ownership.  BERI licenses this
# file to you under the BERI Hardware-Software License, Version 1.0 (the
# "License"); you may not use this file except in compliance with the
# License.  You may obtain a copy of the License at:
#
#   http://www.beri-open-systems.org/legal/license-1-0.txt
#
# Unless required by applicable law or agreed to in writing, Work distributed
# under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
# CONDITIONS OF ANY KIND, either express or implied.  See the License for the
# specific language governing permissions and limitations under the License.
#
# @BERI_LICENSE_HEADER_END@
#

# Test for conditional branches taking two arguments. Tests different
# offsets covering the whole 16-bit range as well as various argument
# values and branch types. The test is centered around the instruction
# labelled 'branch', which targets the one labelled 'target' (except
# for some small offsets). Padding is added before or after the branch
# to acheive the correct spacing. s0-s5 are used to keep track of the
# path taken.

# arg_val1: 0x000000007fffffff
# arg_val2: 0x92fab75ffc8e4345
# offset: 16==0x10
# op: BEQL

.set mips64
.set noreorder
.set nobopt
.set noat

.global test
test:   .ent    test
	daddu   $sp, -16
	sd	$ra, 0($sp)
	sd      $fp, 8($sp)
	daddu   $fp, $sp, 16
	dla     $a0, 0x000000007fffffff
	dla     $a2, 0x92fab75ffc8e4345
	li      $s0, 0
	li      $s1, 0
	li      $s2, 0
	li      $s3, 0
	li      $s4, 0
	li      $s5, 0

.if 16 < 0
    	j       branch			# Skip over the padding to save time
	add     $s0, 1			# Branch delay
	add     $s1, 1			# Not executed
target:	add     $s2, 1			# should land here (offset<0)
	j	out   			# Skip to end of test
	add     $s3, 1			# Branch delay
.rept   -4-(16)/4			# Might be < 0 for some offsets i.e. no padding
	j	.			# Padding (minefield, not executed)
.endr
.endif # 16 < 0
branch:	BEQL     $a0,$a2, .+16+4	# Add 4 because AS offset is relative to . but MIPS is relative to .+4
	add     $s4, 1  		# Delay slot, executed twice if offset==0!
	add     $s5, 1  		# Might not be executed if branch taken
.if 16 > 0
	j       target			# Skip over the padding to save time
	add	$s0, 1			# Branch delay
.rept  (16)/4 - 5			# Might be < 0 for some offsets i.e. no padding
	j	.      	 	    	# Padding (minefield, not executed)
.endr
	add     $s1, 1			# Not executed except when offset is 3 or 4
target:	add     $s2, 1			# should land here (offset>0)
.endif # 16 > 0
out:	move    $a1, $ra		# Hide away the value of ra from the branch
	ld      $ra, 0($sp)
	ld      $fp, 8($sp)
	jr      $ra
	daddu   $sp, 16
.end    test
