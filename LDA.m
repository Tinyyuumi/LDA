clear all;close all;clc;
x=[0.665,0.09;0.242,0.266;0.244,0.056;0.342,0.098;0.638,0.16;0.656,0.197;0.359,0.369;0.592,0.041;0.718,0.102;
    0.696,0.459;0.773,0.375;0.633,0.263;0.607,0.317;0.555,0.214;0.402,0.236;0.48,0.148;0.436,0.21;0.557,0.216];
y=[1,1,1,1,1,1,1,1,1,0,0,0,0,0,0,0,0,0];

[a,num] = size(y);

%% 画出图形点
subplot(2,1,1);
for i=1:num
    if y(i)==1
        plot(x(i,1),x(i,2),'ro');
        hold on;
    end
    if y(i)==0
        plot(x(i,1),x(i,2),'bo');
        hold on;
    end
end

%% 求均值向量
u1 = [mean(x(1:9,1)),mean(x(1:9,2))];
u2 = [mean(x(10:18,1)),mean(x(10:18,2))];


%% 求类内散度矩阵 和 类间散度矩阵
Sw = zeros(2);
for i = 1:num
    if y(i)==1
        Sw = Sw + (x(i,:)- u1)'*(x(i,:)- u1);
    end
    if y(i)==0
        Sw = Sw + (x(i,:)- u2)'*(x(i,:)- u2);
    end
end

Sb = (u1-u2)'*(u1-u2);

%% 求斜率
w =(Sw^-1)*(u1-u2)';
k=w(2)/w(1);

%% 画出直线
t = linspace(0,0.5,1000);
yy = k*t;
plot(t,yy);

%% 画投影点
for i=1:num
    x11 = (k*x(i,2)+x(i,1))/(k^2+1);
    x22 = k*(k*x(i,2)+x(i,1))/(k^2+1);
    n1 = linspace(x(i,1),x11,10);
    n2 = linspace(x(i,2),x22,10);
    if y(i)==1
        plot(x11,x22,'rx');
        plot(n1,n2,'r--');
        hold on;
    end
    if y(i)==0
        plot(x11,x22,'bx');
        plot(n1,n2,'b--');
        hold on;
    end
end
axis equal;
axis([0,1,0,0.7]);
title('x2-x1平面上的点投影图');
hold on;

%% 数据降维后的值
subplot(2,1,2);
Y = w'*x';
for i=1:num
    if y(i)==1
        plot(Y(1,i),0,'ro');
        hold on;
    end
    if y(i)==0
        plot(Y(1,i),0,'b*');
        hold on;
    end
end  
title('样本降维后的图');
ax = gca;
ax.XAxisLocation = 'origin';
axis([-0.5,0,-0.05,0.05]);
