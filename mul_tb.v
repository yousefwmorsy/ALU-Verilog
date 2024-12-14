module mul_tb;
    reg [2:0] A, B;   
    wire [4:0] R;     
    wire SF, ZF, DZF;       
    integer file_mult, i, j;
    integer result;


    mul DUT (
        .A(A),
        .B(B),
        .R(R),
        .SF(SF),
        .DZF(DZF),
        .ZF(ZF)
    );


    initial begin
        file_mult = $fopen("mult.txt", "w");
        if (file_mult == 0) begin
            $display("Error opening file!");
            $finish;
        end
        for (i = -3; i <= 3; i = i + 1) begin
            for (j = -3; j <= 3; j = j + 1) begin
                A = (i < 0) ? {1'b1, -i[1:0]} : {1'b0, i[1:0]};
                B = (j < 0) ? {1'b1, -j[1:0]} : {1'b0, j[1:0]};
                #10;
                /*
                (if needed in decimal)
                result = (R[4] == 1) ? -R[3:0] : R[3:0]; 
                $fdisplay(file_mult, "A = %0d, B = %0d, R = %0d, SF = %b, ZF = %b, DZF = %b",
                          i, j, result, R[4], ZF, DZF);
                */
                $fdisplay(file_mult, "A = %3b, B = %3b, R = %5b, SF = %b, ZF = %b, DZF = %b",
                          A, B, R, SF, ZF, DZF); 
            end
        end
        $fclose(file_mult);
    end
endmodule
