function[] = im_align1(image, n)
    R = image(:,:,1);
    G = image(:,:,2);
    B = image(:,:,3);
    
    mR = mean2(R);
    mG = mean2(G);
    mB = mean2(B);
    
    Rm = R - mR;
    Gm = G - mG;
    Bm = B - mB;

    mincs_G = 0;
    minssd_G = immse(Bm, Gm) * numel(Bm);
    mincs_R = 0;
    minssd_R = immse(Bm, Rm) * numel(Bm);
    for j = 1:(size(Bm,1)*size(Bm,2))
        ssd_G = immse(Bm, circshift(Gm,j)) * numel(Bm);
        ssd_R = immse(Bm, circshift(Rm,j)) * numel(Bm);
        if minssd_G > ssd_G
            mincs_G = j;
            minssd_G = ssd_G;
        end
        if minssd_R > ssd_R
            mincs_R = j;
            minssd_R = ssd_R;
        end
    end
    
    fprintf('The alignment images%d of Red Channel is circularly shifted by : %d pixel using SSD.\n', n, mincs_R);
    fprintf('The alignment images%d of Green Channel is circularly shifted by : %d pixel using SSD.\n', n, mincs_G);
    
    finalImage = cat(3, circshift(R,mincs_R), circshift(G,mincs_G), B);
    eval(['imwrite(' 'finalImage' ', ''' pwd '\ssd_colorimages\' 'image' num2str(n) '-ssd.jpg'');']);
end


