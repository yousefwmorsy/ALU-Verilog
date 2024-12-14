/*================== 4x1 Mux Module ====================*/
module mux4x1(
    input [3:0] I, [1:0] S,
    output O
);
wire C1, C2, C3, C4;

assign C1 = I[0] & ~S[1] & ~S[0];
assign C2 = I[1] & ~S[1] & S[0];
assign C3 = I[2] & S[1] & ~S[0];
assign C4 = I[3] & S[1] & S[0];
assign O = C1 | C2 | C3 | C4;

endmodule

/*================== ALU ====================*/
module alu (
    input [2:0] A, [2:0] B, [1:0] S,
    output SF, ZF, DZF, [4:0] R
);

wire [3:0] addsub; 
wire [4:0] mul; 
wire [2:0] rem;

add_sub addsub1(
    .A(A), .B(B), .OP(S[0]), .R(addsub)
);
mul mul1(
    .A(A), .B(B), .R(mul)
);
rem rem1(
    .A(A), .B(B), .R(rem)
);

wire [3:0] w1, w2, w3, w4, w5;
assign w1[0] = addsub[0];
assign w1[1] = addsub[0];
assign w1[2] = mul[0];
assign w1[3] = rem[0];
mux4x1 mux1(
    .I(w1), .S(S), .O(R[0])
);
assign w2[0] = addsub[1];
assign w2[1] = addsub[1];
assign w2[2] = mul[1];
assign w2[3] = rem[1];
mux4x1 mux2(
    .I(w2), .S(S), .O(R[1])
);
assign w3[0] = addsub[2];
assign w3[1] = addsub[2];
assign w3[2] = mul[2];
assign w3[3] = 0;
mux4x1 mux3(
    .I(w3), .S(S), .O(R[2])
);
assign w4[0] = 0;
assign w4[1] = 0;
assign w4[2] = mul[3];
assign w4[3] = 0;
mux4x1 mux4(
    .I(w4), .S(S), .O(R[3])
);
assign w5[0] = addsub[3];
assign w5[1] = addsub[3];
assign w5[2] = mul[4];
assign w5[3] = rem[2];
mux4x1 mux5(
    .I(w5), .S(S), .O(R[4])
);

assign DZF = S[0]&S[1]&(!B[1])&(!B[0]);
assign ZF = ~(R[0] || R[1] || R[2] || R[3])&(!DZF);
assign SF = R[4]&!ZF;

endmodule