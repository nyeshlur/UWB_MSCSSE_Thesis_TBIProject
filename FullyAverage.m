fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001RA1.mat';
RA1_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001RA2.mat';
RA2_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001RA3.mat';
RA3_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001RA4.mat';
RA4_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001RA5.mat';
RA5_001 = load(fileName);




sum = RA1_001.single_cycle + RA2_001.single_cycle + RA3_001.single_cycle + RA4_001.single_cycle + RA5_001.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "DoD001RA";

fig = figure(1);
subplot(121);
plot(axis, sum)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + id_angle;
title(myTitle);
figName = id_angle + ".pdf";
saveas(fig, figName)

fName = id_angle + ".mat";
save(fName, "sum")