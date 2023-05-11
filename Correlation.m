fileName = 'FullyAveragedData/DoD001RC.mat';
RC_001 = load(fileName);

fileName = 'FullyAveragedData/DoD001RA.mat';
RA_001 = load(fileName);

fileName = 'FullyAveragedData/DoD001LC.mat';
LC_001 = load(fileName);

fileName = 'FullyAveragedData/DoD001LA.mat';
LA_001 = load(fileName);


fileName = 'FullyAveragedData/HealthyRC1.mat';
Healthy_RC = load(fileName);

fileName = 'FullyAveragedData/HealthyRA1.mat';
Healthy_RA = load(fileName);

fileName = 'FullyAveragedData/HealthyLC1.mat';
Healthy_LC = load(fileName);

fileName = 'FullyAveragedData/HealthyLA1.mat';
Healthy_LA = load(fileName);

 
cc_h_001_RC = corrcoef(RC_001.sum, Healthy_RC.sum);
disp(cc_h_001_RC);
cc_h_001_RA = corrcoef(RA_001.sum, Healthy_RA.sum);
disp(cc_h_001_RA);
cc_h_001_LC = corrcoef(LC_001.sum, Healthy_LC.sum);
disp(cc_h_001_LC);
cc_h_001_LA = corrcoef(LA_001.sum, Healthy_LA.sum);
disp(cc_h_001_LA);


axis = linspace(1, 30, 30);

t = tiledlayout(4, 2);

nexttile
plot(axis, RC_001.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement DoD001 RC');

nexttile
plot(axis, Healthy_RC.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement Healthy RC');

nexttile
plot(axis, RA_001.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement DoD001 RA');

nexttile
plot(axis, Healthy_RA.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement Healthy RA');

nexttile
plot(axis, LC_001.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement DoD001 LC');

nexttile
plot(axis, Healthy_LC.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement Healthy LC');

nexttile
plot(axis, LA_001.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement DoD001 LA');

nexttile
plot(axis, Healthy_LA.sum)
xticks(0:1:30);
grid on;
xlabel('frames');
ylabel('displacement');
title('Averaged Displacement Healthy LA');

