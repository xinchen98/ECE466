

import java.io.*;
import java.net.*;
import java.util.StringTokenizer;
import java.util.Arrays;

public class trafficGenerator extends Thread{
	static private InetAddress addr;
	static private int sendPort;
	static private int N;
	static private int L;
	static private int r;
	static private int sinkPort;
	
	public trafficGenerator (InetAddress addr, int sendPort, int sinkPort, int N, int L, int r) {
		this.addr = addr;
		this.sendPort = sendPort;
		this.N = N;
		this.L = L;
		this.r = r;
		this.sinkPort = sinkPort;
		System.out.println(N +" packets " + L +" bytes " + r +" kbps");
	}
	
	// Produces a byte array of with 4 bytes
	public static byte[] toByteArray(int m) {
		byte[] Result = new byte[4];
		Result[3] = (byte) ((m >>> (8*0)) & 0xFF);
		Result[2] = (byte) ((m >>> (8*1)) & 0xFF);
		Result[1] = (byte) ((m >>> (8*2)) & 0xFF);
		Result[0] = (byte) ((m >>> (8*3)) & 0xFF);
		return Result;
	}
	public void run() {
		PrintStream pout = null;
		long sys_pre = 0;
		long sys_cur = 0;
		long sys_init = 0;
		// wait_time is compute in us
		double rate = (double)(L*8)/(r*1000);
		long wait_time = (long) (rate * 1000000);
		
		try {  
				DatagramSocket socket = new DatagramSocket();
				FileOutputStream fout =  new FileOutputStream("trafficGenerator1.txt");
				pout = new PrintStream (fout);
				
				sys_init = System.nanoTime();
				
				for (int i = 1; i <= N; i++) {
					
					byte[] buf = new byte [400];
					// put returnPort in first 2 bytes of buffer
					System.arraycopy(toByteArray(sinkPort),2,buf,0,2);
					
					sys_cur = System.nanoTime();
					
					// put the sequence number in the 4th position of buffer
					System.arraycopy(toByteArray(i),2,buf,2,2);
					System.arraycopy(toByteArray((int)(sys_init / 1000000000)), 0, buf, 4, 4);
					System.arraycopy(toByteArray((int)(sys_init % 1000000000)),0,buf,8,4);
					
					DatagramPacket packet = new DatagramPacket(buf, L, addr, sendPort);
					if (i == 1) {
						socket.send(packet);
						// normalized to the send timestamp of the first probe packet, set to zero
						pout.println(i + "\t" + buf.length + "\t" + 0);
					}
					else {						
						while ((sys_cur - sys_pre)/1000 < wait_time) {
							sys_cur = System.nanoTime();
						}
						socket.send(packet);
						pout.println(i + "\t" + buf.length + "\t" + (sys_cur - sys_init)/1000);
					}
					sys_pre = sys_cur;
				}
				

				
		} catch (IOException e) {  
			// catch io errors from FileInputStream or readLine()  
			System.out.println("IOException: " + e.getMessage());  
		} 
	} 
	
}


