fileName = '/DATA/TBI/HealthyCondensed/DoD301/DoD301LA1.mat';
LA1_301 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD302/DoD302LA1.mat';
LA1_302 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD303/DoD303LA1.mat';
LA1_303 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD304/DoD304LA1.mat';
LA1_304 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD305/DoD305LA1.mat';
LA1_305 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD306/DoD306LA1.mat';
LA1_306 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD307/DoD307LA1.mat';
LA1_307 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD308/DoD308LA1.mat';
LA1_308 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD309/DoD309LA1.mat';
LA1_309 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD311/DoD311LA1.mat';
LA1_311 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD312/DoD312LA1.mat';
LA1_312 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD313/DoD313LA1.mat';
LA1_313 = load(fileName);


sum = LA1_301.single_cycle + LA1_302.single_cycle + LA1_303.single_cycle + LA1_304.single_cycle + LA1_305.single_cycle + LA1_306.single_cycle ...
+ LA1_307.single_cycle + LA1_308.single_cycle + LA1_309.single_cycle + LA1_311.single_cycle + LA1_312.single_cycle + LA1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

fig = figure(1);
subplot(121);
plot(axis, sum)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + "Healthy LA1";
title(myTitle);
figName = "HealthyLA1" + ".pdf";

saveas(fig, figName)

save("HealthyLA1.mat", "sum")