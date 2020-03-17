import java.io.*;
import java.net.*;
import java.util.Arrays;

public class trafficSink {
	public static void main(String[] args) throws IOException {
		PrintStream pout = null;
		DatagramSocket socket = new DatagramSocket(4445);
		long sys_current_time;
		long sys_previous_time = System.nanoTime();
		long time_diff;
		int pkt_size;
		int packetcount = 1; 
		try {

			FileOutputStream fout =  new FileOutputStream("trafficSinkoutput_2.txt");
			pout = new PrintStream (fout);
			
			while (true) {
				byte[] buf = new byte[2000];
				DatagramPacket p = new DatagramPacket(buf, buf.length);
				socket.receive(p);
				sys_current_time = System.nanoTime();
				time_diff = sys_current_time - sys_previous_time;
				sys_previous_time = sys_current_time;
				pkt_size = p.getLength();
				if (packetcount == 1)
					pout.println(packetcount + "\t" + 0 + "\t" + pkt_size);
				else
					pout.println(packetcount + "\t" + time_diff/1000 + "\t" + pkt_size); 
				packetcount += 1;
			}
		}finally {
			pout.close();
		}
	}
}
