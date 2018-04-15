function [ p_data ] = pre_process (x)

% applying window on each frame
[r,c] = size(x);

for i = 1 : r
x1(i,:) = x(i,:).*hamming(length(x(i,:)))'; % hamming window

end

% Apply a pre-emphasis filter. The pre-emphasis filter is a highpass
% all-pole (AR(1)) filter.
% preemph = [1 0.63];
% x1 = filter(1,preemph,x1);

% all-zero filter
preemph = [1 -0.95];
x1 = filter(preemph, 1, x1);

% final output
p_data = x1;


end 