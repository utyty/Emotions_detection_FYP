function [ data ,fr_ws] = zero_crossing (frames,f_size, treshold) 

%% finding ZCR of all frames
[r, c] = size(frames);

for i = 1 : r
    
    x = frames(i, :);
    %% Method 1
    ZCRf1(i) = 0;
    for k = 1:length(x) - 1
    
        if ((x(k) < 0) && (x(k + 1) > 0 ))
            ZCRf1(i) = ZCRf1(i) + 1;
   
        elseif ((x(k) > 0) && (x(k + 1) < 0))
            ZCRf1(i) = ZCRf1(i) + 1;
        end
    end
    %% Method 2   gives slitghly diifernt output
%     ZCRf2(i) = sum(abs(diff(x > 0)));

    %% Method 3  gives slitghly diifernt output
%     ZCRf3(i) = sum(x(1 : end - 1) .* x(2:end) <= 0);

end


ZCRf1 = ZCRf1/length(f_size);
ZCRf1 = ZCRf1/max(ZCRf1);

id = find(ZCRf1 <= treshold);
fr_ws = frames(id,:);
data = reshape(fr_ws',1,[]);



end 