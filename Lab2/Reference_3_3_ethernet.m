clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[time_p, packetsize_p] = textread('BC-pAug89-small.TL', '%f %f');
[time_b, packetsize_b, buffersize_b, NoToken_b] = textread('bucket.txt', '%f %f %f %f');
[packetsize_r, time_r]=textread('output.txt','%f %f');

i = 1;
j = 2;
time_1 = zeros(1,10000,'double');
bytes_p = zeros(1,10000,'double');

while i<=10000
    time_1(i) = time_p(i);
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
bytes_b = zeros(1,10000,'double');
buffersize = zeros(1,10000, 'double');
tokenbucket = zeros(1,10000, 'double');

while ii<=10000
    time_2(ii) = time_2(ii-1)+time_b(ii);
    buffersize(ii) = buffersize_b(ii);
    tokenbucket(ii) = NoToken_b(ii);
    ii=ii+1;
end
bytes_b(1)=packetsize_b(1);
while jj<=10000
       bytes_b(jj)=bytes_b(jj-1)+packetsize_b(jj);
       jj=jj+1;
end


iii = 2;
jjj = 2;
time_3 = zeros(1,10000,'double');
bytes_r = zeros(1,10000,'double');
time_3(1) = 0;
while iii<=10000
    time_3(iii) = time_3(iii-1)+time_r(iii);
    iii=iii+1;
end
bytes_r(1) = packetsize_r(1);
while jjj<=10000
       bytes_r(jjj)=bytes_r(jjj-1)+packetsize_r(jjj);
       jjj=jjj+1;
end

figure(1);
subplot(3,1,1)
plot(time_1,bytes_p);
title('Trace File Traffic Evaluation');
xlabel('time')
ylabel('number of bytes');
subplot(3,1,2)
plot(time_2,bytes_b);
title('Bucket File Traffic Evaluation');
xlabel('time')
ylabel('number of bytes');
subplot(3,1,3)
plot(time_3,bytes_r);
title('Output File Traffic Evaluation');
xlabel('time')
ylabel('number of bytes')

figure(2);
subplot(2,1,1);
plot(time_2, tokenbucket);
title('Content of Token Bucket');
xlabel('time')
ylabel('size of token bucket');
subplot(2,1,2);
plot(time_2, buffersize);
title('Backlog in the Buffer');
xlabel('time')
ylabel('buffer size');
