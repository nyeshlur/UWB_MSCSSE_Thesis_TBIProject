function Condense()
    folders = dir("/Users/nayanayeshlur/Downloads/New_TBI_Representative_Displacement/"); 
    for i = 1:length(folders)
        folder = folders(i).name;
        fullName = strcat("/Users/nayanayeshlur/Downloads/New_TBI_Representative_Displacement/",folder);
        readFileswithinFolder(fullName);
    end
end 

function readFileswithinFolder(folderName)
    Files = dir(folderName);
    for j=1:length(Files)
        FileNames = Files(j).name;
        [~, fName, fExt] = fileparts(FileNames);
        if fExt == ".mat"
            FileNames = strcat(strcat(folderName,"/"),strcat(FileNames,"/"));
            subject_id = fName(1:6);
            condenseCycles(FileNames, fName, subject_id);
        end
    end
end


function condenseCycles(fileName, fName, patId)
   load(fileName, "m");

   outputDir = "/Users/nayanayeshlur/Downloads/New_TBI_Representative_Displacement_Condensed_STDEV/";
   newFolder = strcat(outputDir,strcat(patId,"/"));
   mkdir(newFolder);
   mylen = length(m);
   copy = zeros(1,mylen);
   copy = m;
   numcycles = length(m)/30;
   single_cycle = zeros(1, 30);
   stdev = zeros(1,30);

   for loop1 = 1:30
       temp = zeros(1, numcycles); 
       for loop2 = 1:numcycles
           single_cycle(loop1) = single_cycle(loop1) + m((loop2 - 1) * 30 + loop1);
           temp(loop2) = m((loop2 - 1) * 30 + loop1);
           if(loop2 == numcycles)
              stdev(loop1) = std(temp);
              copy = [copy std(temp)];
              end
       end
   end

   single_cycle = single_cycle / numcycles;
   normaxis = linspace(1, length(m), length(m));
   axis = linspace(1, 30, 30);
   
   newfName = split(fName, "_");
   
   t = tiledlayout(2, 1);

   nexttile
   plot(normaxis, m);
   xticks(0:30:length(m));
   grid on;
   xlabel("frames");
   ylabel("displacement");
   myTitle = "Representative Displacement" + " " + newfName(1) + newfName(2);
   title(myTitle);

   nexttile
   errorbar(axis, single_cycle, stdev)
   xticks(0:1:30);
   grid on;
   xlabel("frames");
   ylabel("displacement");
   myTitle = "Averaged Displacement" + " " + newfName(1) + newfName(2);
   title(myTitle);
   
   figName = strcat(fName,".png");

   saveas(t, strcat(newFolder,figName))

   save(strcat(newFolder,strcat(fName,".mat")) , "m", "single_cycle")


end