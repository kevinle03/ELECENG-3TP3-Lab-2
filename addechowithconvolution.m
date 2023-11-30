[signal, Fs] = audioread('my_speech_clip.wav');

L = length(signal); % number of samples in the signal
T = 1/Fs; % sampling period in seconds
t = [0:L-1]*T; % time vector in seconds

Te = 200; % in milliseconds
alpha = 1/2; % reduced amplitude factor

% convert echo delay from msec to sec,
% then divide by sampling period to find number of delayed samples
delay = floor(Te/1000/T); % must floor because signals are discrete

f = SimpleFunctions();

%delta(t) for the original signal and alpha*delta(t-delay*T) for the echo
impulse = f.delta(t) + alpha*f.delta(t-delay*T);

signalplusecho = conv(signal,impulse); %convolution gives signal plus echo
%shorten to only length portion with sound
signalplusecho = signalplusecho(1:L+delay);

% rescale
signalplusecho = signalplusecho/max(abs(signalplusecho));

%write a new wav file
audiowrite('speechwithechoconvolved.wav', signalplusecho, Fs);