clc; clear all; close all;
I = [1 2 3;4 5 6;7 8 9];
Ip1 = padarray(I,[2,2],'circular') % ͼ���Сͨ����ͼ�񿴳���һ����ά���ں�����һ��������������չ
Ip2 = padarray(I,[2,2],'replicate') % ��ʾͼ���Сͨ��������߽��е�ֵ����չ
Ip3 = padarray(I,[2,2],'symmetric') % ��ʾͼ���Сͨ��Χ�Ʊ߽���о���������չ