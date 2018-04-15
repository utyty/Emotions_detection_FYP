+% This file do separation of voiced/un-voiced/silence regions of an speech
% signal
% 
% Lecture Series: Speech & Audio Signal Processing
% Created By: JCBRO Labs
% Date: 15/05/2017
% website: www.jcbrolabs.org
% mail: jcbrolabs@gmail.com

close all; clear all;

% read sound 
[data, fs] = audioread('10b02Wb.wav');
% normalize data
data = data / abs(max(data));
% do framing
f_d = 0.025;
f_size = round(f_d * fs);
n = length(data);
n_f = floor(n/f_size);  %no. of frames
temp = 0;
for i = 1 : n_f
    
   frames(i,:) = data(temp + 1 : temp + f_size);
   temp = temp + f_size;
end

% voiced sample (110 frame)

% plot(frames(110,:));
% figure; 
% autocorr(frames(110,:),length(frames(110,:)) - 1);
% figure; plot(abs(fft(frames(110,:))));

% unvoices or silence part
% figure; plot(frames(40,:));title('unvoiced/silence part');
% figure;
%  autocorr(frames(40,:),length(frames(40,:)) -1);
%  figure; plot(abs(fft(frames(50,:))));

% silence removal based on max amplitude
m_amp = abs(max(frames,[],2)); % find maximum of each frame
id = find(m_amp > 0.03); % finding ID of frames with max amp > 0.03
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);

figure(1);
subplot(4,1,1);
plot(data);hold on;
plot(data_r,'g');grid on; 
title('original / Amplitude Filter ');
%xlabel('Time(msec)');
ylabel('Amp.');
hold off;

% figure(5)
% subplot(2,1,1);
% plot(data);hold on;
% plot(data_r,'g');grid on; 
% title('original / Amplitude Filter ');
% xlabel('Time(msec)');
% ylabel('Amplitude');
% hold off;

figure(5)
subplot(2,1,1);
plot(data);grid on;
xlim([0 50000]);
title('Original Signal');
xlabel('Time(msec)');
ylabel('Amplitude');

subplot(2,1,2);
plot(data_r,'g');grid on; 
xlim([0 50000]);
title(' Amplitude Filter  ');
xlabel('Time(msec)');
ylabel('Amplitude');

%  figure(1);
%      subplot(2,2,1);
% %      imshow(frame);
%      imshow(enhanced_frame);
%      title(sprintf('frame - %d',i));
%      
%      subplot(2,2,2);
%      imshow(FmaskBW);
%      title(sprintf('BBOX - FILTER:%.2f',dynamic_filter));
%      hold on;
% 





%%--------------------------



% This file calculates short time Zero Crossing Rate (ZCR) of voice/ausio
% signal. or in other words finds Frame ZCR
% 
% Lecture Series: Speech & Audio Signal Processing
% Created By: JCBRO Labs
% Date: 03/06/2017
% website: www.jcbrolabs.org
% mail: jcbrolabs@gmail.com
 
clear all;

% read sound 
[data, fs] = audioread('10b02Wb.wav');
% normalize data
data = data / abs(max(data));

% do framing
f_d = 0.025;
frames = framing(data, fs, f_d);

% e.g. of ZCR
% x = [1 2 -3 4 5 -6 2 -6 2];
x = frames(110,:);

%% Method 1
ZCR1 = 0;
for i = 1:length(x) - 1
    
   if ((x(i) < 0) && (x(i + 1) > 0 ))
       ZCR1 = ZCR1 + 1;
   
   elseif ((x(i) > 0) && (x(i + 1) < 0))
       ZCR1 = ZCR1 + 1;
   end
end

%% Method 2
ZCR2 = sum(abs(diff(x > 0)));

%% Method 3
ZCR3 = sum(x(1 : end - 1) .* x(2:end) <= 0);

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
    %% Method 2
    ZCRf2(i) = sum(abs(diff(x > 0)));

    %% Method 3
    ZCRf3(i) = sum(x(1 : end - 1) .* x(2:end) <= 0);
    
    
end

% calculating rate
ZCRr1 = ZCRf1/length(x);
ZCRr1 = ZCRr1/max(ZCRr1);
f_size = round(f_d * fs);
zcr_wave = 0;
for j = 1 : length(ZCRr1)
    l = length(zcr_wave);
    zcr_wave(l : l + f_size) = ZCRr1(j);
end
% plot the ZCR with Signal
t = [0 : 1/fs : length(data)/fs]; % time in sec
t = t(1:end - 1);
t1 = [0 : 1/fs : length(zcr_wave)/fs];
t1 = t1(1:end - 1);

