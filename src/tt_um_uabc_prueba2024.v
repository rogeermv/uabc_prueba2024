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

    reg [24:0] counter;           // 25-bit counter to create 1 second delay
    reg [3:0]  display_value;     // Value to display

    // Contador de segundos
    always @(posedge clk or negedge rst_n) begin
        if (!rst_n)
            counter <= 0;
    else if (counter == 25_000_000) begin
        counter <= 0;               // Reset counter every second
        display_value <= display_value + 1; // Increment display value
    end else
        counter <= counter + 1;
    end

     // Asignar letras en binario al uo_out
    always @(*) begin
        case (display_value)
            4'd0: uo_out = 8'b01000001; // A (binario)
            4'd1: uo_out = 8'b01000010; // B (binario)
            4'd2: uo_out = 8'b01000011; // C (binario)
            4'd3: uo_out = 8'b01000100; // D (binario)
            4'd4: uo_out = 8'b01000101; // E (binario)
            4'd5: uo_out = 8'b01000110; // F (binario)
            4'd6: uo_out = 8'b00110000; // 0 (binario)
            4'd7: uo_out = 8'b00110001; // 1 (binario)
            4'd8: uo_out = 8'b00110010; // 2 (binario)
            4'd9: uo_out = 8'b00110011; // 3 (binario)
            4'd10: uo_out = 8'b00110100; // 4 (binario)
            4'd11: uo_out = 8'b00110101; // 5 (binario)
            4'd12: uo_out = 8'b00110110; // 6 (binario)
            4'd13: uo_out = 8'b00110111; // 7 (binario)
            4'd14: uo_out = 8'b00111000; // 8 (binario)
            4'd15: uo_out = 8'b00111001; // 9 (binario)
            default: uo_out = 8'b00000000; // Blank (off)
        endcase
    end

    // Instanciar el módulo tt_um_uabc_prueba2024
  tt_um_uabc_prueba2024 uut (
    .ui_in  (8'b0),         // Puedes conectar esto a otra señal si lo necesitas
    .uo_out (uo_out),       // Conecta la salida de letras en binario al módulo original
    .uio_in (8'b0),         // Puedes conectar esto a otra señal si lo necesitas
    .uio_out(),             // No necesitas usar esto
    .uio_oe(),              // No necesitas usar esto
    .ena    (1'b1),         // Suponiendo que el módulo original está siempre habilitado
    .clk    (clk),
    .rst_n  (rst_n)
  );

  // List all unused inputs to prevent warnings
  wire _unused = &{ena, 1'b0};

endmodule
