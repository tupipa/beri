#-
# Copyright (c) 2013 Michael Roe
# All rights reserved.
#
# This software was developed by SRI International and the University of
# Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-10-C-0237
# ("CTSRD"), as part of the DARPA CRASH research programme.
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

.set mips64
.set noreorder
.set nobopt
.set noat

#
# Test double-precision to single-precision conversion the FPU is in 32-bit mode
#
		.text
		.global start
		.ent start
start:     
		mfc0 $t0, $12
		li $t1, 1 << 29		# Enable CP1
		or $t0, $t0, $t1    
		li $t1, 1 << 26		# Put FPU into 32 bit mode
		nor $t1, $t1, $t1
		and $t0, $t0, $t1
		mtc0 $t0, $12 
		nop
		nop
		nop

		cfc1 $a0, $f31		# Get floating point rounding mode
		li $t0, 0x3
		and $a0, $a0, $t0

		lui $t0, 0x3FC5 # ~ 1/6 in double precision
		ori $t0, 0x5555
		mtc1 $t0, $f13
		lui $t0, 0x5555
		ori $t0, 0x5555
		mtc1 $t0, $f12
		cvt.s.d $f12, $f12
		mfc1 $a1, $f12


		# Dump registers on the simulator (gxemul dumps regs on exit)
		mtc0 $at, $26
		nop
		nop

		# Terminate the simulator
		mtc0 $at, $23
end:
		b end
		nop

.end start
