module mul (
    input [2:0] A,  
    input [2:0] B,  
    output [4:0] R, 
    output SF,      
    output ZF      
);

    wire A0 = A[0];
    wire A1 = A[1];
    wire A2 = A[2];
    wire B0 = B[0];
    wire B1 = B[1];
    wire B2 = B[2];

    // s=made using sign magnitude logic 
    assign R[0] = A0 & B0;
    assign R[1] = (A0 & B1) ^ (A1 & B0);
    assign R[2] = ((A0 & B1) & (A1 & B0)) ^ (A1 & B1);
    assign R[3] = ((A0 & B1) & (A1 & B0)) & (A1 & B1);
    assign R[4] = A2 ^ B2;

    
    assign SF = R[4];            
    assign ZF = (R == 5'b00000); 

endmodule
