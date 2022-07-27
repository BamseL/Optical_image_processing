clc; clear all; close all;
I = [1 2 3;4 5 6;7 8 9];
Ip1 = padarray(I,[2,2],'circular') % 图像大小通过将图像看成是一个二维周期函数的一个周期来进行扩展
Ip2 = padarray(I,[2,2],'replicate') % 表示图像大小通过复制外边界中的值来扩展
Ip3 = padarray(I,[2,2],'symmetric') % 表示图像大小通过围绕边界进行镜像反射来扩展