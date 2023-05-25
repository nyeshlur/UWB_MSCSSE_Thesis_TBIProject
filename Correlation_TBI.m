local_folder = "/Users/nayanayeshlur/Downloads/New_Healthy_FullyAveraged/";
local_folder_2 = "/Users/nayanayeshlur/Downloads/New_TBI_FullyAveraged/";
id = "DoD103";
Healthy_add = id + "/" + id;

% fileName = local_folder_2 + Healthy_add + "RC.mat";
% RC = load(fileName);

fileName = local_folder_2 + Healthy_add + "RA.mat";
RA = load(fileName);

% fileName = local_folder_2 + Healthy_add + "LC.mat";
% LC = load(fileName);

fileName = local_folder_2 + Healthy_add + "LA.mat";
LA = load(fileName);


% fileName = local_folder + "HealthyRC.mat";
% Healthy_RC = load(fileName);

fileName = local_folder + "HealthyRA.mat";
Healthy_RA = load(fileName);

% fileName = local_folder + "HealthyLC.mat";
% Healthy_LC = load(fileName);

fileName = local_folder + "HealthyLA.mat";
Healthy_LA = load(fileName);

 
% cc_RC = corrcoef(RC.matrix_mean, Healthy_RC.matrix_mean);
% disp(cc_RC);

cc_RA = corrcoef(RA.matrix_mean, Healthy_RA.matrix_mean);
disp(cc_RA);

% cc_LC = corrcoef(LC.matrix_mean, Healthy_LC.matrix_mean);
% disp(cc_LC);

cc_LA = corrcoef(LA.matrix_mean, Healthy_LA.matrix_mean);
disp(cc_LA);

axis = linspace(1, 30, 30);

t = tiledlayout(4, 2);

% nexttile
% plot(axis, RC.matrix_mean)
% xticks(0:1:30);
% grid on;
% xlabel("frames");
% ylabel("displacement");
% title("Averaged Displacement " + id + " RC");
% 
% nexttile
% plot(axis, Healthy_RC.matrix_mean)
% xticks(0:1:30);
% grid on;
% xlabel("frames");
% ylabel("displacement");
% title("Averaged Displacement Healthy RC");

nexttile
plot(axis, RA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " RA");

nexttile
plot(axis, Healthy_RA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy RA");

% nexttile
% plot(axis, LC.matrix_mean)
% xticks(0:1:30);
% grid on;
% xlabel("frames");
% ylabel("displacement");
% title("Averaged Displacement " + id + " LC");
% 
% nexttile
% plot(axis, Healthy_LC.matrix_mean)
% xticks(0:1:30);
% grid on;
% xlabel("frames");
% ylabel("displacement");
% title("Averaged Displacement Healthy LC");

nexttile
plot(axis, LA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement " + id + " LA");

nexttile
plot(axis, Healthy_LA.matrix_mean)
xticks(0:1:30);
grid on;
xlabel("frames");
ylabel("displacement");
title("Averaged Displacement Healthy LA");

% save("CC_Healthy_" + id + ".mat", "cc_RC", "cc_RA", "cc_LC", "cc_LA");
save("CC_Healthy_" + id + ".mat", "cc_RA", "cc_LA");

