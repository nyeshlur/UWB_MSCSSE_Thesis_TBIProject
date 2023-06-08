% clear; clc;
load("/Users/nayanayeshlur/Downloads/Concatenated/Concatenated_Healthy_IPH_RA.mat");
healthy = load("/Users/nayanayeshlur/Downloads/Concatenated/Concatenated_Healthy_RA.mat");

disp("RA");


[nrows, ncols] = size(cc);

cov_i = cov(cc);

X = zeros([nrows,ncols]);

ss_i = zeros([1,ncols]);   % you could use this for the scree plot
ss_cu = zeros([1,ncols]);  % you could use this for the cumulative scree plot 


means = mean(cc);
vars = var(cc);
stdevs = std(cc);
minimum = min(cc);
maximum = max(cc);
STDEVM = stdevs;
for i = 1: ncols
    STDEVM(1,i) = STDEVM(1,i) / means(1,i);
end

% Mean center data
% This is necessary so that everything is mean centered at 0
% facilitates statistical and hypothesis analysis

for i=1:ncols
    for j=1:nrows
        X(j,i) = -(means(:,i) - cc(j,i));
    end
end


% Scale data 
% This is necessary so that all data has the same order, e.g.,  
% should not compare values in the thousands vs. values between 0 and 1 

for i=1:ncols
    for j=1:nrows
        X(j,i) = X(j,i) / stdevs(:,i);
    end
end


% svd
% X is the original dataset
% Ur will be the transformed dataset
% S is covariance matrix (not normalized)

[U, S, V] = svd(X,0); 


% Number of features to use, in this case its the columns
nfeatures = ncols;
f_to_use = nfeatures;
feature_vector = 1:f_to_use;

% r = Ur;  % make a copy of Ur to preserve it, we will randomize r

% Obtain the necessary information for Scree Plots 
% Obtain S^2 (and can also use to normalize S)   

S2 = S^2; 

weights2 = zeros(nfeatures,1); 

sumS2 = sum(sum(S2)); 

weightsum2 = 0; 

 
for i=1:nfeatures 
    weights2(i) = S2(i,i)/sumS2; 
    weightsum2 = weightsum2 + weights2(i); 
    weight_c2(i) = weightsum2; 
end 

Ur = U*S; % regular scores


% fig = figure; 
% plot(weights2,'x:b'); 
% grid; 
% title('Scree Plot'); 
% % saveas(fig, "ScreePlot.png")
% 
%  
% 
% fig = figure; 
% plot(weight_c2,'x:r'); 
% grid; 
% title('Scree Plot Cumulative'); 
% % saveas(fig, "ScreePlotCumulative.png")

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

for i=1:nfeatures 
    for j=1:nfeatures 
        Vsquare(i,j) = V(i,j)^2; 
        if V(i,j)<0 
            Vsquare(i,j) = Vsquare(i,j)*-1; 
        else  
            Vsquare(i,j) = Vsquare(i,j)*1; 
        end 
    end 
end 

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% for i=1:nfeatures 
%     fig = figure; 
%     bar(Vsquare(:,i),0.5); 
%     grid; 
%     ymin = min(Vsquare(:,i)) + (min(Vsquare(:,i))/10); 
%     ymax = max(Vsquare(:,i)) + (max(Vsquare(:,i))/10); 
%     axis([0 nfeatures ymin ymax]);
%     xticks(0:1:30);
%     xlabel('Feature index'); 
%     ylabel('Importance of feature'); 
%     [chart_title, ERRMSG] = sprintf('Loading Vector %d',i); 
%     title(chart_title); 
%     % saveas(fig, chart_title + ".png")
% end




% Loading_Vector_Average = abs(Vsquare);
% Loading_Vector_Average(:, 1) = Loading_Vector_Average(:, 1) * weight_c2(1);
% Loading_Vector_Average(:, 2) = Loading_Vector_Average(:, 2) * weight_c2(2);
% Loading_Vector_Average(:, 3) = Loading_Vector_Average(:, 3) * weight_c2(3);
% Loading_Vector_Average(:, 4) = Loading_Vector_Average(:, 1) * weight_c2(4);
% Loading_Vector_Average_Sum = sum(Loading_Vector_Average(:, 1:4), 2);
% 
% figure;
% bar(Loading_Vector_Average_Sum)
% xticks(0:1:30);
% xlabel('Feature index'); 
% ylabel('Importance of Feature');
% title("Sum of The First Four Original Loading Vectors")
% save("Healthy_LA.mat", "Loading_Vector_Average_Sum")




