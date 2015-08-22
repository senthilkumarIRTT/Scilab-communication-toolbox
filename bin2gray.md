function X = bin2gray(x)
    //Function is used to find binary equivalent gray value
    //x is the binary value
    //X is the gray equivalent of binary value x
    X=0;
    temp =x;
    L = length(x)
    x = x([$:-1:1]);
    for i = 1:L
        Z = x(i)*(2^(i-1));
        X = X+Z;
    end
endfunction
