[signal, Fs] = audioread('my_speech_clip.wav');

L = length(signal); % number of samples in the signal
T = 1/Fs; % sampling period in seconds
t = [0:L-1]*T; % time vector in seconds

Te = 200; % in milliseconds
alpha = 1/2; % reduced amplitude factor
Ne = 5; % number of echos

% extending time vector because current time vector may not be long enough
% for Ne number of echos
t = [0:T:Ne*Te/1000]; 

% convert echo delay from msec to sec,
% then divide by sampling period to find number of delayed samples
delay = floor(Te/1000/T); % must floor because signals are discrete

f = SimpleFunctions();

impulse = f.delta(t); % original signal

for i=1:Ne % Ne number of impulses for Ne number of echos
    % exponentially decreasing in amplitude with alpha^i and Te ms apart 
    impulse = impulse + (alpha.^i)*f.delta(t-i*delay*T);
end

signalplusecho = conv(signal,impulse); %convolution gives signal plus echo
%shorten to only length portion with sound
signalplusecho = signalplusecho(1:L+delay*Ne);

% rescale
signalplusecho = signalplusecho/max(abs(signalplusecho));

%write a new wav file
audiowrite('speechwithreverberation.wav', signalplusecho, Fs);