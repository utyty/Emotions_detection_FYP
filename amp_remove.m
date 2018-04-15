function [ AMP,f_frames ] = amp_remove(x)

m_amp = abs(max(x,[],2));  % get maximas from each frame
id = find(m_amp >0.03);   % keep frames above 0.03
f_frames=x(id,:); 
AMP = reshape(f_frames',1,[]);  %filtered signal

end