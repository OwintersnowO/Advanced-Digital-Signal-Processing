%settings
N = 17;
k = (N-1)/2;
fs = 6000;
fp1 = 0;
fp2 = 1200;
ft1 = 1200;
ft2 = 1500;
Wp = 1;
Ws = 0.6;
delta = 0.0001;

%normalization
Fs = 1;
Fp1 = fp1/fs;
Fp2 = fp2/fs;
Ft1 = ft1/fs;
Ft2 = ft2/fs;

Fe = [0.025 0.04 0.05 0.1 0.15 0.3 0.35 0.4 0.45 0.475];

matrix = ones(k+2);
Hd = zeros(k+2,1);
for i=1:k+2
    for j=2:k+1
        matrix(i,j) = cos(2*(j-1)*pi*Fe(i));
    end
    if Fe(i)<=Ft1
        matrix(i,k+2) = (-1)^(i-1)/Wp;
        Hd(i) = 1;
    else Fe(i)>=Ft2
        matrix(i,k+2) = (-1)^(i-1)/Ws;
    end
end
s = inv(matrix)*Hd;


