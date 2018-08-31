//  From file:///C:/Gowin/English/SUG100-1.2E_Gowin%20YunYuan%20Software%20User%20Guide.pdf
module demo (clk_50M, rst_n,led);
input clk_50M;
input rst_n;
output[3:0] led;
reg[3:0] led;
reg[24:0] cnt;
reg clk_led;

always@(posedge clk_50M or negedge rst_n) begin
    if (!rst_n) begin
        clk_led <= 1'b0;
        cnt <= 25'd0;
    end
    else begin
        if (cnt == 25'd2499_9999) begin
            clk_led<= ~clk_led;
            cnt <= 25'd0;
        end
        else begin
            cnt <= cnt + 25'd1;
        end
    end
end

always@(posedge clk_led or negedge rst_n) begin
    if(!rst_n) begin
        led <= 4'h1;
    end
    else begin
        led <= {led[2:0],led[3]};
    end
end
endmodule