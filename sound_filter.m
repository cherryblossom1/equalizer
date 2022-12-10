% this code let's you set the gains for different frequencies while playing
% the audio file. I will make it interactive in coming years.

% let's start tweeking the gain for each frequencies.

%% misc %%
clear;
clc;

%% intialisation %%
[Y, Fs] = audioread('rec.wav');              % read an audio file
Tdur = size(Y,1)/Fs;                                      % total length of audio file in seconds
NBIT=16;                                     % #bits
NCHANS=2;                               % #channels
T=0.08;                                           % time frame(block) in seconds
t=Tdur;                                    % time duration for playing in seconds (not more than total length)
F0=554;                                      % fundamental frequency
gr=2^(1/12);                                 % harmony golden ratio
Yplay = Y(1:round(t*Fs),:);                  % take only first 't' duration

%% create filterbank %%
key=(0:88)';
fn = F0 * gr.^(key-49);
Ts = 1/Fs;
n = (0:Ts:T)';
filterbank = cos(2*pi*n*fn');
M = size(filterbank,2);

%% set filter gains manually %%
Fgain_base = double(fn<500);
Fgain_squawker = double(fn>500 & fn<2000);
Fgain_tweeter = double(fn>2000);
Fgain = Fgain_squawker;

%% filter the input %%
for(k1=1:M)
     Yplay = Yplay + [filter(Fgain(k1)*filterbank(:,k1),1,Yplay(:,1)) Fgain(k1)*filter(filterbank(:,k1),1,Yplay(:,2))]/M;
end

% object creation %
I = audioplayer(Yplay, Fs, NBIT);

% setting object properties %
set(I,'TimerFcn',@(I,~)plotG(I,0,Yplay,T,Fs,filterbank,fn),'TimerPeriod',T);

%% execution %%
% play %
play(I,[1 (t-T)*Fs]);
