fileName = '/DATA/TBI/HealthyCondensed/DoD301/DoD301RC1.mat';
RC1_301 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD302/DoD302RC1.mat';
RC1_302 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD303/DoD303RC1.mat';
RC1_303 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD304/DoD304RC1.mat';
RC1_304 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD305/DoD305RC1.mat';
RC1_305 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD306/DoD306RC1.mat';
RC1_306 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD307/DoD307RC1.mat';
RC1_307 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD308/DoD308RC1.mat';
RC1_308 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD309/DoD309RC1.mat';
RC1_309 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD311/DoD311RC1.mat';
RC1_311 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD312/DoD312RC1.mat';
RC1_312 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD313/DoD313RC1.mat';
RC1_313 = load(fileName);



sum = RC1_301.single_cycle + RC1_302.single_cycle + RC1_303.single_cycle + RC1_304.single_cycle ...
+ RC1_305.single_cycle + RC1_306.single_cycle + RC1_307.single_cycle + RC1_308.single_cycle + RC1_309.single_cycle ...
+ RC1_311.single_cycle + RC1_312.single_cycle + RC1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "Healthy RC";

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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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



sum = RA1_301.single_cycle + RA1_302.single_cycle + RA1_303.single_cycle + RA1_304.single_cycle ...
+ RA1_305.single_cycle + RA1_306.single_cycle + RA1_307.single_cycle + RA1_308.single_cycle + RA1_309.single_cycle ...
+ RA1_311.single_cycle + RA1_312.single_cycle + RA1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "Healthy RA";

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



%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


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



sum = LA1_301.single_cycle + LA1_302.single_cycle + LA1_303.single_cycle + LA1_304.single_cycle ...
+ LA1_305.single_cycle + LA1_306.single_cycle + LA1_307.single_cycle + LA1_308.single_cycle + LA1_309.single_cycle ...
+ LA1_311.single_cycle + LA1_312.single_cycle + LA1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "Healthy LA";

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


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fileName = '/DATA/TBI/HealthyCondensed/DoD301/DoD301LC1.mat';
LC1_301 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD302/DoD302LC1.mat';
LC1_302 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD303/DoD303LC1.mat';
LC1_303 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD304/DoD304LC1.mat';
LC1_304 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD305/DoD305LC1.mat';
LC1_305 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD306/DoD306LC1.mat';
LC1_306 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD307/DoD307LC1.mat';
LC1_307 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD308/DoD308LC1.mat';
LC1_308 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD309/DoD309LC1.mat';
LC1_309 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD311/DoD311LC1.mat';
LC1_311 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD312/DoD312LC1.mat';
LC1_312 = load(fileName);

fileName = '/DATA/TBI/HealthyCondensed/DoD313/DoD313LC1.mat';
LC1_313 = load(fileName);


sum = LC1_301.single_cycle + LC1_302.single_cycle + LC1_303.single_cycle + LC1_304.single_cycle ...
+ LC1_305.single_cycle + LC1_306.single_cycle + LC1_307.single_cycle + LC1_308.single_cycle + LC1_309.single_cycle ...
+ LC1_311.single_cycle + LC1_312.single_cycle + LC1_313.single_cycle;

sum = sum / 10;

axis = linspace(1, 30, 30);

id_angle = "Healthy LC";

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