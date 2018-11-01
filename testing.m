full=image3(:,:,1);
template=image3(:,:,3);
S_full = size(full);
S_temp = size(template);

X=normxcorr2(template, full);
m=max(X(:));
[i,j]=find(X==m);

figure, colormap gray
subplot(2,2,1), title('full'), imagesc(full)
subplot(2,2,2), title('template'), imagesc(template), 
subplot(2,2,3), imagesc(X), rectangle('Position', [j-20 i-20 40 40])

R = zeros(S_temp);
shift_a = [0 0];
shift_b = [i j] - S_temp;
R((1:S_full(1))+shift_a(1), (1:S_full(2))+shift_a(2)) = full;
R((1:S_temp(1))+shift_b(1), (1:S_temp(2))+shift_b(2)) = template;
subplot(2,2,4), imagesc(R);