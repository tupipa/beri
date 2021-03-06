#-
# Copyright (c) 2011 Robert N. M. Watson
# Copyright (c) 2013 Michael Roe
# Copyright (c) 2015 SRI International
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

.include "macros.s"
.set mips64
.set noreorder
.set nobopt

#
# Check that various operations interrupt load linked + store
# conditional capabiltiy.
#

		.global test
test:		.ent test
		daddu 	$sp, $sp, -32
		sd	$ra, 24($sp)
		sd	$fp, 16($sp)
		daddu	$fp, $sp, 32

		#
		# Set up nop exception handler.
		#
		jal	bev_clear
		nop
		dla	$a0, bev0_handler
		jal	bev0_handler_install
		nop

		dla	$t1, cap1
		csetoffset $c1, $c0, $t1

		#
		# Load the capability into another register between cllc and
		# cscc; this shouldn't cause the store to fail.
		#

		cllc	$c2, $c1
		clci	$c2, 0($c1)
		cscc	$a4, $c2, $c1

		#
		# Store to capability between cllc and cscc; check to make
		# sure that the cscc not only returns failure, but doesn't
		# store.
		#

		li	$t0, 1
		cllc	$c2, $c1
		csci	$c0, 0($c1)
		cscc	$a3, $c2, $c1
		clci	$c3, 0($c1)
		cgettag	$a2, $c3

		ld	$fp, 16($sp)
		ld	$ra, 24($sp)
		daddu	$sp, $sp, 32
		jr	$ra
		nop			# branch-delay slot
		.end	test


#
# No-op exception handler to return back after the tnei and confirm that the
# following sc fails.  This code assumes that the trap isn't from a branch-
# delay slot.

#
		.ent bev0_handler
bev0_handler:
		dmfc0	$k0, $14	# EPC
		daddiu	$k0, $k0, 4	# EPC += 4 to bump PC forward on ERET
		dmtc0	$k0, $14
		nop			# NOPs to avoid hazard with ERET
		nop			# XXXRW: How many are actually
		nop			# required here?
		nop
		eret
		.end bev0_handler

		.data
		.align	5		# 256-bit alignment
cap1:		.dword	0x0123456789abcdef
		.dword	0x0123456789abcdef
		.dword	0x0123456789abcdef
		.dword	0x0123456789abcdef
