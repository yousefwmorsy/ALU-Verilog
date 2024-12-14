module rem (
    input [2:0] A, [2:0] B,
    output DZF, ZF, SF, [2:0] R
);
assign R[0]=A[0]&B[1]&!(A[1]&B[0]);
assign R[1]=A[1]&(!A[0])&B[1]&B[0];
assign DZF =(!B[1])&(!B[0]);
assign R[2]=(!DZF)&A[2];
assign SF = R[2];
assign ZF = (!DZF)&(!R[0])&(!R[1]);
endmodule