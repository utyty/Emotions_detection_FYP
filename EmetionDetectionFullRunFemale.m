clear all;
close all;

%% ANGER TESTING 
p=1;
k=08;

num_files = 66;  % 35  anger set

anger_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==12); k=09; end   % 
if (p==25); k=13; end   % 08,09,13,14,16 female
if (p==37); k=14; end   % 03,10,11,12,15 male 
if (p==53); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Anger_TestingF\Ang_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];


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
      
anger_total_run_avg(p)=avg;
        
%  figure(p)
%  plot(pitch_plot);  grid on;    
%  xlabel('Frame Number')          
%  ylabel('Pitch Frequency (Hz)')  
%  title(sprintf('ANGER run:%d, person:%d,  AVG=%.2f',p,k,avg));
        

end

%% RUN NEUTRAL PART 

p=1;
k=08;
num_files = 40;  % 40 neutral set

neutral_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==11); k=09; end   % 
if (p==20); k=13; end   % 08,09,13,14,16 female
if (p==29); k=14; end   % 03,10,11,12,15 male 
if (p==36); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Neutral_TestingF\Neu_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
title('Fundamental frequency anger & neutral speaker FEMALE ');
hold on; 


disp('ANGER/NEUTRAL FINISHED - system pause');
pause;



%% BOREDOM TESTING 

p=1;
k=08;

num_files = 46;  % 46  boredom set

boredom_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==11); k=09; end   % 
if (p==15); k=13; end   % 08,09,13,14,16 female
if (p==25); k=14; end   % 03,10,11,12,15 male 
if (p==33); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Boredom_TestingF\Bor_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
k=09;

num_files = 34;  % 34  disgust set

disgust_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
% if (p==8); k=09; end   % 
if (p==08); k=13; end   % 08,09,13,14,16 female
if (p==16); k=14; end   % 03,10,11,12,15 male 
if (p==24); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Disgust_TestingF\Dis_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
% legend('blue(anger)',  'green(disgust)');
hold on;
pause;


%% FEAR TESTING 

p=1;
k=08;

num_files = 33;  % 33  anger set

fear_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==07); k=09; end   % 
if (p==08); k=13; end   % 08,09,13,14,16 female
if (p==15); k=14; end   % 03,10,11,12,15 male 
if (p==27); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Fear_TestingF\Fer_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
plot(fear_total_run_avg,'y','LineWidth',1)
legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)');
% legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)');

hold on;
pause;


%% HAPPNIES TESTING 

p=1;
k=08;

num_files = 44;  % 44  happy sets

happy_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==12); k=09; end   % 
if (p==16); k=13; end   % 08,09,13,14,16 female
if (p==26); k=14; end   % 03,10,11,12,15 male 
if (p==32); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Happnies_TestingF\Hap_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
% legend('blue(anger)',  'green(disgust)', 'yellow(fear)', 'cyan(happy)');
legend('blue(anger)', 'red(neutral)', 'black(boredom)', 'green(disgust)', 'yellow(fear)', 'cyan(happy)');
hold on;
pause;


%% SADNESS TESTING 

p=1;
k=08;

num_files = 37;  % 35  anger sets

sad_total_run_avg= zeros(1,num_files);

for p=1:num_files;
    
if (p==10); k=09; end   % 
if (p==14); k=13; end   % 08,09,13,14,16 female
if (p==19); k=14; end   % 03,10,11,12,15 male 
if (p==29); k=16; end   % 08,09,13,14,16 female

file_path= [ 'C:\Users\JaroslawJ\Desktop\MATALB_ImageTesting\SpeechTesting\AutomaticTestingFemale\Sadness_TestingF\Sad_' num2str(k,'%02d'),'a' num2str(p,'%02d'),'.wav'];

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
% legend('blue(anger)', 'red(neutral)', 'black(boredom)',    'magneta(sad)');

hold on;
disp('system pause');
pause;


disp('FINISHED');