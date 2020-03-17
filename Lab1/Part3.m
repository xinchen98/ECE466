clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading the data and putting the first 100000 entries in variables 
%Note that time is in seconds and framesize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
no_entries=100000;
[time1, framesize1] = textread('BC-pAug89.TL', '%f %f');
time=time1(1:no_entries);
framesize=framesize1(1:no_entries);
%%%%%%%%%%%%%%%%%%%%%%%%%Exercise %%%3.2%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following code will generate Plot 1; You generate Plot2 , Plot3.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
jj=1;
i=1;
initial_p_1=0;
ag_time=1;
bytes_p_1=zeros(1,100);
while time(jj)<=initial_p_1
    jj=jj+1;
end
while i<=100
while ((time(jj)-initial_p_1)<=ag_time*i && jj<no_entries)
bytes_p_1(i)=bytes_p_1(i)+framesize(jj);
jj=jj+1;
end
i=i+1;
end
%%%%%%%%
subplot(3,1,1);bar(bytes_p_1);
title('Ethernet Traffic 1');
xlabel('time')
ylabel('number of bytes')

jj=1;
i=1;
initial_p_2=20;
ag_time=0.1;
bytes_p_2=zeros(1,100);
while time(jj)<=initial_p_2
    jj=jj+1;
end
while i<=100
while ((time(jj)-initial_p_2)<=ag_time*i && jj<no_entries)
bytes_p_2(i)=bytes_p_2(i)+framesize(jj);
jj=jj+1;
end
i=i+1;
end

subplot(3,1,2);bar(bytes_p_2);
title('Ethernet Traffic 2');
xlabel('time')
ylabel('number of bytes')
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',20+xt/100)

jj=1;
i=1;
initial_p_3=90;
ag_time=0.01;
bytes_p_3=zeros(1,100);
while time(jj)<=initial_p_3
    jj=jj+1;
end
while i<=100
while ((time(jj)-initial_p_3)<=ag_time*i && jj<no_entries)
bytes_p_3(i)=bytes_p_3(i)+framesize(jj);
jj=jj+1;
end
i=i+1;
end
subplot(3,1,3);bar(bytes_p_3);
title('Ethernet Traffic 3');
xlabel('time')
ylabel('number of bytes')
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',90+xt/1000)

%figure(2);
%hist(framesize1,100);
%title('Distribution of packet sizes');
%xlabel('frame size')
%ylabel('relative frequency')

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%calculate the peak bit rate
%count = 2;
%max = 0;
%while count < 1000000
%    sum = framesize1(count)*8/(time1(count)-time1(count-1));
%    if max < sum
%       max = sum
%    end
%    count = count + 1;
%end
%disp(max)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%