function[bk_out]= dpskdemod(initial_bit,dk_radians)
    if initial_bit==0 then
        initial_phase =%pi;
    else
        initial_phase = 0;
    end
    L = length(dk_radians);
    for i = 1:L
        if i==1
            bk_out(i)= cos(initial_phase-dk_radians(i));
        else
            bk_out(i)=cos(dk_radians(i-1)-dk_radians(i));
        end
        if(bk_out(i)<0)
            bk_out(i) = 0;
        else
            bk_out(i) = 1;
        end
    end
    disp(bk_out,'DPSK demodulated data bk_out=')
endfunction
