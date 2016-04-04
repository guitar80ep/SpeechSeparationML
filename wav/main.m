data = [];
count = 0
for i = 1:500
    path = strcat('wav/arctic_a0', sprintf('%03d', i), '-sin.wav')
    sample = audioread(path);
    if length(sample) > 64000
       count= count + 1;
    end
end
count