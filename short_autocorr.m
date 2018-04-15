function [data_r ,fr_ws] = short_autocorr(frames)

[r,c] = size(frames);
for k = 1:r
t = frames(k,:);
sum1 = 0;ac = 0;
for i = 0:length(t)-1
    sum1 = 0;
    for j = 1:length(t)-i
        s = t(j)*t(j+i);
        sum1 = sum1 + s;
    end
    ac(i+1) = sum1;
end
temp(k) = ac(1);
stac(k) = ac(2); % taking second coeff. built in function gives normalized
% autocorrelation (it is autocorr at lag 1)
end

% short term auto corr. (stac)
stac = stac./max(stac); %normalize the data


% Silence Removal
id = find(stac >= 0.01);
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);


end 