
import java.io.*;
import java.net.*;
import java.util.StringTokenizer;
import java.util.Arrays;

public class TrafficEstimator {
	public static void main(String[] args) throws IOException {
		InetAddress addr = InetAddress.getByName(args[0]);
		int sendPort = 4444;
		int sinkPort = 4445;
		
		int N = Integer.parseInt(args[1]);
		int L = Integer.parseInt(args[2]);
		int r = Integer.parseInt(args[3]);
		//wait around 2ms then call the traffic generator
		long wait_time = 2;
		new trafficSink(sinkPort, N, L, r).start();
		
		long sys_pre = System.nanoTime();
		long sys_cur = System.nanoTime();
		
		while ((sys_cur - sys_pre) < wait_time*1000000) {
			sys_cur = System.nanoTime();
		}
		new trafficGenerator(addr, sendPort, sinkPort, N, L, r).start();
		
	}
}
