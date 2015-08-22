function X = gray2bin(x)
    //Function is used to find gray equivalent binary value
    //x is the gray value
    //X is the binary equivalent of gray value x
    X=[]
    temp =x;
    while x>1
        Z = modulo(x,2); //remainder
        Z = floor(Z);    //round to nearest integer
        X = [X Z]
        x= x/2;
        disp(x)
    end
    Y = 2^log2(temp);   //to check whether x is a power of 2
    if (temp==Y) then
        X = [X 1];      // if x is a power of 2 append 1 for MSBit
    end
    X = X([$:-1:1]) //flipping Lsb into Msb and Msb into Lsb
endfunction