%%%%%%%%%%%%%%%%%%
%pc scatter
%%%%%%%%%%%%%%%%%%

% h_size = length(healthy.cc);
% size = length(cc);
% 
% figure; 
% hold on; 
% title('frame 3 vs frame 15 vs frame 28'); 
% 
% xlabel ("frame 3 "); 
% ylabel ("frame 15 ");
% zlabel ("frame 28 ");
% scatter3(X(1:h_size, 3), X(1:h_size, 15), X(1:h_size, 28), 'ro')
% scatter3(X((h_size + 1):size, 3), X((h_size + 1):size, 15), X((h_size + 1):size, 28), 'b.')


% h_size = length(healthy.cc);
% size = length(cc);
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC3'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC3 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 2), Ur(1:h_size, 3), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 3), 'b.')
% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 2), Ur(1:h_size, 4), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 4), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC4'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 3), Ur(1:h_size, 4), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 3), Ur((h_size + 1):size, 4), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC4'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC4 ");
% scatter3(Ur(1:h_size, 2), Ur(1:h_size, 3), Ur(1:h_size, 4), 'ro')
% scatter3(Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 3), Ur((h_size + 1):size, 4), 'b.')

% 
% figure; 
% hold on; 
% title('PC1 vs PC2 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC2 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 2), Ur(1:h_size, 5), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 5), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC3 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 3), Ur(1:h_size, 5), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 3), Ur((h_size + 1):size, 5), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC1 vs PC4 vs PC5'); 
% 
% xlabel ("PC1 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:h_size, 1), Ur(1:h_size, 4), Ur(1:h_size, 5), 'ro')
% scatter3(Ur((h_size + 1):size, 1), Ur((h_size + 1):size, 4), Ur((h_size + 1):size, 5), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC2 vs PC3 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC3 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:h_size, 2), Ur(1:h_size, 3), Ur(1:h_size, 5), 'ro')
% scatter3(Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 3), Ur((h_size + 1):size, 5), 'b.')
% 
% 
% figure; 
% hold on; 
% title('PC2 vs PC4 vs PC5'); 
% 
% xlabel ("PC2 "); 
% ylabel ("PC4 ");
% zlabel ("PC5 ");
% scatter3(Ur(1:h_size, 2), Ur(1:h_size, 4), Ur(1:h_size, 5), 'ro')
% scatter3(Ur((h_size + 1):size, 2), Ur((h_size + 1):size, 4), Ur((h_size + 1):size, 5), 'b.')
% 
% 
% % %%%%%%%%%%%%%%%%%


X = Ur(:, 3:4);
y = zeros([length(cc), 1]);
y(length(healthy.cc) + 1:length(cc)) = 1;

Everything = [X, y];

% Cross validation (train: 70%, test: 30%)
cv = cvpartition(size(Everything,1),'HoldOut',0.3);
idx = cv.test;

% Separate to training and test data
dataTrain = Everything(~idx,:);
dataTest  = Everything(idx,:);

SVMModel = fitcsvm(dataTrain(:, 1:width(X)),dataTrain(:, width(X) + 1))

sv = SVMModel.SupportVectors;
figure
gscatter(X(:,1),X(:,2),y)
hold on
plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
legend('healthy','iph','Support Vector')
hold off

% L = loss(SVMModel,dataTest(:, 1:width(X)),dataTest(:, width(X) + 1));
% disp("SVM Loss " + L);


% sv = SVMModel.SupportVectors; % Support vectors
% beta = SVMModel.Beta; % Linear predictor coefficients
% b = SVMModel.Bias; % Bias term
% 
% hold on
% gscatter(X(:,1),X(:,2),y)
% plot(sv(:,1),sv(:,2),'ko','MarkerSize',10)
% 
% X1 = linspace(min(X(:,1)),max(X(:,1)),100);
% X2 = -(beta(1)/beta(2)*X1)-b/beta(2);
% plot(X1,X2,'-')
% 
% m = 1/sqrt(beta(1)^2 + beta(2)^2);  % Margin half-width
% X1margin_low = X1+beta(1)*m^2;
% X2margin_low = X2+beta(2)*m^2;
% X1margin_high = X1-beta(1)*m^2;
% X2margin_high = X2-beta(2)*m^2;
% plot(X1margin_high,X2margin_high,'b--')
% plot(X1margin_low,X2margin_low,'r--')
% xlabel('X_1 (Sepal Length in cm)')
% ylabel('X_2 (Sepal Width in cm)')
% legend('setosa','virginica','Support Vector', ...
%     'Boundary Line','Upper Margin','Lower Margin')
% hold off
% 

