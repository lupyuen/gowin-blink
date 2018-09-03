//  Demo Verilog Module that flashes the LED by shifting 4 bits
//  from "SUG100-1.2E_Gowin YunYuan Software User Guide"

module demo (  //  Declare our demo module.
    clk_50M,   //  Declare 3 pins: clk_50M, rst_n, led.
    rst_n,     //  We will connect these pins to the
    led);      //  actual clock signal, reset signal and LEDs.

input clk_50M;    //  Declare the clock pin as an Input signal.
input rst_n;      //  Reset pin is also an Input, triggered by board restart or reset button.
output[3:0] led;  //  LED is actually 4 discrete LEDs at 4 Output signals. Each LED Output is 1 bit.
                  //  So think of "output[3:0] led" as an Output array of 4 bits: "output led[0], led[1], led[2], led[3]"
reg[3:0] led;     //  Declare led (4 bits), cnt (25 bits) and clk_led (1 bit) as Registers that
reg[24:0] cnt;    //  can remember a value in volatile FPGA memory (similar to RAM).
reg clk_led;      //  So led refers to a 4-bit Output signal that is remembered when it gets updated.

//  This block increments a counter and flips the clk_led bit on or off upon overflow.
always@(                //  Code below is always triggered when these conditions are true...
    posedge clk_50M or  //  When the clock signal transitions from low to high (positive edge) OR
    negedge rst_n       //  When the reset signal transitions from high to low (negative edge) which
    ) begin             //  happens when the board restarts or reset button is pressed.

    if (!rst_n) begin     //  If board restarts or reset button is pressed...
        clk_led <= 1'b0;  //  Init clk_led and cnt to 0. "1'b0" means "1-Bit, Binary Value 0"
        cnt <= 25'd0;     //  "25'd0" means "25-bit, Decimal Value 0"
    end
    else begin
        if (cnt == 25'd2499_9999) begin  //  If our counter has reached its limit...
            clk_led <= ~clk_led;  //  Toggle the clk_led from 0 to 1 (and 1 to 0).
            cnt <= 25'd0;         //  Reset the counter to 0.
        end
        else begin
            cnt <= cnt + 25'd1;  //  Else increment counter by 1. "25'd1" means "25-bit, Decimal Value 1"
        end
    end
end

//  This block watches for the clk_led bit to flip from 0 to 1 and shifts the 4 LED lights left.
//  The state of the 4 LED lights is remembered by the 4-bit register "led", which looks like this:
//  { led[3] , led[2] , led[1] , led[0] } Register "led" is a 4-bit value.
//     ON       ON       ON       OFF     Suppose our 4 LEDs are ON, ON, ON, OFF...
//      0        0        0        1      Map ON to 0 (Low) and OFF to 1 (High)...
//  Which equals Binary 0001 = Decimal 1, the "led" value for ON, ON, ON, OFF

//  Now what happens when we shift each bit l place left?
//  { led[2] , led[1] , led[0] , led[3] } Register "led" is shifted left 1 bit. Bit 3 wraps to 0.
//     ON       ON       OFF      ON      Now our 4 LEDs are ON, ON, OFF, ON...
//      0        0        1        0      Map ON to 0 (Low) and OFF to 1 (High)...
//  Which equals Binary 0010 = Decimal 2, the "led" value for ON, ON, OFF, ON
//  The first 2 columns { led[2], led[1], led[0] } can be written as { led[2:0] }
//  Hence to shift left, we would write { led[2:0], led[3] }

always@(                //  Code below is always triggered when these conditions are true...
    posedge clk_led or  //  When the clk_led register transitions from low to high (positive edge) OR
    negedge rst_n       //  When the reset signal transitions from high to low (negative edge) which
    ) begin             //  happens when the board restarts or reset button is pressed.

    if (!rst_n) begin  //  If board restarts or reset button is pressed...
        led <= 4'h1;   //  Init the 4-bit led value to 1.  "4'h1" means "4-bit, Hexadecimal Value 1".
    end                //  Value 1 means ON, ON, ON, OFF for the 4 LEDs (see above)
    else begin
        led <= { led[2:0], led[3] };  //  Else we shift the LEDs left 1 place (see above)
    end
end
endmodule