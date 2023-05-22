%input parameter
k = 10;

%settings
N = 2*k+1;
index_f = [0:0.0001:0.9999];
index_t = [0:N-1];
R = zeros(1,10000);
i = sqrt(-1);

%step 1: sampling
H_d = [0,-0.9*i,repelem([-i],k-2),-0.7*i,0.7*i,repelem([i],k-2),0.9*i];

%step 2: IDFT
R_1 = ifft(H_d);

%step 3&4: compute r[n](n=-k~k), compute h[n](n=0~N-1)
H = fftshift(R_1);

%calculate R(F)
for x=1:10000
    for y=1:N
        R(x) = R(x)+(H(y)*exp(-i*2*pi*index_f(x)*(y-k-1)));
    end
end

%show results
plot(index_f,imag(R));
%stem(index_t,H)