module alu_tb;
    reg [1:0] S;
    reg [2:0] A, B;   
    wire [4:0] R;     
    wire SF, ZF, DZF;       
    integer file_mult, i, j, k;
    integer result;

    alu DUT (
        .A(A),
        .B(B),
        .S(S),
        .R(R),
        .SF(SF),
        .ZF(ZF),
        .DZF(DZF)
    );

    initial begin
        file_mult = $fopen("alu.txt", "w");
        if (file_mult == 0) begin
            $display("Error opening file!");
            $finish;
        end
        for (k = 0; k < 4; k = k+1) begin
            for (i = -3; i <= 3; i = i + 1) begin
                for (j = -3; j <= 3; j = j + 1) begin
                    A = (i < 0) ? {1'b1, -i[1:0]} : {1'b0, i[1:0]};
                    B = (j < 0) ? {1'b1, -j[1:0]} : {1'b0, j[1:0]};
                    S = k;
                    #10;
                    result = (R[4] == 1) ? -R[3:0] : R[3:0]; 
                    $fdisplay(file_mult, "A = %0d, B = %0d, S=%0d R = %0d, SF = %b, ZF = %b, DZF = %b",
                            i, j, k, result, R[4], ZF, DZF); 
                end
            end
        end


        $fclose(file_mult);
        $finish;
    end
endmodule