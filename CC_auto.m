function CC_auto()
    folders = dir("/DATA/TBI/TBI_RD/"); 
    for i = 1:length(folders)
        folder = folders(i).name;
        fullName = strcat("/DATA/TBI/TBI_RD/",folder);
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

   outputDir = "/DATA/TBI/TBICondensed/";
   newFolder = strcat(outputDir,strcat(patId,"/"));
   mkdir(newFolder)

   numcycles = length(m)/30;
   single_cycle = zeros(1, 30);

   for loop1 = 1:30
       for loop2 = 1:numcycles
           single_cycle(loop1) = single_cycle(loop1) + m((loop2 - 1) * 30 + loop1);
       end
   end

   single_cycle = single_cycle / numcycles;

   normaxis = linspace(1, length(m), length(m));
   axis = linspace(1, 30, 30);


   t = tiledlayout(2, 1);

   nexttile
   plot(normaxis, m)
   xticks(0:30:length(m));
   grid on;
   xlabel("frames");
   ylabel("displacement");
   myTitle = "Representative Displacement" + " " + fName;
   title(myTitle);

   nexttile
   plot(axis, single_cycle)
   xticks(0:1:30);
   grid on;
   xlabel("frames");
   ylabel("displacement");
   myTitle = "Averaged Displacement" + " " + fName;
   title(myTitle);
   
   figName = strcat(fName,".pdf");

   saveas(t, strcat(newFolder,figName))

   save(strcat(newFolder,strcat(fName,".mat")) , "m", "single_cycle")
end