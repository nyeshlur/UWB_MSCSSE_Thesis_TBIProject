load ('DoD001_Ter001_RC1_Displacement_Normalized_3.mat');
 
bModeTemp = log10(mean(bMode,3));
figure(1);clf;
pcolor(xAxis,zAxis,bModeTemp);
axis ij;axis equal;axis tight;shading flat;
caxis(prctile(bModeTemp(:),[1,99]));
colormap(gray);
 
displacementTemp = reshape(displacement,prod(size(xAxis)),[]);
displacementTemp = displacementTemp - mean(displacementTemp);
[v,d] = eig(cov(displacementTemp));
[d,I] = sort(diag(d),1,'descend');
v = v(:,I);
 
ctLabelled = skullMaskThick;
ctLabelled(:,:,2) = bloodMaskThick;
ctLabelled(:,:,3) = ventMaskThick;
figure(2);clf;
H = pcolor(xAxis,zAxis,ctLabelled(:,:,1));
axis ij;axis equal;axis tight;shading flat;
H.CData = ctLabelled;
 
figure(3);clf;
for loop1 = 1:9
    subplot(3,3,loop1);
    plot(timeAxis,v(:,loop1));
    title(sprintf('PC %d (%0.1f%% variance)',loop1,d(loop1)/sum(d)*100));
end
 
figure(4);clf;
for loop1 = 1:9
    subplot(3,3,loop1);
    pcScore = displacementTemp*v(:,loop1);
    pcScore = reshape(pcScore,size(xAxis));
    pcolor(xAxis,zAxis,pcScore);
    axis ij;axis equal;axis tight;shading flat;
    caxis(prctile(pcScore(:),[1,99]));
    colormap(parula);
end