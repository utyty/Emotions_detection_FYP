clear all;
close all;

%% variables settings 
p=1;
k=03;

% mode = 2;   % 1-Anger 2-normal



% num_files = 35;  % 35  anger set
 num_files = 23;  % 23 neutral set

temp_value= zeros(1,num_files)

for p=1:num_files;
    
%  if (p==15) k=10; end   % 03,10,11,12,15 male 
%  if (p==25) k=11; end   % 08,09,13,14,16 female

if (p==12) k=10; end
if (p==16) k=11; end

%file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Anger_Testing\Ang_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];
file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Neutral_Testing\Neu_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

female=false;

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);


% FILTER 
% N = 20;             % order 20
% Wn = 500/(fs/2); % normalise filter cut-off frequen
% B = fir1(N, Wn, 'low');         % Low pass filter, order 20, cut-off freq = 400Hz
% X1 = filter(B, 1, x1);   % Apply filter 
        
% fraqme the signal
org_frames = framing(x1,fs,f_d);

% pitch range male 50-200
pitchMax = 200;
pitchMin= 50;  % %pitch range female 100-400
% change if female sound
    if (female)
        pitchMax = 400;
        pitchMin= 100;  % %pitch range female 100-400
    end
% calculate lags
maxlag= round((1/pitchMin)/(1/fs));
minlag= round((1/pitchMax)/(1/fs));
lag_vec = minlag:maxlag;            % to print peaks only in the lag vector


%% SILENT FILTERING 
% silence remove by amplitude
[sig_amp,amp_frames] = amp_remove(org_frames);

%silence remove by zero-crossing ( signal,frame size, treshold value)
% sig_zcr= zero_crossing(ang_frames, f_size,0.2);
[sig_zcr,zcr_frames]= zero_crossing(amp_frames, f_size,0.2);

% Silence Removal short_energy method
% [ sig_ste ,ste_frames ] = short_tenergy(ang_frames, 0.01);
[ sig_ste ,srt_frames] = short_tenergy(zcr_frames, 0.01);

%Silence Removal by short autocorrelation
 [ sig_accr ,acc_frames ] = short_autocorr( org_frames);
 
figure(11)
subplot(2,1,1);
plot(x1); hold on;grid on;
plot(sig_accr,'r' );

hold off;
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );

subplot(2,1,2)
plot(x1); hold on;grid on;
plot(sig_accr,'r','LineWidth',2);title('Short Term Energy Method');; hold on;grid on;
legend('1-filger','Four');
xlabel('Time(sec)');
ylabel('Amplitude');


%% Ploting signals
% figure(1)
% plot(data1); hold on; plot(sig_amp,'r'); title('amplitude');
% 
% figure(2)
% plot(data1); hold on; plot(sig_zcr,'r'); title('zero-crossing');
% 
% figure(3)
% plot(data1); hold on; plot(sig_ste,'r'); title('shot time energy');

% figure(4)
% plot(data1); hold on; plot(sig_accr,'r'); title('short autocorrelation');
%  pause;

 
%% PITCH CALCUALTION         
%          acc_frames = pre_process(acc_frames);
        
        pitch_plot = AutoCorrelationPlot(acc_frames,fs);
        sum=0;
        for j=1 : length(pitch_plot)
        sum= sum + pitch_plot(j);
        end 
        sumAvg = sum/length(pitch_plot);

        temp_value(p)=sumAvg
        
        figure(p)
        plot(pitch_plot);  grid on; hold on;    
%         xlabel('Frame Number')          
%         ylabel('Pitch Frequency (Hz)')  
% %         title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,sumAvg));
        
        % run with preroccesing
         acc_frames = pre_process(acc_frames);
        
        pitch_plot = AutoCorrelationPlot(acc_frames,fs);
%         sum=0;
%         for j=1 : length(pitch_plot)
%         sum= sum + pitch_plot(j);
%         end 
%         sumAvg = sum/length(pitch_plot);
% 
%         temp_value(p)=sumAvg
        
%         figure(p)
        plot(pitch_plot,'r');      
        xlabel('Frame Number')          
        ylabel('Pitch Frequency (Hz)')  
        title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,sumAvg));
        hold off;
        
     
pause;

%plot(ang_run1);grid on;hold on; plot(temp_value,'r');xlabel('Speaker & sentence num');ylabel('Pitch frequency');
%legend('blue(anger)', 'red(neutral)');; title('Fundamental frequency anger & neutral speaker ');
        %normal




end


