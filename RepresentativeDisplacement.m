fileName = '/DATA/TBI/jesseDATA/DoD001/DoD001_Ter001_RC1_Displacement_Normalized_3.mat';
load(fileName);

%%
% subset = displacement(:, :, 50:71);
subset = displacementNorm(:, :, :, 4);

% dTemp = reshape(displacement,[],size(displacement,3));
dTemp = reshape(subset,[],size(subset,3));
% timeAxissubset = timeAxis(:, 1:30);
normaxis = linspace(1, 30, 30);

for loop1 = 1:10
    m = mean(dTemp); % the mean of the elements of dTemp, m is a row vector containing the mean of each column
    flipWaveform = zeros(size(dTemp,1),1);
    for loop2 = 1:size(dTemp)
        cc = corrcoef(m,dTemp(loop2,:));
        if cc(1,2)<0
            dTemp(loop2,:) = -dTemp(loop2,:);
            flipWaveform(loop2) = 1;
        end
    end
    flipWaveform = sum(flipWaveform)/length(flipWaveform)*100;
    disp(sprintf('Iteration %d, Flipped %0.2f%% Waveforms',loop1,flipWaveform));
    if flipWaveform<0.1
        break;
    end
end
m = mean(dTemp);
m = m/sqrt(sum(m.^2)); % .^ is element-wise power


figure(1);
subplot(121);
% plot(timeAxis,m);
% plot(timeAxis,-m); % to flip the plot across the x-axis
% plot(timeAxissubset, m);
plot(normaxis, -m)
grid on;
xlabel('time (s)');
ylabel('normalized displacement');
title('Representative Displacement');

% fs = 1/mean(diff(timeAxis));
% F = fft(m(:).*hamming(length(m)),1024);
% freqAxis = (0:length(F)-1)/length(F)*fs;
% subplot(122);
% plot(freqAxis,abs(F));
% grid on;
% xlabel('freqquency (Hz)');
% ylabel('|F|');
% title('Representative Displacement FFT');

