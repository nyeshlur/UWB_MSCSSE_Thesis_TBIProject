myVars = ["m", "single_cycle"];

fileName = 'DoD001/001_RC1.mat';
RC1_001 = load(fileName, myVars{:});

fileName = 'DoD009/009_RC1.mat';
RC1_009 = load(fileName, myVars{:});

fileName = 'DoD014/014_RC1.mat';
RC1_014 = load(fileName, myVars{:});

fileName = 'DoD033/033_RC1.mat';
RC1_033 = load(fileName, myVars{:});

fileName = 'DoD048/048_RC1.mat';
RC1_048 = load(fileName, myVars{:});

fileName = 'DoD066/066_RC1.mat';
RC1_066 = load(fileName, myVars{:});

sum = RC1_001.single_cycle + RC1_009.single_cycle + RC1_014.single_cycle + RC1_033.single_cycle + RC1_048.single_cycle + RC1_066.single_cycle;

sum = sum / 6;

 
cc001 = corrcoef(RC1_001.single_cycle, sum);
cc009 = corrcoef(RC1_009.single_cycle, sum);
cc014 = corrcoef(RC1_014.single_cycle, sum);
cc033 = corrcoef(RC1_033.single_cycle, sum);
cc048 = corrcoef(RC1_048.single_cycle, sum);
cc066 = corrcoef(RC1_066.single_cycle, sum);


axis = linspace(1, 30, 30);

t = tiledlayout(2, 4);

nexttile
plot(axis, RC1_001.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 001 RC1');

nexttile
plot(axis, RC1_009.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 009 RC1');

nexttile
plot(axis, RC1_014.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 014 RC1');

nexttile
plot(axis, RC1_033.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 033 RC1');

nexttile
plot(axis, RC1_048.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 048 RC1');

nexttile
plot(axis, RC1_066.single_cycle)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement 066 RC1');

nexttile
plot(axis, sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement RC1');

