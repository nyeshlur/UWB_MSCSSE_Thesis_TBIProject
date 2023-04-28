fileName = '/DATA/TBI/jesseDATA/DoD050/DoD050_Ter001_RC1_Displacement_Normalized_3.mat';
load(fileName);

%%

dnorm = reshape(displacementNorm, size(displacementNorm, 1), size(displacementNorm, 2), []);

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

inverted_m = -m;

figure(1);
subplot(121);
plot(normaxis, inverted_m)
xticks(0:30:size(dTemp, 2));
grid on;
xlabel('frames');
ylabel('displacement');
title('Representative Displacement');


numcycles = size(dTemp, 2)/30;

max_displacement = zeros(2, numcycles);
min_displacement = zeros(2, numcycles);

for loop3 = 1:numcycles
    [maxval, maxidx] = max(inverted_m(loop3 * 30 - 29:loop3 * 30));
    max_displacement(1, loop3) = maxval;
    max_displacement(2, loop3) = maxidx;

    [minval, minidx] = min(inverted_m(loop3 * 30 - 29:loop3 * 30));
    min_displacement(1, loop3) = minval;
    min_displacement(2, loop3) = minidx;
end


% save("DoD001_RC1.mat", "inverted_m", "max_displacement", "min_displacement")