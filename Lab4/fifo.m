clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[time_b, packetsize_b, buffersize_b, dropPkt] = textread('ps_fifo9.txt', '%f %f %f %f');

i = 2;
time_2 = zeros(1,20000,'double');
buffersize = zeros(1,20000, 'double');
delay = zeros(1,20000, 'double');
drop = zeros(1,20000, 'double');

while i<=20000
    time_2(i) = time_2(i-1)+time_b(i);
    buffersize(i) = buffersize_b(i);
    % the delay time is the same as the same as the backlog of the packet
    % as long as there is a backlog, then the packet can be sent after all
    % the packet arrives before has been sent
    delay(i) = buffersize_b(i-1);
    drop(i) = dropPkt(i);
    i=i+1;
end


figure(1);
subplot(2,1,1);
plot(time_2, buffersize, 'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
title('Backlog of Poisson3 Data');
xlabel('time');
ylabel('buffer size');

subplot(2,1,2);
plot(time_2, delay, 'Color', [rand(1),rand(1),rand(1)], 'LineWidth', 1.2);
title('Delay of Poisson3 Data');
xlabel('time');
ylabel('Delay of Time');

figure(2);
plot(time_2, drop)
title('Discarded Packet');
xlabel('time');
ylabel('number of discarded packets');
