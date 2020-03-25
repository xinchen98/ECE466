clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[time_b, packetsize_b, buffersize_b_possion1, buffersize_b_possion2, ...
    buffersize_b_possion3, dropPkt_possion1, dropPkt_possion2,...
    dropPkt_possion3] = textread('ps_drr1.txt', '%f %f %f %f %f %f %f %f');

i = 2;
time_2 = zeros(1,40000,'double');
buffersize1 = zeros(1,40000, 'double');
buffersize2 = zeros(1,40000, 'double');
buffersize3 = zeros(1,40000, 'double');
delay1 = zeros(1,40000, 'double');
delay2 = zeros(1,40000, 'double');
delay3 = zeros(1,40000, 'double');
drop1 = zeros(1,40000, 'double');
drop2 = zeros(1,40000, 'double');
drop3 = zeros(1,40000, 'double');


while i<=40000
    time_2(i) = time_2(i-1)+time_b(i);
    buffersize1(i) = buffersize_b_possion1(i);
    buffersize2(i) = buffersize_b_possion2(i);
    %buffersize3(i) = buffersize_b_possion3(i);
    % the delay time is the same as the same as the backlog of the packet
    % as long as there is a backlog, then the packet can be sent after all
    % the packet arrives before has been sent
    delay1(i) = buffersize_b_possion1(i-1);
    delay2(i) = buffersize_b_possion2(i-1);
    %delay3(i) = buffersize_b_possion3(i-1);
    drop1(i) = dropPkt_possion1(i);
    drop2(i) = dropPkt_possion2(i);
    %drop3(i) = dropPkt_possion3(i);
    i=i+1;
end

j = 1;
while j <= 40000
    buffersize3(j) = buffersize_b_possion3(j+40000);
    delay3(j) = buffersize_b_possion3(j+40000);
    drop3(j) = dropPkt_possion3(j+40000);
    j = j + 1;
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
title('Backlog of Poisson3 Data');
xlabel('time');
ylabel('buffer size');

subplot(2,1,2);
plot(time_2, delay2, 'Color', [rand(1),rand(1),rand(1)], 'LineWidth', 1.2);
title('Delay of Poisson3 Data');
xlabel('time');
ylabel('Delay of Time');

figure(4);
plot(time_2, drop2)
title('Discarded Packet');
xlabel('time');
ylabel('number of discarded packets');

figure(5);
subplot(2,1,1);
plot(time_2, buffersize3, 'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
title('Backlog of Poisson3 Data');
xlabel('time');
ylabel('buffer size');

subplot(2,1,2);
plot(time_2, delay3, 'Color', [rand(1),rand(1),rand(1)], 'LineWidth', 1.2);
title('Delay of Poisson3 Data');
xlabel('time');
ylabel('Delay of Time');

figure(6);
plot(time_2, drop3)
title('Discarded Packet');
xlabel('time');
ylabel('number of discarded packets');
