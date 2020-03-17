import java.io.*;
import java.net.*;
import java.util.Arrays;

public class trafficSink {
	public static void main(String[] args) throws IOException {
		PrintStream pout = null;
		DatagramSocket socket = new DatagramSocket(4444);
		long sys_current_time;
		long sys_previous_time = System.nanoTime();
		long time_diff;
		int pkt_size;
		try {
			/*
			 * Open file for output 
			 */
			FileOutputStream fout =  new FileOutputStream("TrafficSinkOutput_N9.txt");
			pout = new PrintStream (fout);
			
			while (true) {
				byte[] buf = new byte[1500];
				DatagramPacket p = new DatagramPacket(buf, buf.length);
				socket.receive(p);
				sys_current_time = System.nanoTime();
				time_diff = sys_current_time - sys_previous_time;
				sys_previous_time = sys_current_time;
				pkt_size = p.getLength();
				/*
				 *  Write line to output file 
				 */
				pout.println(pkt_size + "\t" + time_diff/1000); 
				
				
			}
		}finally {
			pout.close();
		}
	}
}
