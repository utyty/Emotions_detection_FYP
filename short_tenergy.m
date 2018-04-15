function [data_r,fr_ws] = short_tenergy (frames, treshold)

% calculate frames energy
[r,c] = size(frames);
ste = 0;
for i = 1 : r
    ste(i) = sum(frames(i,:).^2);    
end

ste = ste./max(ste); %normalize the data


% Silence Removal
id = find(ste >= treshold);
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);


end 