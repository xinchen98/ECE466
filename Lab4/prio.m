clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[time_b, packetsize_b, buffersize_b_possion, buffersize_b_movie, ...
    dropPkt_possion, dropPkt_movie] = textread('ps_prio9.txt', '%f %f %f %f %f %f');

i = 2;
time_2 = zeros(1,20000,'double');
buffersize1 = zeros(1,20000, 'double');
buffersize2 = zeros(1,20000, 'double');
delay1 = zeros(1,20000, 'double');
delay2 = zeros(1,20000, 'double');
drop1 = zeros(1,20000, 'double');
drop2 = zeros(1,20000, 'double');

while i<=20000
    time_2(i) = time_2(i-1)+time_b(i);
    buffersize1(i) = buffersize_b_possion(i);
    buffersize2(i) = buffersize_b_movie(i);
    % the delay time is the same as the same as the backlog of the packet
    % as long as there is a backlog, then the packet can be sent after all
    % the packet arrives before has been sent
    delay1(i) = buffersize_b_possion(i-1);
    delay2(i) = buffersize_b_movie(i-1);
    drop1(i) = dropPkt_possion(i);
    drop2(i) = dropPkt_movie(i);
    i=i+1;
end


figure(1);
subplot(2,1,1);
plot(time_2, buffersize1, 'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
title('Backlog of Poisson3 Data');
xlabel('time');
ylabel('buffer size');

subplot(2,1,2);
plot(time_2, delay1, 'Color', [rand(1),rand(1),rand(1)], 'LineWidth', 1.2);
title('Delay of Poisson3 Data');
xlabel('time');
ylabel('Delay of Time');

figure(2);
plot(time_2, drop1)
title('Discarded Packet');
xlabel('time');
ylabel('number of discarded packets');

figure(3);
subplot(2,1,1);
plot(time_2, buffersize2, 'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
title('Backlog of Movie Data');
xlabel('time');
ylabel('buffer size');

subplot(2,1,2);
plot(time_2, delay2, 'Color', [rand(1),rand(1),rand(1)], 'LineWidth', 1.2);
title('Delay of Movie Data');
xlabel('time');
ylabel('Delay of Time');

figure(4);
plot(time_2, drop2)
title('Discarded Packet');
xlabel('time');
ylabel('number of discarded packets');
