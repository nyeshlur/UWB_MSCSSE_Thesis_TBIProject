fileName = '/DATA/TBI/HealthyCondensed/DoD301/DoD301RA1.mat';
RA1_301 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD302/DoD302RA1.mat';
RA1_302 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD303/DoD303RA1.mat';
RA1_303 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD304/DoD304RA1.mat';
RA1_304 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD305/DoD305RA1.mat';
RA1_305 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD306/DoD306RA1.mat';
RA1_306 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD307/DoD307RA1.mat';
RA1_307 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD308/DoD308RA1.mat';
RA1_308 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD309/DoD309RA1.mat';
RA1_309 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD311/DoD311RA1.mat';
RA1_311 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD312/DoD312RA1.mat';
RA1_312 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD313/DoD313RA1.mat';
RA1_313 = load(fileName);


sum = RA1_301.single_cycle + RA1_302.single_cycle + RA1_303.single_cycle + RA1_304.single_cycle + RA1_305.single_cycle + RA1_306.single_cycle ...
+ RA1_307.single_cycle + RA1_308.single_cycle + RA1_309.single_cycle + RA1_311.single_cycle + RA1_312.single_cycle + RA1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

fig = figure(1);
subplot(121);
plot(axis, sum)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + "Healthy RA1";
title(myTitle);
figName = "HealthyRA1" + ".pdf";

saveas(fig, figName)

save("HealthyRA1.mat", "sum")