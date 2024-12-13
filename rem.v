module rem (
    input [2:0] A, [2:0] B,
    output [4:0] R , DZF , ZF , SF
);
assign R[0]=A[0]&B[1]&!(A[1]&B[0]);
assign R[1]=A[1]&(!A[0])&B[1]&B[0];
assign R[3:2] = 2'b00;
assign R[4]=A[2];
assign SF = A[2];
assign DZF =(!B[1])&(!B[0]);
assign ZF = (!R[0])&(!R[1]);
endmodule