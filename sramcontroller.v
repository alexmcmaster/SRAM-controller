module sramcontroller(nOE, nCS, nWE, RS, AS, read, clk, rst, DE);

	input read, clk, rst;
	output reg nOE, nCS, nWE, RS, AS, DE;
	
	parameter state00 = 4'b0000;
	parameter state01 = 4'b0001;
	parameter state02 = 4'b0010;
	parameter state03 = 4'b0011;
	parameter state04 = 4'b0100;
	parameter state05 = 4'b0101;
	parameter state06 = 4'b0110;
	parameter state07 = 4'b0111;
	parameter state08 = 4'b1000;
	parameter state09 = 4'b1001;
	
	reg [3:0] state; 
	
	always@(posedge clk) begin
		nCS = 1'b0;
		nOE = (state == state00) | (state == state01) | (state == state02) | (state == state03) 
							| (state == state04) | (state == state05) | (state == state06) | (state == state07);
		AS = (state == state01) | (state == state06);
		RS = (state == state03) | (state == state07);
		nWE = (state != state04);
		DE = (state == state03) | (state == state04) | (state == state05);
		
	end
	
	always@(posedge clk or posedge rst) begin
		if (rst)
			begin
				state = state00;
			end
		else case(state)
			state00:
				begin
					if(!read)
						state = state01;
					else if(read)
						state = state06;
				end
			state01:
				begin
					state = state02;
				end
			state02:
				begin
					state = state03;
				end
			state03:
				begin
					state = state04;
				end
			state04:
				begin
					state = state05;
				end
			state05:
				begin
					state = state00;
				end
			state06:
				begin
					state = state07;
				end
			state07:
				begin
					state = state08;
				end
			state08:
				begin
					state = state09;
				end
			state09:
				begin
					state = state00;
				end
			default:
				begin
					state = state00;
				end
		endcase
	end
endmodule
