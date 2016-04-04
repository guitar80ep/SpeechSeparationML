%[d,sr] = wavread(data(1,:));
d = signal1;
sr = 16000;
tic; [D,F] = gammatonegram(d,sr,.025,.01,64); toc
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