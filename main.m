data = zeros(433, 64000);
sample_rates = zeros(433);
count = 1
for i = 1:500
    path = strcat('wav/arctic_a0', sprintf('%03d', i), '-sin.wav');
    [sample, sr] = wavread(path);
    if length(sample) >= 64000
       sample = sample';
       data(count,:) = sample(1:64000);
       sample_rates(count) = sr;
       count = count + 1;
    end
end
count