clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[packet_no_p, time_p, packetsize_p] = textread('trafficGeneratorOutput.txt', '%f %f %f');
[packet_no_r, time_r, packetsize_r]=textread('trafficSinkoutput.txt','%f %f %f');

i = 2;
j = 2;
time_1 = zeros(1,10000,'double');
bytes_p = zeros(1,10000,'double');

time_1(1) = 0;
while i<=10000
    time_1(i) = time_1(i-1) + time_p(i);
    i=i+1;
end
bytes_p(1)=packetsize_p(1);
while j<=10000
       bytes_p(j)=bytes_p(j-1)+packetsize_p(j);
       j=j+1;
end

ii = 2;
jj = 2;
time_2 = zeros(1,10000,'double');
bytes_r = zeros(1,10000,'double');
time_2(1) = 0;
while ii<=10000
    time_2(ii) = time_2(ii-1) + time_r(ii);
    ii=ii+1;
end
bytes_r(1) = packetsize_r(1);
while jj<=10000
       bytes_r(jj)=bytes_r(jj-1)+packetsize_r(jj);
       jj=jj+1;
end

figure(1);
subplot(2,1,1)
plot(time_1,bytes_p);
title('Traffic Generator Traffic Evaluation');
xlabel('time')
ylabel('number of bytes');
subplot(2,1,2)
plot(time_2,bytes_r);
title('Trafic Sink Traffic Evaluation');
xlabel('time')
ylabel('number of bytes')