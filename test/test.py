# SPDX-FileCopyrightText: © 2024 Tiny Tapeout
# SPDX-License-Identifier: Apache-2.0

import cocotb
from cocotb.clock import Clock
from cocotb.triggers import ClockCycles

@cocotb.test()
async def test_project(dut):
    dut._log.info("Start")

    # Set the clock period to 10 us (100 KHz)
    clock = Clock(dut.clk, 10, units="us")
    cocotb.start_soon(clock.start())

    # Reset
    dut._log.info("Reset")
    dut.ena.value = 1
    dut.ui_in.value = 0
    dut.uio_in.value = 0
    dut.rst_n.value = 0
    await ClockCycles(dut.clk, 10)
    dut.rst_n.value = 1

    dut._log.info("Test project behavior")

    # Expected segment values corresponding to display_value from 0 to 15
    expected_outputs = [
        0b0111111, # A
        0b0000110, # b
        0b1011011, # C
        0b1001111, # d
        0b1100110, # E
        0b1101101, # F
        0b1111101, # G
        0b0000111, # H
        0b1111111, # I
        0b1101111, # J
        0b1011110, # K
        0b0111001, # L
        0b1110110, # M
        0b1011110, # N
        0b1111011, # O
        0b1111110, # P
    ]

    # Test the display sequence
    for i in range(16):
        await ClockCycles(dut.clk, 25_000_001)  # Wait for the counter to complete 1 second
        dut._log.info(f"Checking output for display_value {i}")
        assert dut.uo_out.value == expected_outputs[i], f"Test failed at display_value {i}. Expected {expected_outputs[i]:07b}, got {dut.uo_out.value:07b}"

    dut._log.info("Test passed")
