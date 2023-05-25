function Concatenate_Cycles()
    folders = dir("/Users/nayanayeshlur/Downloads/New_TBI_Representative_Displacement_JustIPH/");
    cc = zeros(1, 30);
    for i = 1:length(folders)
        folder = folders(i).name;
        if folder ~= "." & folder ~= ".." & folder ~= ".DS_Store"
            fullName = strcat("/Users/nayanayeshlur/Downloads/New_TBI_Representative_Displacement_JustIPH/",folder);
            cc_vec = readFileswithinFolder(fullName);
            cc = [cc; cc_vec];
        end
    end
    cc(1, :) = [];
    save("Concatenated_TBI_JustIPH_LC.mat", "cc");
end

function cc = readFileswithinFolder(folderName)
    Files = dir(folderName);
    cc = zeros(1,30);
    for j=1:length(Files)
        FileNames = Files(j).name;
        [~, fName, fExt] = fileparts(FileNames);
        if fExt == ".mat" && contains(fName, "LC")
            FileNames = strcat(strcat(folderName,"/"),strcat(FileNames,"/"));
            disp(FileNames);
            load(FileNames, "m");
            numcycles = length(m) / 30;
            for k = 1:numcycles
                curr = m(1 + (k - 1) * 30: 30 + (k - 1) * 30);
                cc = [cc; curr];
            end
        end
    end
    cc(1, :) = [];
end