local_folder = "/Users/nayanayeshlur/Downloads/";
id = "DoD087";
scan_num = "_Ter002_";
angle = "RA2";
rest = "_Displacement_Normalized_3.mat";
fileName = local_folder + id + scan_num + angle + rest;
load(fileName);
dnorm = reshape(displacementNorm, size(displacementNorm, 1), size(displacementNorm, 2), []);
dTemp = reshape(dnorm,[],size(dnorm,3));
normaxis = linspace(1, size(dTemp, 2), size(dTemp, 2));
for loop1 = 1:10
    m = mean(dTemp); 
    flipWaveform = zeros(size(dTemp,1),1);
    for loop2 = 1:size(dTemp)
        cc = corrcoef(m,dTemp(loop2,:));
        if cc(1,2)<0
            dTemp(loop2,:) = -dTemp(loop2,:);
            flipWaveform(loop2) = 1;
        end
    end
    flipWaveform = sum(flipWaveform)/length(flipWaveform)*100;
    if flipWaveform<0.1
        break;
    end
end
m = mean(dTemp);
m = m;

fig = figure(1);
subplot(121);
plot(normaxis, m)
xticks(0:30:size(dTemp, 2));
grid on;
xlabel("frames");
ylabel("displacement");
title("Representative Displacement - " + id + angle);

% saveas(fig, id + "_" + angle + ".png")
% save(id + "_" + angle + ".mat", "m")