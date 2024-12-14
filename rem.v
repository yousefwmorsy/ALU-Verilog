module rem (
    input [2:0] A, [2:0] B,
    output [2:0] R
);
assign DZF =(!B[1])&(!B[0]);
assign R[0]=!DZF&(A[0]&B[1]&!(A[1]&B[0]));
assign R[1]=!DZF&(A[1]&(!A[0])&B[1]&B[0]);
assign R[2]=!DZF&(A[2]);
assign SF = A[2];
assign ZF = (!R[0])&(!R[1]);
endmodule