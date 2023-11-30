[signal, Fs] = audioread('my_speech_clip.wav');

L = length(signal); % number of samples in the signal
T = 1/Fs; % sampling period in seconds
t = [0:L-1]*T; % time vector in seconds

Te = 200; % in milliseconds
alpha = 1/2; % reduced amplitude factor

% convert echo delay from msec to sec,
% then divide by sampling period to find number of delayed samples
delay = floor(Te/1000/T); % must floor because signals are discrete

% 'echo' equals 'signal' shifted to the right by 'delay' steps,
% with zeros filled into the empty space at the beginning of the vector
echo = zeros(L+delay,1); % size of echo becomes L+delay
echo(delay+1:end) = alpha*signal(1:end); % signal times reduced amplitude factor alpha

%size of signal must change because although signal have stopped, there
%will still be signal from echo. fills the end of signal with zeros so
%signal size equals echo size
signal_withzeros = zeros(L+delay,1);
signal_withzeros(1:L) = signal(1:end);

signalplusecho = signal_withzeros + echo;

% rescale
signalplusecho = signalplusecho/max(abs(signalplusecho));

%write a new wav file
audiowrite('speechwithecho.wav', signalplusecho, Fs);