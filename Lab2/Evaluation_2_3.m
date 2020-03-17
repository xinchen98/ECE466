clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[packet_no_p, time_p, packetsize_p] = textread('poisson3.data', '%f %f %f');
[packetsize_r, time_r]=textread('output.txt','%f %f');

i = 1;
j = 2;
time_1 = zeros(1,20000,'double');
bytes_p = zeros(1,20000,'double');

while i<=20000
    time_1(i) = time_p(i);
    i=i+1;
end
bytes_p(1)=packetsize_p(1);
while j<=20000
       bytes_p(j)=bytes_p(j-1)+packetsize_p(j);
       j=j+1;
end

ii = 2;
jj = 2;
time_2 = zeros(1,20000,'double');
bytes_r = zeros(1,20000,'double');
time_2(1) = 0;
while ii<=20000
    time_2(ii) = time_2(ii-1)+time_r(ii);
    ii=ii+1;
end
bytes_r(1) = packetsize_r(1);
while jj<=20000
       bytes_r(jj)=bytes_r(jj-1)+packetsize_r(jj);
       jj=jj+1;
end

figure(1);
subplot(2,1,1)
plot(time_1,bytes_p);
title('Trace File Traffic Evaluation');
xlabel('time')
ylabel('number of bytes');
subplot(2,1,2)
plot(time_2,bytes_r);
title('Output File Traffic Evaluation');
xlabel('time')
ylabel('number of bytes')