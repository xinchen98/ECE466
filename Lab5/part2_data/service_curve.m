clc;clear all;

x = linspace(0,1000);
y1 = 60 * x - 7200;
y2 = 40 * x - 4800;
y3 = 50 * x - 7200;
y4 = 55 * x - 7200;

figure(1)
plot(x,y1);
hold on
plot(x,y2);
hold on
plot(x,y3);
hold on
plot(x,y4);
hold off
title('Sequence Number vs Timestamp');
xlabel('time(ms)');
ylabel('Transmitted Data(bits)');
legend('60kbps','40kbps','50kbps','55kbps');

