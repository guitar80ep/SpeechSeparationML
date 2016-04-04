% Load a waveform, calculate its gammatone spectrogram, then display:
[d,sr] = wavread('wav/arctic_a0001-sin.wav');
tic; [D,F] = gammatonegram(d,sr); toc
%Elapsed time is 0.140742 seconds.
subplot(211)
imagesc(20*log10(D)); axis xy
caxis([-90 -30])
colorbar
% F returns the center frequencies of each band;
% display whichever elements were shown by the autoscaling
set(gca,'YTickLabel',round(F(get(gca,'YTick'))));
ylabel('freq / Hz');
xlabel('time / 10 ms steps');
title('Gammatonegram - fast method')

% Now repeat with flag to use actual subband filters.
% Since it's the last argument, we have to include all the other
% arguments.  These are the default values for: summation window
% (0.025 sec), hop between successive windows (0.010 sec),
% number of gammatone channels (64), lowest frequency (50 Hz),
% and highest frequency (sr/2).  The last argument as zero
% means not to use the FFT approach.
tic; [D2,F2] = gammatonegram(d,sr,0.025,0.010,64,50,sr/2,0); toc
%Elapsed time is 3.165083 seconds.
subplot(212)
imagesc(20*log10(D2)); axis xy
caxis([-90 -30])
colorbar
set(gca,'YTickLabel',round(F(get(gca,'YTick'))));
ylabel('freq / Hz');
xlabel('time / 10 ms steps');
title('Gammatonegram - accurate method')
% Actual gammatone filters appear somewhat narrower.  The fast
% version assumes coherence of addition of amplitude from
% different channels, whereas the actual subband energies will
% depend on how the energy in different frequencies combines.
% Also notice the visible time smearing in the low frequency
% channels that does not occur in the fast version.