local_folder = "/Users/nayanayeshlur/Downloads/FullyAveragedData/";
id = "DoD001";
TBI_add = id + "/" + id;

fileName = local_folder + TBI_add + "RC.mat";
RC = load(fileName);

fileName = local_folder + TBI_add + "RA.mat";
RA = load(fileName);

fileName = local_folder + TBI_add + "LC.mat";
LC = load(fileName);

fileName = local_folder + TBI_add + "LA.mat";
LA = load(fileName);


fileName = local_folder + "Healthy/HealthyRC.mat";
Healthy_RC = load(fileName);

fileName = local_folder + "Healthy/HealthyRA.mat";
Healthy_RA = load(fileName);

fileName = local_folder + "Healthy/HealthyLC.mat";
Healthy_LC = load(fileName);

fileName = local_folder + "Healthy/HealthyLA.mat";
Healthy_LA = load(fileName);

RC.matrix_mean = RC.matrix_mean;
RA.matrix_mean = RA.matrix_mean;
LC.matrix_mean = LC.matrix_mean;
LA.matrix_mean = LA.matrix_mean;

 
cc_RC = corrcoef(RC.matrix_mean, -Healthy_RC.matrix_mean);
disp(cc_RC);

cc_RA = corrcoef(RA.matrix_mean, -Healthy_RA.matrix_mean);
disp(cc_RA);

cc_LC = corrcoef(LC.matrix_mean, -Healthy_LC.matrix_mean);
disp(cc_LC);

cc_LA = corrcoef(LA.matrix_mean, -Healthy_LA.matrix_mean);
disp(cc_LA);

axis = linspace(1, 30, 30);

t = tiledlayout(4, 2);

nexttile
plot(axis, RC.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " RC");

nexttile
plot(axis, -Healthy_RC.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy RC");

nexttile
plot(axis, RA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " RA");

nexttile
plot(axis, -Healthy_RA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy RA");

nexttile
plot(axis, LC.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " LC");

nexttile
plot(axis, -Healthy_LC.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy LC");

nexttile
plot(axis, LA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " LA");

nexttile
plot(axis, -Healthy_LA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy LA");

save("CC_Healthy_" + id + ".mat", "cc_RC", "cc_RA", "cc_LC", "cc_LA");



