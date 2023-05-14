local_folder = "/DATA/TBI/TBICondensed/DoD001/DoD001";

fileName = local_folder + "LA1.mat";
LA1_001 = load(fileName);

fileName = local_folder + "LA2.mat";
LA2_001 = load(fileName);

fileName = local_folder + "LA3.mat";
LA3_001 = load(fileName);

fileName = local_folder + "LA4.mat";
LA4_001 = load(fileName);

fileName = local_folder + "LA5.mat";
LA5_001 = load(fileName);

matrix = [LA1_001.single_cycle; LA2_001.single_cycle; LA3_001.single_cycle; LA4_001.single_cycle; LA5_001.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = "DoD001LA";

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
RA1_001 = load(fileName);

fileName = local_folder + "RA2.mat";
RA2_001 = load(fileName);

fileName = local_folder + "RA3.mat";
RA3_001 = load(fileName);

fileName = local_folder + "RA4.mat";
RA4_001 = load(fileName);

fileName = local_folder + "RA5.mat";
RA5_001 = load(fileName);

matrix = [RA1_001.single_cycle; RA2_001.single_cycle; RA3_001.single_cycle; RA4_001.single_cycle; RA5_001.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = "DoD001RA";

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
LC1_001 = load(fileName);

fileName = local_folder + "LC2.mat";
LC2_001 = load(fileName);

fileName = local_folder + "LC3.mat";
LC3_001 = load(fileName);

fileName = local_folder + "LC4.mat";
LC4_001 = load(fileName);

fileName = local_folder + "LC5.mat";
LC5_001 = load(fileName);

matrix = [LC1_001.single_cycle; LC2_001.single_cycle; LC3_001.single_cycle; LC4_001.single_cycle; LC5_001.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = "DoD001LC";

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
RC1_001 = load(fileName);

fileName = local_folder + "RC2.mat";
RC2_001 = load(fileName);

fileName = local_folder + "RC3.mat";
RC3_001 = load(fileName);

fileName = local_folder + "RC4.mat";
RC4_001 = load(fileName);

fileName = local_folder + "RC5.mat";
RC5_001 = load(fileName);

matrix = [RC1_001.single_cycle; RC2_001.single_cycle; RC3_001.single_cycle; RC4_001.single_cycle; RC5_001.single_cycle];

matrix_mean = mean(matrix);

axis = linspace(1, 30, 30);

id_angle = "DoD001RC";

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