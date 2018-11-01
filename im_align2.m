function[] = im_align2(image, n)
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    
    mR = mean2(R);
    mG = mean2(G);
    mB = mean2(B);
    
    Rm = R - mR;
    Gm = G - mG;
    Bm = B - mB;

    G_c = normxcorr2(Bm,Gm);

    [G_ypeak, G_xpeak] = find(G_c==max(G_c(:)));

    G_yoffSet = G_ypeak-size(Gm,1);
    G_xoffSet = G_xpeak-size(Gm,2);

    Gs = circshift(G, (G_yoffSet*G_xoffSet));

    R_c = normxcorr2(Gm,Rm);

    [R_ypeak, R_xpeak] = find(R_c==max(R_c(:)));

    R_yoffSet = R_ypeak-size(Rm,1);
    R_xoffSet = R_xpeak-size(Rm,2);
    
    Rs = circshift(R, (R_yoffSet*R_xoffSet));
    Rs = circshift(Rs, (G_yoffSet*G_xoffSet));

    catImage = cat(3, Rs, Gs, B);
    fprintf('The alignment images%d of Red Channel is circularly shifted by : %d pixel using NCC.\n', n,((G_yoffSet*G_xoffSet)+(R_yoffSet*R_xoffSet)));
    fprintf('The alignment images%d of Green Channel is circularly shifted by : %d pixel using NCC.\n', n,(G_yoffSet*G_xoffSet));
    eval(['imwrite(' 'catImage' ', ''' pwd '\ncc_colorimages\' 'image' num2str(n) '-ncc.jpg'');']);
end