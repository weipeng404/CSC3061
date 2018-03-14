% Task 2 creating a script
clear all
close all

a = 1;
b = 2;
c = a+b;
d = cos(a);
sin(a)
myText = 'Hello, world';

% Task 3 creating a function
c = mySum(a,b);

% Task 4 creating arrays and matrices
v = [1 2 3 4];
m = [1 2 3; 4 5 6; 7 8 10];
v2 = [1; 2; 3; 4; 5];
z = zeros(5,1);
m2 = rand(3,2);

% Task 5 matrix indexing and dynamic size
v(1,2)
element = v2(3,1);
m(3,1) = 10;
m(3,3) = m(3,3) + 1;
% m(5,5)
m(1:3,2)
m(3,:)
m(3,4)=1;
m(5,5)=2;
a(2,1) = 2;
a(3,1) = 3;
M = [m, m];
[rows, columns] = size(M);
M2 = [m; m];

% Task 6 matrix operations
ma = ones(3,3);
ma = ma + 10;
mb = ones(3,3)*3;
mc = mb + ma;
ma * mc
ma .* mc
mat = ma';
ima = inv(ma);

% Task 7 loops and conditions
searchingZeros([0 1 0 2 0; 3 4 5 6 7]);
addOneWithFors([0 1 0 2 0; 3 4 5 6 7]);
addOne([0 1 0 2 0; 3 4 5 6 7]);
A = rand(10000,10000);
tic
A = addOneWithFors(A); % 9.458913 seconds
toc
tic
A = addOne(A); % 1.061489 seconds
toc

% Task 8 help
help size;
lookfor input;

% Task 9 plotting and visualing
x = 0:pi/100:2*pi; 
y = sin(x); 
plot(x,y,'r--');
xlabel('x');
ylabel('sin(x)');
title('Plot of the Sine Function');

y2 = cos(x);
hold on 
plot(x,y2,'g.');
legend('sin','cos');

figure(2);
subplot(2,1,1);
plot(x,y2,'g.');
title('Sin');
subplot(2,1,2);
plot(x,y,'r--');
title('Cos');

points = rand(10,2);
x = points(:,1);
y = points(:,2);
plot(x, y, 'o');
xlabel('x');
ylabel('y');

hold on
line([x(1) x(2)],[y(1) y(2)]);
line([x(1) x(3)],[y(1) y(3)]);
line([x(2) x(3)],[y(2) y(3)]);

point3d = rand(10,3);
plot3(point3d(:,1), point3d(:,2), point3d(:,3));

% Task 10 dealing with images
I = imread('lena.jpeg');
figure(1); image(I);
figure(2); imagesc(I);
figure(3); imshow(I);

% I = double(I);  Q1: transform the image matrix to double???
I2 = I + 50;
figure(1); image(I2);
I3 = I - 50;
figure(2); image(I3);

imwrite(I2,'IncresedLena.jpg','JPEG');

R = I(:,:,1);
figure(1); image(R);
figure(2); imagesc(R);
figure(3); imshow(R);
% Q2: the difference between these 3 ways?

figure, imagesc(R), colormap(gray)

figure(1), imagesc(R), colormap(gray(128)), title('quantization: 128 levels (7 bpp)');
figure(2), imagesc(R), colormap(gray(64)), title('quantization: 64 levels (6 bpp)');
figure(3), imagesc(R), colormap(gray(16)), title('quantization: 16 levels (4 bpp)');
figure(4), imagesc(R), colormap(gray(4)), title('quantization: 4 levels (2 bpp)');

% imwrite(R,'filename_gray.jpg','JPEG');