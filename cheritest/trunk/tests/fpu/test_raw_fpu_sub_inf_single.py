#-
# Copyright (c) 2014 Michael Roe
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

#
# Test IEEE 747 infinity values in single-precision arithmetic
#

from beritest_tools import BaseBERITestCase
from nose.plugins.attrib import attr

class test_raw_fpu_sub_inf_single(BaseBERITestCase):

    def test_raw_fpu_infinity_single_sub_1(self):
        '''Test sub.s 1.0 from +infinity'''
	self.assertRegisterEqual(self.MIPS.a0, 0x7f800000, "sub.s from +infinity did not give +infinity")

    def test_raw_fpu_infinity_single_sub_2(self):
        '''Test sub.s +Infinity from +infinity'''
	self.assertRegisterIsSingleNaN(self.MIPS.a1, "sub.s of +Infinity from +infinity did not give NaN")

    @attr('floatnan2008')
    def test_raw_fpu_infinity_single_sub_3(self):
        '''Test sub.s +Infinity from +infinity'''
	self.assertRegisterIsSingleQNaN(self.MIPS.a1, "sub.s of +Infinity from +infinity did not give QNaN")

