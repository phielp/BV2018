%% LoG
x = 2;
y = 3;
t = 0;

result = (1 / (2*pi*t)) * exp(-(x^2 + y^2) / 2*t);
result

%%

filter = fspecial('log',[3 3],0.5);
filtered_img=imfilter(image,filter,'conv'); 
imshow(filtered_img);

%%
demo_mosaic(4);

%%
% load images
f1 = rgb2gray(imread('nachtwacht1.jpg'));
f2 = rgb2gray(imread('nachtwacht2.jpg'));

% get descriptors and features
[frame1, desc1] = vl_sift(single(f1));
[frame2, desc2] = vl_sift(single(f2));

% find matches
matches = vl_ubcmatch(desc1, desc2);
    
% get the coordinates
m1 = matches(1,:);
m1coords = frame1(:,m1);
m1coords = m1coords(1:2,:);
m2 = matches(2,:);
m2coords = frame2(:,m2);
m2coords = m2coords(1:2,:);

% plot
figure('name','Matches');
subplot(1,2,1);
imshow(f1);
for i = 1:length(m1coords)
    text(m1coords(1, i), m1coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht1.jpg');

subplot(1,2,2);
imshow(f2);
for i = 1:length(m2coords)
    text(m2coords(1, i), m2coords(2,i), sprintf('%02d',i), 'Color', 'green');
end
title('nachtwacht2.jpg');