clc;clear all;
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Reading data from a file
%Note that time is in micro seconds and packetsize is in Bytes
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
[packet_no_p, time_p, packetsize_p] = textread('poisson1.data', '%f %f %f');

%%%%%%%%%%%%%%%%%%%%%%%%%Exercise 1.2%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%The following code will generate Plot 1; You generate Plot2 , Plot3.
%Hint1: For Plot2 and Plot3, you only need to change 'initial_p', the
%       initial time in microseconds, and 'ag_time', the time period of
%       aggregation
%Hint2: After adding Plot2 and Plot3 to this part, you can use 'subplot(3,1,2);'
%       and 'subplot(3,1,3);' respectively to show 3 plots in the same figure.

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
figure(1);
disp(sum(packetsize_p));
jj=1;
i=1;
initial_p_1=0;
ag_time=1000000;
bytes_p_1=zeros(1,100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%should ignore the beginning of time value that is less than 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while time_p(jj)<=initial_p_1
    jj=jj+1;
end
while i<=100
    while ((time_p(jj)-initial_p_1)<=ag_time*i && jj<length(packetsize_p))
        bytes_p_1(i)=bytes_p_1(i)+packetsize_p(jj);
        jj=jj+1;
    end
i=i+1;
end

jj=1;
i=1;
initial_p_2=30000000;
ag_time=100000;
bytes_p_2=zeros(1,100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%should ignore the beginning of time value that is less than 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while time_p(jj)<=initial_p_2
    jj=jj+1;
end
while i<=100
    while ((time_p(jj)-initial_p_2)<=ag_time*i && jj<length(packetsize_p))
        bytes_p_2(i)=bytes_p_2(i)+packetsize_p(jj);
        jj=jj+1;
    end
i=i+1;
end

jj=1;
i=1;
initial_p_3=50000000;
ag_time=10000;
bytes_p_3=zeros(1,100);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%should ignore the beginning of time value that is less than 0
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
while time_p(jj)<=initial_p_3
    jj=jj+1;
end
while i<=100
    while ((time_p(jj)-initial_p_3)<=ag_time*i && jj<length(packetsize_p))
        bytes_p_3(i)=bytes_p_3(i)+packetsize_p(jj);
        jj=jj+1;
    end
i=i+1;
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%use to calculate the variance of arrival time
count = 2;
variance = [];
while count <= 125000
    sum=time_p(count)-time_p(count-1);
    variance=[variance sum];
    count = count + 1;
end
disp(var(variance))
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

%%%%%%%%
subplot(3,1,1);bar(bytes_p_1);
title('Poisson Traffic Arrivals Plot Data 1');
xlabel('time')
ylabel('number of bytes')
subplot(3,1,2);bar(bytes_p_2);
title('Poisson Traffic Arrivals Plot Data 2');
xlabel('time')
ylabel('number of bytes')
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',xt/100)
subplot(3,1,3);bar(bytes_p_3);
title('Poisson Traffic Arrivals Plot Data 3');
xlabel('time')
ylabel('number of bytes')
xt = get(gca, 'XTick');
set(gca, 'XTick',xt, 'XTickLabel',xt/1000)

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%Note: Run the same MATLAB code for Exercise 1.3 and 1.4 but change the
%second line of the code in order to read the files 'poisson2.data' and
%'poisson3.data' respectively.
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

