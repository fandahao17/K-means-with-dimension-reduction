function [A,subjects, samples, labels] = prep_orl()
    subjects = 40;
    samples = 10;
    n = subjects * samples;
    
    labels = zeros(1, subjects * samples);
    
    pixels = prod([112 92]);
    
    A = zeros(subjects*samples, pixels);
    S_tmp = zeros(subjects,pixels); 
    for i = 1:subjects
        labels((i - 1) * samples + 1 : i * samples) = i;
        for j = 1:samples
            imageName=strcat('./orl_faces/s', int2str(i), '/', int2str(j), '.pgm');
            tmp = imread(imageName);
            tmp = reshape(tmp.', 1, pixels);
            A((i-1)*samples+j, :) = tmp;
            if j == 1
                S_tmp(i, :) = tmp;
            end
        end
    end
end

