function RD_auto()
    folders = dir("/DATA/TBI/HealthyData/"); 
    for i = 1:length(folders)
        folder = folders(i).name ;
        fullName = strcat("/DATA/TBI/HealthyData/",folder);
        readFileswithinFolder(fullName);
    end
end 

function readFileswithinFolder(folderName)
    Files = dir(folderName);
    for j=1:length(Files)
        FileNames=Files(j).name;
        [~, fName, fExt] = fileparts(FileNames);
        if fExt == ".mat"
            newStr = split(fName,'_');
            if length(newStr) >= 3
                outputName =strcat(newStr(1), newStr(3));
                FileNames = strcat(strcat(folderName,"/"),strcat(FileNames,"/"));
                myfun(FileNames, outputName,newStr(1));
            end
        end
    end
end



function myfun(fileName, outputName, patId)
   load(fileName);

   outputDir = "/DATA/TBI/NayanaOutput/HealthyOutput/";
   newFolder = strcat(outputDir,strcat(patId,"/"));
   mkdir(newFolder)
   
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

   fig = figure(1);
   subplot(121);
   plot(normaxis, m)
   xticks(0:30:size(dTemp, 2));
   grid on;
   xlabel('frames');
   ylabel('displacement');
   myTitle =strcat( 'Representative Displacement - ', outputName);
   title(myTitle);
   figName = strcat(outputName,".pdf");
   
   saveas(fig, strcat(newFolder,figName))

   numcycles = size(dTemp, 2)/30;

   max_displacement = zeros(2, numcycles);
   min_displacement = zeros(2, numcycles);

   for loop3 = 1:numcycles
       [maxval, maxidx] = max(m(loop3 * 30 - 29:loop3 * 30));
       max_displacement(1, loop3) = maxval;
       max_displacement(2, loop3) = maxidx;

       [minval, minidx] = min(m(loop3 * 30 - 29:loop3 * 30));
       min_displacement(1, loop3) = minval;
       min_displacement(2, loop3) = minidx;
   end

   save(strcat(newFolder,strcat(outputName,".mat")) , "m", "max_displacement", "min_displacement")
end