local_folder = "/DATA/TBI/TBICondensed/DoD009/DoD009";
id = "DoD009";

fileName = local_folder + "LA1.mat";
LA1 = load(fileName);

fileName = local_folder + "LA2.mat";
LA2 = load(fileName);

fileName = local_folder + "LA3.mat";
LA3 = load(fileName);

fileName = local_folder + "LA4.mat";
LA4 = load(fileName);

fileName = local_folder + "LA5.mat";
LA5 = load(fileName);

matrix = [LA1.single_cycle; LA2.single_cycle; LA3.single_cycle; LA4.single_cycle; LA5.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = id + "LA";

fig = figure(1);
subplot(121);
plot(axis, matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + id_angle;
title(myTitle);
figName = id_angle + ".pdf";
saveas(fig, figName)

fName = id_angle + ".mat";
save(fName, "matrix_mean")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fileName = local_folder + "RA1.mat";
RA1 = load(fileName);

fileName = local_folder + "RA2.mat";
RA2 = load(fileName);

fileName = local_folder + "RA3.mat";
RA3 = load(fileName);

fileName = local_folder + "RA4.mat";
RA4 = load(fileName);

fileName = local_folder + "RA5.mat";
RA5 = load(fileName);

matrix = [RA1.single_cycle; RA2.single_cycle; RA3.single_cycle; RA4.single_cycle; RA5.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = id + "RA";

fig = figure(1);
subplot(121);
plot(axis, matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + id_angle;
title(myTitle);
figName = id_angle + ".pdf";
saveas(fig, figName)

fName = id_angle + ".mat";
save(fName, "matrix_mean")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%


fileName = local_folder + "LC1.mat";
LC1 = load(fileName);

fileName = local_folder + "LC2.mat";
LC2 = load(fileName);

fileName = local_folder + "LC3.mat";
LC3 = load(fileName);

fileName = local_folder + "LC4.mat";
LC4 = load(fileName);

fileName = local_folder + "LC5.mat";
LC5 = load(fileName);

matrix = [LC1.single_cycle; LC2.single_cycle; LC3.single_cycle; LC4.single_cycle; LC5.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = id + "LC";

fig = figure(1);
subplot(121);
plot(axis, matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + id_angle;
title(myTitle);
figName = id_angle + ".pdf";
saveas(fig, figName)

fName = id_angle + ".mat";
save(fName, "matrix_mean")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

fileName = local_folder + "RC1.mat";
RC1 = load(fileName);

fileName = local_folder + "RC2.mat";
RC2 = load(fileName);

fileName = local_folder + "RC3.mat";
RC3 = load(fileName);

fileName = local_folder + "RC4.mat";
RC4 = load(fileName);

fileName = local_folder + "RC5.mat";
RC5 = load(fileName);

matrix = [RC1.single_cycle; RC2.single_cycle; RC3.single_cycle; RC4.single_cycle; RC5.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = id + "RC";

fig = figure(1);
subplot(121);
plot(axis, matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
myTitle = "Averaged Displacement - " + id_angle;
title(myTitle);
figName = id_angle + ".pdf";
saveas(fig, figName)

fName = id_angle + ".mat";
save(fName, "matrix_mean")