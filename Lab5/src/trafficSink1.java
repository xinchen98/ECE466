
import java.io.*;
import java.net.*;
import java.util.Arrays;

public class trafficSink1 extends Thread{
	static private int sinkPort;
	static private int N;
	static private int L;
	static private int r;
	static private int NoFile;
	
	public trafficSink1 (int sinkPort, int N, int L, int r, int NoFile) {
		this.N = N;
		this.L = L;
		this.r = r;
		this.sinkPort = sinkPort;
		this.NoFile = NoFile;
		System.out.println(N +" packets " + L +" bytes " + r +" kbps");
	}
	
	public static int fromByteArray(byte [] value, int start, int length) {
		int Return = 0;
		for (int i = start; i < start+length; i++) {
			Return = (Return << 8) + (value[i] & 0xff);
		}
		return Return;
	}
	
	public void run() {
		PrintStream pout = null;
		int pkt_size;
		long sys_cur;
		long temp1;
		long temp2;
		long sys_init;
		
		try {

			DatagramSocket socket = new DatagramSocket(sinkPort);
			FileOutputStream fout =  new FileOutputStream("trafficSinkoutput" + NoFile+".txt");
			pout = new PrintStream (fout);
			
			while (true) {
				byte[] buf = new byte[L];
				DatagramPacket p = new DatagramPacket(buf, buf.length);
				
				socket.receive(p);
				sys_cur = System.nanoTime();
				
				pkt_size = p.getLength();
				
				int seqNo = fromByteArray(p.getData(), 2, 2);
				temp1 = (long)fromByteArray(p.getData(),4,4);
				temp2 = (long)fromByteArray(p.getData(),8,4);
				sys_init = temp1 * 1000000000 + temp2;
				
//				System.out.println(sys_init);
				if (seqNo == 1) {
					pout.println(seqNo + "\t" + pkt_size + "\t" + (sys_cur - sys_init)/1000);
				}
				else if (seqNo == 100) {
					pout.println(seqNo + "\t" + pkt_size + "\t" + (sys_cur - sys_init)/1000);
					NoFile ++;
					fout = new FileOutputStream("trafficSinkoutput" + NoFile + ".txt");
					pout = new PrintStream(fout);
				}
				else {
					pout.println(seqNo + "\t" + pkt_size + "\t" + (sys_cur - sys_init)/1000);
				}
			}
			
		}catch (IOException e) {  
			// catch io errors from FileInputStream or readLine()  
			System.out.println("IOException: " + e.getMessage());  
		} finally {
			pout.close();
		}
	}
}

