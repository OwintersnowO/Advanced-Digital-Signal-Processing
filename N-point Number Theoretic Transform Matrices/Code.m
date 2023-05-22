%input parameter
N = 4;
M = 5;

%create look-up table
LUT = ones(M);
for i = 2:M
    for j = 2:M
        LUT(i,j) = mod((i-1)*(j-1),M);
    end
end

%find the smallest positive alpha
alpha = 0;
check = 0;
while check == 0
    check = 1;
    alpha = alpha+1;
    alphak = alpha;
    for i = 1:(N-1)
        if alphak == 1
            check = 0;
            break;
        end
        alphak = LUT(alphak+1,alpha+1);
    end
    if alphak ~= 1
        check = 0;
    end
end

%calculate A
A = ones(N);
for i = 2:N
    for j = 2:N
        nk = mod((i-1)*(j-1),N);
        for k = 1:nk
            A(i,j) = LUT(A(i,j)+1,alpha+1);
        end
    end
end

%calculate B
B = ones(N);
N_inv = 1;
while LUT(N+1,N_inv+1) ~= 1
    N_inv = N_inv+1;
end
for i = 1:N
    for j = 1:N
        nk = mod((i-1)*(j-1),N);
        alpha_inv = 1;
        while LUT(alpha+1,alpha_inv+1) ~= 1
            alpha_inv = alpha_inv+1;
        end
        for k = 1:nk
            B(i,j) = LUT(B(i,j)+1,alpha_inv+1);
        end
        B(i,j) = LUT(B(i,j)+1,N_inv+1);
    end
end