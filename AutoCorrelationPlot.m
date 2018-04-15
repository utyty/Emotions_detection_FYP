function [sumAvg ,pitch_freq] = AutoCorrelationPlot ( frames,fs)

%round number of frames
[r,c] = size(frames);

pitch_freq = zeros(1,r);
frame_len = c;


sum=0;
        
% loop thru all frames 
 for i = 1:r
    
    curr_frame = frames(i,:); %(ptr+1:ptr+f_size);
  
    [rxx lag] = xcorr(curr_frame, curr_frame);
    rxx(find(rxx <= 0)) = 0; %set any negative correlation values to zero
    center_peak_width = find(rxx(frame_len:end) == 0 ,1); %find first zero after center
    center_peak_width = 30; %center_peak_width
    % make center eqial zero      
    rxx(frame_len-center_peak_width : frame_len+center_peak_width  ) = min(rxx);
    % get maks from next peak
   [max_val loc] = max(rxx);
    period = abs(loc - length(curr_frame)+1); 

    % save pitch period to array
    pitch_freq(i)= (fs/period);     
    sum= sum+ pitch_freq(i);

   
 end
 
 sumAvg = sum/length(pitch_freq);




end 