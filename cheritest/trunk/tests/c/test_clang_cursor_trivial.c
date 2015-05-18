/*-
 * Copyright (c) 2014 David T. Chisnall
 * All rights reserved.
 *
 * This software was developed by SRI International and the University of
 * Cambridge Computer Laboratory under DARPA/AFRL contract FA8750-10-C-0237
 * ("CTSRD"), as part of the DARPA CRASH research programme.
 *
 * @BERI_LICENSE_HEADER_START@
 *
 * Licensed to BERI Open Systems C.I.C. (BERI) under one or more contributor
 * license agreements.  See the NOTICE file distributed with this work for
 * additional information regarding copyright ownership.  BERI licenses this
 * file to you under the BERI Hardware-Software License, Version 1.0 (the
 * "License"); you may not use this file except in compliance with the
 * License.  You may obtain a copy of the License at:
 *
 *   http://www.beri-open-systems.org/legal/license-1-0.txt
 *
 * Unless required by applicable law or agreed to in writing, Work distributed
 * under the License is distributed on an "AS IS" BASIS, WITHOUT WARRANTIES OR
 * CONDITIONS OF ANY KIND, either express or implied.  See the License for the
 * specific language governing permissions and limitations under the License.
 *
 * @BERI_LICENSE_HEADER_END@
 */
#include "assert.h"
int buffer[42];

extern volatile long long exception_count;

int test(void)
{
	__capability int *b = (__capability int*)buffer;
	long long count = exception_count;
	b[41] = 12;
	// Explicitly set the length of the capability, in case the compiler fails
	__capability volatile int *v = __builtin_cheri_set_cap_length(b, sizeof(buffer));
	// Set the cursor past the end and check that dereferencing fires an exception
	v = __builtin_cheri_cap_offset_increment((__capability void*)v, 42*sizeof(int));
	int unused = *v;
	assert(exception_count == count+1);
	// Move the cursor back into range and check that it works
	v = __builtin_cheri_cap_offset_increment((__capability void*)v, (-1)*sizeof(int));
	assert(*v == 12);
	// Set the cursor before the start and check that dereferencing fires an exception
	v = __builtin_cheri_cap_offset_set((__capability void*)v, -1);
	unused = *v;
	assert(exception_count == count+2);
	// Move the cursor back into range and check that it works
	v = __builtin_cheri_cap_offset_set((__capability void*)v, 41*sizeof(int));
	assert(*v == 12);
	return 0;
}