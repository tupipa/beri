#-
# Copyright (c) 2012 Michael Roe
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

from beritest_tools import BaseBERITestCase
from nose.plugins.attrib import attr

#
# Test that csealdata raises a C2E exception if ct is a reserved register
# and don't have permission to access it/
#

class test_cp2_x_csealdata_reg(BaseBERITestCase):
    @attr('capabilities')
    def test_cp2_x_csealdata_reg_1(self):
        '''Test csealdata did not seal with a reserved register'''
        self.assertRegisterEqual(self.MIPS.a0, 0,
            "csealdata sealed with a reserved register")

    @attr('capabilities')
    def test_cp2_x_csealdata_reg_2(self):
        '''Test csealdata raised a C2E exception when register was reserved'''
        self.assertRegisterEqual(self.MIPS.a2, 1,
            "csealdata did not raise an exception when ct was reserved")
    @attr('capabilities')

    def test_cp2_x_csealdata_reg_3(self):
        '''Test csealdata set capability cause correctly when register was reserved'''
        self.assertRegisterEqual(self.MIPS.a3, 0x181d,
            "csealdata did not set capability cause correctly when ct was reserved")
