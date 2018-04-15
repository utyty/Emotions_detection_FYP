function frames = framing( data, fs, size)

f_size = size*fs;

nsamp = length(data);
nframes = floor(nsamp/f_size);

temp=0;
for i = 1: nframes
    frames(i,:) = data(temp+1  : temp + f_size);
    temp = temp +f_size;
end 


end 