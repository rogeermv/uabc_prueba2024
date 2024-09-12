/*
 * Copyright (c) 2024 Your Name
 * SPDX-License-Identifier: Apache-2.0
 */

`default_nettype none

module tt_um_uabc_prueba2024 (
    input  wire [7:0] ui_in,    // Dedicated inputs
    output wire [7:0] uo_out,   // Dedicated outputs
    input  wire [7:0] uio_in,   // IOs: Input path
    output wire [7:0] uio_out,  // IOs: Output path
    output wire [7:0] uio_oe,   // IOs: Enable path (active high: 0=input, 1=output)
    input  wire       ena,      // always 1 when the design is powered, so you can ignore it
    input  wire       clk,      // clock
    input  wire       rst_n     // reset_n - low to reset
);
    
  reg [24:0] counter;          // 25-bit counter to create 1-second delay
  reg [3:0]  display_value;    // Value to display
  
  // Counter for 1-second delay
  always @(posedge clk or negedge rst_n) begin
    if (!rst_n) begin
      counter <= 25'd0;
      display_value <= 4'd0;
    end else if (counter == 25_000_000) begin
      counter <= 25'd0;               // Reset counter every second
      display_value <= display_value + 1; // Increment display value
    end else begin
      counter <= counter + 1; // Increment counter
    end
  end

  // Assign letters and numbers in binary to uo_out
  always @(*) begin
    case (display_value)
      4'd0: uo_out = 8'b01000001; // A (binary)
      4'd1: uo_out = 8'b01000010; // B (binary)
      4'd2: uo_out = 8'b01000011; // C (binary)
      4'd3: uo_out = 8'b01000100; // D (binary)
      4'd4: uo_out = 8'b01000101; // E (binary)
      4'd5: uo_out = 8'b01000110; // F (binary)
      4'd6: uo_out = 8'b00110000; // 0 (binary)
      4'd7: uo_out = 8'b00110001; // 1 (binary)
      4'd8: uo_out = 8'b00110010; // 2 (binary)
      4'd9: uo_out = 8'b00110011; // 3 (binary)
      4'd10: uo_out = 8'b00110100; // 4 (binary)
      4'd11: uo_out = 8'b00110101; // 5 (binary)
      4'd12: uo_out = 8'b00110110; // 6 (binary)
      4'd13: uo_out = 8'b00110111; // 7 (binary)
      4'd14: uo_out = 8'b00111000; // 8 (binary)
      4'd15: uo_out = 8'b00111001; // 9 (binary)
      default: uo_out = 8'b00000000; // Blank (off)
    endcase
  end

    
  // Assignments for unused outputs
  assign uio_out = 0; // Ensure that unused IO outputs are zero
  assign uio_oe = 8'hFF; // Enable all IOs for output


  // List all unused inputs to prevent warnings
  wire _unused = &{ena, clk, rst_n, 1'b0};

endmodule
