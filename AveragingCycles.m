fileName = '/Matlab_Data/DoD001/DoD001_RC1.mat';
load(fileName);

numcycles = length(m)/30;
single_cycle = zeros(1, 30);

for loop1 = 1:30
    for loop2 = 1:numcycles
        single_cycle(loop1) = single_cycle(loop1) + m((loop2 - 1) * 30 + loop1);
    end
end

single_cycle = single_cycle / numcycles;

% figure out how to calculate standard deviation

normaxis = linspace(1, length(m), length(m));
axis = linspace(1, 30, 30);

t = tiledlayout(2, 1);

nexttile
plot(normaxis, m)
xticks(0:30:length(m));
grid on;
xlabel('frames');
ylabel('displacement');
title('Representative Displacement 001 RC1');

nexttile
plot(axis, single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 066 RC1');

% save("001_RC1.mat", "m", "single_cycle")