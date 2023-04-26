fileName = '/DATA/TBI/jesseDATA/DoD001/DoD001_Ter001_RC1_Displacement_Normalized_3.mat';
load(fileName);

%%

dnorm = reshape(displacementNorm, size(displacementNorm, 1), size(displacementNorm, 2), []);
% subset = displacementNorm(:, :, :, 1);

dTemp = reshape(dnorm,[],size(dnorm,3));
normaxis = linspace(1, size(dTemp, 2), size(dTemp, 2));

for loop1 = 1:10
    m = mean(dTemp);
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
m = m/sqrt(sum(m.^2));


figure(1);
subplot(121);
plot(normaxis, -m)  % -m to flip the plot across the x-axis
xticks(0:30:size(dTemp, 2));
grid on;
xlabel('frames');
ylabel('normalized displacement');
title('Representative Displacement');