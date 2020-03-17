clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[packet_no_p, time_p, packetsize_p] = textread('trafficGeneratorOutput_2.txt', '%f %f %f');
[time_b, packetsize_b, buffersize_b, NoToken_b] = textread('bucket_2.txt', '%f %f %f %f');
[packet_no_r, time_r, packetsize_r]=textread('trafficSinkoutput_2.txt','%f %f %f');

i = 2;
j = 2;
time_1 = zeros(1,30000,'double');
bytes_p = zeros(1,30000,'double');

time(1) = 0;
while i<=30000
    time_1(i) = time_1(i-1)+time_p(i);
    i=i+1;
end
bytes_p(1)=packetsize_p(1);
while j<=30000
       bytes_p(j)=bytes_p(j-1)+packetsize_p(j);
       j=j+1;
end

ii = 2;
jj = 2;
time_2 = zeros(1,30000,'double');
bytes_b = zeros(1,30000,'double');
buffersize = zeros(1,30000, 'double');
tokenbucket = zeros(1,30000, 'double');

while ii<=30000
    time_2(ii) = time_2(ii-1)+time_b(ii);
    buffersize(ii) = buffersize_b(ii);
    tokenbucket(ii) = NoToken_b(ii);
    ii=ii+1;
end
bytes_b(1)=packetsize_b(1);
while jj<=30000
       bytes_b(jj)=bytes_b(jj-1)+packetsize_b(jj);
       jj=jj+1;
end


iii = 2;
jjj = 2;
time_3 = zeros(1,30000,'double');
bytes_r = zeros(1,30000,'double');
time_3(1) = 0;
while iii<=30000
    time_3(iii) = time_3(iii-1)+time_r(iii);
    iii=iii+1;
end
bytes_r(1) = packetsize_r(1);
while jjj<=30000
       bytes_r(jjj)=bytes_r(jjj-1)+packetsize_r(jjj);
       jjj=jjj+1;
end

figure(1);
plot(time_1,bytes_p,'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
hold on
plot(time_2,bytes_b,'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
hold on
plot(time_3,bytes_r,'Color',[rand(1),rand(1),rand(1)], 'LineWidth',1.2);
hold off
legend('generator','bucket','sink');
title('Traffic Evaluation');
xlabel('time')
ylabel('number of bytes')

figure(2);
plot(time_2, tokenbucket, 'Color',[rand(1),rand(1),rand(1)]);
hold on
plot(time_2, buffersize, 'Color',[rand(1),rand(1),rand(1)]);
hold off
legend('tokenbucket','buffersize');
title('Backlog and Token Bucket');
xlabel('time')
ylabel('buffer size');
