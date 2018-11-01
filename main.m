currentFolder = pwd;
imagesInFolder = strcat(pwd,'\image*.jpg');
imagesNames = dir(imagesInFolder);
imagesNames = {imagesNames.name};

destinationFolder = [pwd '\colorimages'];
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end

destinationFolder = [pwd '\ssd_colorimages'];
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end

destinationFolder = [pwd '\ncc_colorimages'];
if ~exist(destinationFolder, 'dir')
  mkdir(destinationFolder);
end

for i = 1:size(imagesNames,2)
    genvarname('image', num2str(i));
    eval(['image' num2str(i) '= imread(imagesNames{i});']);
    eval(['image' num2str(i) '= histeq(' 'image' num2str(i) ');']);
    eval(['image' num2str(i) '= ' 'image' num2str(i) '(1:1023, 1:size(' 'image' num2str(i) ',2));']);
    eval(['image' num2str(i) '= mat2cell(' 'image' num2str(i) ' ,[341 341 341]);']);
    eval(['image' num2str(i) '= cat(3, ' 'image' num2str(i) '{3,1}, ' 'image' num2str(i) '{2,1}, ' 'image' num2str(i) '{1,1});']);
    eval(['imwrite(' 'image' num2str(i) ', ''' pwd '\colorimages\' 'image' num2str(i) '-color.jpg'');'])
    eval(['im_align1(' 'image' num2str(i) ', ' num2str(i) ');'])
    eval(['im_align2(' 'image' num2str(i) ', ' num2str(i) ');'])
end
