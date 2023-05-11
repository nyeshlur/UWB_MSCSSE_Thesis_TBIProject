fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001LA1.mat';
LA1_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001LA2.mat';
LA2_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001LA3.mat';
LA3_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001LA4.mat';
LA4_001 = load(fileName);

fileName = '/DATA/TBI/TBICondensed/DoD001/DoD001LA5.mat';
LA5_001 = load(fileName);




sum = LA1_001.single_cycle + LA2_001.single_cycle + LA3_001.single_cycle + LA4_001.single_cycle + LA5_001.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "DoD001LA";

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