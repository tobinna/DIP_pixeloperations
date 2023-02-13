close
clear all


%QUESTION 1
pic = imread("kodim07.png");

figure
imshow(pic)
title('True colour image')

figure
I = rgb2gray(pic);
imshow(I)
title('Grey colour image with rgb2gray')

lightpic = I + 128;
figure
imshow(lightpic)
title('Lightened grey image by 128')

darkpic = I - 128;
figure
imshow(darkpic)
title('Darkened grey image by 128')


pic = imread("tennis.png");
I = [1 2 3;4 5 6;7 8 9];
p = [-1 0.2;0.3 0.5];
g = conv2(I, p, 'same')





%QUESTION 2
pic = imread("tennis.png");
I = rgb2ycbcr(pic);



figure
histogram(pic(:,:,1),[0:255]);
title('Histogram of R components')



figure
imshow(pic)
histogram(I(:,:,2),[0:255]);
title('Histogram of YCbY G components')

figure
histogram(I(:,:,1),[0:255]);
title('Histogram of Y components')

figure
imshow(pic)
histogram(I(:,:,3),[0:255]);
title('Histogram of YCbY B components')



% QUESTION 3
pic = imread("tennis.png");

r1 = 50;
r2 = 90;
g1 = 108;
g2 = 180;
b1 = 150;
b2 = 190;


rmask = pic(:,:,1);

rmask(rmask < r1) = 0;
rmask(rmask < r2 & rmask > r1) = 1;
rmask(rmask > r2) = 0;

gmask = pic(:,:,2);

gmask(gmask < g1) = 0;
gmask(gmask < g2 & gmask > g1) = 1;
gmask(gmask > g2) = 0;

bmask = pic(:,:,3);

bmask(bmask < b1) = 0;
bmask(bmask < b2 & bmask > b1) = 1;
bmask(bmask > b2) = 0;

size_mat = (gmask & bmask & rmask);

figure;imshow(pic)

newpic = bsxfun(@times, pic, cast(size_mat, class(pic)));
figure; imshow(newpic);


% QUESTION 4
A = imread("kodim23a.png");
figure
imshow(A)
title("og")

B = imread("kodim23b.png");
figure
imshow(B)
title("corrupted")

[AN, Aedges] = histcounts(A(:,:,3), [0:255]); 
Acumul = cumsum(AN);

[BN, Bedges] = histcounts(B(:,:,3), [0:255]); 
Bcumul = cumsum(BN);

figure

plot(0:254, Acumul, 0:254, Bcumul)
title("Cumulative sum of R values of A and B")

u = xline(150)
A150 = Acumul(150);
B150 = Bcumul(150);
text(150, 45000, '\leftarrow A=288173, B=254099')
legend({'A', 'B'})

Bnew = B;
Bnew(:,:,3) = 1/(255/270.98)*B(:,:,3);
Bnew(:,:,2) = 1/(255/228.44).*B(:,:,2);
Bnew(:,:,1) = 1/(255/224.848).*B(:,:,1);
[BNew, Bnewedges] = histcounts(Bnew(:,:,3), [0:255]);

figure
Bnewcumul = cumsum(BNew);
plot(1:255, Acumul, 1:255, Bcumul, 1:255, Bnewcumul)
title("Cumulative sum of B values of A,B and B with Colour Balancing")


figure
imshow(Bnew)
title("Colour Balanced Photo form White Point Estimation")

