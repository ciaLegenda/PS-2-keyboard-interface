# PS/2 Keyboard Interface with 7-Segment Display

This project is a VHDL implementation for interfacing the PS/2 protocol for keyboards with the Nexys 4 DDR board from Digilent. It displays the last 8 characters pressed on a 7-segment display.
It is the final project for the Digital Systems Design laboratory.
In the current implementation it uses the built-in USB to PS/2 keyboard convertor included in the board enabling it to work with regular USB keyboards.

## Features

- Interface with a PS/2 keyboard.
- Display the last 8 characters pressed on a 7-segment display.
- VHDL implementation for the Nexys 4 DDR board.

## Requirements

- Nexys 4 DDR board from Analog Devices
- PS/2 keyboard
- 7-segment display

## Setup Instructions

1. Connect the PS/2 keyboard to the Nexys 4 DDR board.
2. Load the VHDL code onto the Nexys 4 DDR board using Xilinx Vivado or any compatible FPGA development environment.
3. Connect the keyboard to the board
5. Start typing on the PS/2 keyboard.
6. The last 8 characters pressed will be displayed on the built-in 7-segment display.


## Note

- This VHDL implementation provides a basic functionality to interface a PS/2 keyboard with the Nexys 4 DDR board and display the last 8 characters pressed.


