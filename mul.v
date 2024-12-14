module mul (
    input signed [2:0] A,   
    input signed [2:0] B,   
    output signed [4:0] R,  
    output SF,              
    output ZF,
    output DZF               
);
    wire A0 = A[0], A1 = A[1], A2 = A[2]; 
    wire B0 = B[0], B1 = B[1], B2 = B[2]; 

    // Multiplying the magnitudes
    assign R[0] = A0 & B0;
    assign R[1] = (A0 & B1) ^ (A1 & B0);
    assign R[2] = ((A0 & B1) & (A1 & B0)) ^ (A1 & B1);
    assign R[3] = ((A0 & B1) & (A1 & B0)) & (A1 & B1);
    assign R[4] = A2 ^ B2;  

    
    assign SF = (A[2] ^ B[2]);  
    assign ZF = (R == 5'b00000); 
    assign DZF = 0;
endmodule