figure(2);
subplot(2,1,1);
plot(t,data'); hold on;grid on;
plot(t1,zcr_wave,'r','LineWidth',2);
title(' Zero Crossing Method ');
legend('original signal', 'zero crossing rate');
xlabel('Time(sec)');
ylabel('Amplitude');

% % plot(t,data'); hold on;grid on;
% plot(t1,zcr_wave,'r','LineWidth',2);
% title(' Zero Crossing Method ');
% legend('original signal', 'zero crossing count');
% xlabel('Time(sec)');
% ylabel('Normalize Amplitude');


% Silence Removal
id = find(ZCRr1 <= 0.2);
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);

figure(2);
subplot(2,1,2);
plot(data);hold on; grid on;
plot(data_r,'g'); title('Original / Zero Crossing Filter');
legend('original signal', 'zero crossing');
xlabel('Time(msec)');
ylabel('Amplitude');
hold off;


figure(1)
subplot(4,1,2);
plot(data);hold on; grid on;
plot(data_r,'g'); title('Original / Zero Crossing filter');
%xlabel('Time(msec)');
ylabel('Amp.');
hold off;
% plot(data);hold on; grid on;
% plot(data_r,'g'); title('Zero Crossing Method');
% title(' Zero Crossing Method ');
% legend('original signal', 'zero crossing');
% xlabel('Time(sec)');
% ylabel('Normalize Amplitude');


%%-------------------------
% This file calculates short time Energy (STE) of voice/audio
% signal. or in other words finds Frame Energy
% 
% Lecture Series: Speech & Audio Signal Processing
% Created By: JCBRO Labs
% Date: 11/06/2017
% website: www.jcbrolabs.org
% mail: jcbrolabs@gmail.com

clear all;
% read sound 
[data, fs] = audioread('10b02Wb.wav');
% normalize data
data = data / abs(max(data));

% do framing
f_d = 0.025;
frames = framing(data, fs, f_d);% it is like 0% overlap with rectangular window

% calculate frames energy
[r,c] = size(frames);
ste = 0;
for i = 1 : r
    ste(i) = sum(frames(i,:).^2);    
end

ste = ste./max(ste); %normalize the data

f_size = round(f_d * fs);
ste_wave = 0;
for j = 1 : length(ste)
    l = length(ste_wave);
    ste_wave(l : l + f_size) = ste(j);
end

% plot the STE with Signal
t = [0 : 1/fs : length(data)/fs]; % time in sec
t = t(1:end - 1);
t1 = [0 : 1/fs : length(ste_wave)/fs];
t1 = t1(1:end - 1);


figure(3);
subplot(2,1,1);
plot(t,data'); hold on;grid on;
plot(t1,ste_wave,'r','LineWidth',2);title('Short Term Energy Method');
legend('Speech Signal','STE');
xlabel('Time(sec)');
ylabel('Amplitude');

% Silence Removal
id = find(ste >= 0.01);
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);
figure(3);
subplot(2,1,2);
plot(data);hold on;grid on;
plot(data_r,'g'); title('Original /STE Filter');
legend('Speech Signal','STE Method');
xlabel('Time(msec)');
ylabel('Amplitude');

figure(1)
subplot(4,1,3);
plot(data);hold on; grid on;
plot(data_r,'g'); title('Original / STE Filter');
%xlabel('Time(msec)');
ylabel('Amp.');
hold off;


%%---------------------

 %This file calculates short time Autocorrelation of voice/audio
% 
% Lecture Series: Speech & Audio Signal Processing
% Created By: JCBRO Labs
% Date: 11/06/2017
% website: www.jcbrolabs.org
% mail: jcbrolabs@gmail.com
clear all;

% read sound 
[data, fs] = audioread('10b02Wb.wav');
% normalize data
data = data / abs(max(data));

% do framing
f_d = 0.025;
frames = framing(data, fs, f_d);% it is like 0% overlap with rectangular window

% Short term autocorrelation and taking 1 coeff. value i.e. at lag 1 
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

f_size = round(f_d * fs);
stac_wave = 0;
for j = 1 : length(stac)
    l = length(stac_wave);
    stac_wave(l : l + f_size) = stac(j);
end

% plot the stac with Signal
t = [0 : 1/fs : length(data)/fs]; % time in sec
t = t(1:end - 1);
t1 = [0 : 1/fs : length(stac_wave)/fs];
t1 = t1(1:end - 1);

figure(4);
subplot(2,1,1);
plot(t,data'); hold on;grid on;
plot(t1,stac_wave,'r','LineWidth',2);title('Short Term Auto Corr. Method');
legend('Speech Signal','Short Term Auto Corr.');
xlabel('Time(sec)');
ylabel('Amplitude');



% Silence Removal
id = find(stac >= 0.01);
fr_ws = frames(id,:); % frames without silence

% reconstruct signal
data_r = reshape(fr_ws',1,[]);



figure(4);
subplot(2,1,2)
plot(data);hold on;grid on;
plot(data_r,'g');title('Original / Short Term Auto Corr. Filter');
legend('Speech Signal','STA');
xlabel('Time(msec)');
ylabel('Amplitude');





figure(1)
subplot(4,1,4);
plot(data);hold on; grid on;
plot(data_r,'g'); title('Original / Short Term Auto Corr. Filter');
xlabel('Time(msec)');
ylabel('Amp.');
hold off;

