clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[packetNo_g, packetsize_g, time_g] = textread('trafficGenerator3.txt', '%f %f %f');
[packetNo_s, packetsize_s, time_s] = textread('trafficSinkoutput3.txt', '%f %f %f');

i = 1;
time_1 = zeros(1,100,'double');
sequence_1 = zeros(1, 100, 'double');
time_2 = zeros(1,100,'double');
sequence_2 = zeros(1, 100, 'double');

while i<=100
    time_1(i) = time_g(i);
    sequence_1(i) = packetNo_g(i);
    time_2(i) = time_s(i);
    sequence_2(i) = packetNo_s(i);
    i=i+1;
end


figure(1);
plot(sequence_1, time_1, 'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
hold on
plot(sequence_2, time_2,'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
hold off
title('Sequence Number vs Timestamp');
xlabel('sequence number (unit)');
ylabel('time(us)');
legend('generator','sink')

