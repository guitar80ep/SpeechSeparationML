
'loading data'
load data;
samples = 20;
mixtures = zeros(samples,128,400);
masks = zeros(samples,128,400);

signal1 = data(1,:) * pow2(15);
r1 = gammatoneFast(signal1);
coch1 = cochleagram(r1);

'generating samples'
for x = 2:samples+1
    signalx = data(x,:) * pow2(15);
    rx = gammatoneFast(signalx);
    cochx = cochleagram(rx);
    mixtures(x-1,:,:) = coch1 + cochx;
    masks(x-1,:,:) = coch1 > cochx;
    x
end

'creating models'
models = cell(128,400);
for row = 1:128
    for col = 1:400
        x = mixtures(:,row,col);
        y = masks(:,row,col);
        models{row,col} = fitcsvm(x,y);
    end
    row
end

'creating test cochleagram'
signal_test = data(30,:) * pow2(15);
r_test = gammatoneFast(signal_test);
coch_test = cochleagram(r_test);

mixture_test = coch_test + coch1;

'creating mask'
generated_mask = zeros(128,400);
for row = 1:128
    for col = 1:400
        model = models{row,col};
        generated_mask(row,col) = predict(model, mixture_test);
    end
    row
end

'creating output'
output = synthesisFast(mixture, generated_mask);