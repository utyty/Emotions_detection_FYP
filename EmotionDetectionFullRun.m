clear all;
close all;

%% ANGER TESTING 
p=1;
k=03;

num_files = 60;  % 35  anger set

anger_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==15); k=10; end   % 03,10,11,12,15 male 
if (p==25); k=11; end   % 08,09,13,14,16 female
if (p==36); k=12; end   % 03,10,11,12,15 male 
if (p==48); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Anger_Testing\Ang_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];


[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);
        
% fraqme the signal
org_frames = framing(x1,fs,f_d);

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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[sig_accr ,acc_frames ] = short_autocorr(srt_frames );

 
%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
anger_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        

end

%% RUN NEUTRAL PART 

p=1;
k=03;
num_files = 38;  % 23 neutral set

neutral_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==12); k=10; end
if (p==16); k=11; end
if (p==24); k=12; end
if (p==28); k=15; end

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Neutral_Testing\Neu_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);
       
% fraqme the signal
org_frames = framing(x1,fs,f_d);


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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );


%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
neutral_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('NEUTRAL run:%d, person:%d,  AVG=%.2f',p,k,avg));
        

end

figure(100);
plot(anger_total_run_avg,'b','LineWidth',1);grid on;hold on;
plot(neutral_total_run_avg,'r');
xlabel('Speaker & sentence num');
ylabel('Pitch frequency');
legend('blue(anger)', 'red(neutral)');
title('Fundamental frequency anger & neutral MALE-speaker ');
% title('Fundamental frequency anger & fear / happiness ');
hold on; 


disp('ANGER/NEUTRAL FINISHED - system pause');
pause;



%% BOREDOM TESTING 

p=1;
k=03;

num_files = 34;  % 35  anger set

boredom_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==6); k=10; end   % 03,10,11,12,15 male 
if (p==14); k=11; end   % 08,09,13,14,16 female
if (p==21); k=12; end   % 03,10,11,12,15 male 
if (p==26); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Boredom_Testing\Bor_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);

% fraqme the signal
org_frames = framing(x1,fs,f_d);

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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );

 
%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
boredom_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        
end
plot(boredom_total_run_avg,'k')
legend('blue(anger)', 'red(neutral)', 'black(boredom)');
hold on;
pause;

%% DISGUST TESTING 

p=1;
k=03;

num_files = 11;  % 35  anger set

disgust_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==2); k=10; end   % 03,10,11,12,15 male 
if (p==3); k=11; end   % 08,09,13,14,16 female
if (p==5); k=12; end   % 03,10,11,12,15 male 
if (p==7); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Disgust_Testing\Dis_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);

% fraqme the signal
org_frames = framing(x1,fs,f_d);


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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );

 
%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
disgust_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));        

end

plot(disgust_total_run_avg,'g')
legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)');
hold on;
pause;


%% FEAR TESTING 

p=1;
k=03;

num_files = 36;  % 35  anger set

fear_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==5); k=10; end   % 03,10,11,12,15 male 
if (p==13); k=11; end   % 08,09,13,14,16 female
if (p==23); k=12; end   % 03,10,11,12,15 male 
if (p==29); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Fear_Testing\Fer_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);

% fraqme the signal
org_frames = framing(x1,fs,f_d);

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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );


%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
fear_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        
end
plot(fear_total_run_avg,'y','LineWidth',2)
legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)');
hold on;
pause;


%% HAPPNIES TESTING 

p=1;
k=03;

num_files = 27;  % 35  anger sets

happy_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==8); k=10; end   % 03,10,11,12,15 male 
if (p==12); k=11; end   % 08,09,13,14,16 female
if (p==20); k=12; end   % 03,10,11,12,15 male 
if (p==22); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Happnies_Testing\Hap_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);

% fraqme the signal
org_frames = framing(x1,fs,f_d);

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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );

 
%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
happy_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        
end
plot(happy_total_run_avg,'c','LineWidth',2);
legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)', 'cyan(happy)');
% legend('blue(anger)',  'yellow(fear)', 'cyan(happy)');

hold on;
pause;


%% SADNESS TESTING 

p=1;
k=03;

num_files = 24;  % 35  anger sets

sad_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==7); k=10; end   % 03,10,11,12,15 male 
if (p==10); k=11; end   % 08,09,13,14,16 female
if (p==17); k=12; end   % 03,10,11,12,15 male 
if (p==21); k=15; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTesting\Sadness_Testing\Sad_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

[data,fs]= audioread(file_path);  % ANGER DATA object B anger sample
x1=data /abs(max(data));  % normalize
% p11 = audioplayer(data,fs);

% frame duration 
f_d = 20e-3;
f_size = round(f_d*fs);

% fraqme the signal
org_frames = framing(x1,fs,f_d);


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
% [ sig_accr ,acc_frames ] = short_autocorr( ang_frames );
[ sig_accr ,acc_frames ] = short_autocorr( srt_frames );


%% PITCH CALCUALTION         
% get average pitch freq and plot        
[avg , pitch_plot] = AutoCorrelationPlot(acc_frames,fs);
      
sad_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        
end
plot(sad_total_run_avg,'m')
 legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)', 'cyan(happy)', 'magneta(sad)');
%legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'magneta(sad)');

hold on;
disp('system pause');
pause;



disp('FINISHED');




