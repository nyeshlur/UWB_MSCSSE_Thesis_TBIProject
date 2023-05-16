local_folder = "/Users/nayanayeshlur/Downloads/FullyAveragedData/";
local_folder_2 = "/Users/nayanayeshlur/Downloads/HealthyCondensed/";
id = "DoD313";
Healthy_add = id + "/" + id;

fileName = local_folder_2 + Healthy_add + "RC1.mat";
RC = load(fileName);

fileName = local_folder_2 + Healthy_add + "RA1.mat";
RA = load(fileName);

fileName = local_folder_2 + Healthy_add + "LC1.mat";
LC = load(fileName);

fileName = local_folder_2 + Healthy_add + "LA1.mat";
LA = load(fileName);


fileName = local_folder + "Healthy/HealthyRC.mat";
Healthy_RC = load(fileName);

fileName = local_folder + "Healthy/HealthyRA.mat";
Healthy_RA = load(fileName);

fileName = local_folder + "Healthy/HealthyLC.mat";
Healthy_LC = load(fileName);

fileName = local_folder + "Healthy/HealthyLA.mat";
Healthy_LA = load(fileName);

RC.single_cycle = RC.single_cycle;
RA.single_cycle = RA.single_cycle;
LC.single_cycle = LC.single_cycle;
LA.single_cycle = LA.single_cycle;

 
cc_RC = corrcoef(RC.single_cycle, -Healthy_RC.matrix_mean);
disp(cc_RC);

cc_RA = corrcoef(RA.single_cycle, -Healthy_RA.matrix_mean);
disp(cc_RA);

cc_LC = corrcoef(LC.single_cycle, -Healthy_LC.matrix_mean);
disp(cc_LC);

cc_LA = corrcoef(LA.single_cycle, -Healthy_LA.matrix_mean);
disp(cc_LA);

axis = linspace(1, 30, 30);

t = tiledlayout(4, 2);

nexttile
plot(axis, RC.single_cycle)
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
plot(axis, RA.single_cycle)
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
plot(axis, LC.single_cycle)
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
plot(axis, LA.single_cycle)
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