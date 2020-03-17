import java.io.*;
import java.net.*;
import java.util.StringTokenizer;
import java.util.Arrays;

public class trafficGenerator_2 {

	public static void main(String[] args) throws IOException {
		DatagramSocket socket = new DatagramSocket();
		InetAddress addr = InetAddress.getByName(args[0]);
		BufferedReader bis = null; 
		String currentLine = null; 
		PrintStream pout = null;
		try {  
			
			int N = 10;
			long T = 1;
			int L = 100;
			long sys_current_time = 0;
			long sys_previous_time = 0;
			int total_send = 0;
			
			/*
			 * Open file for output 
			 */
			FileOutputStream fout =  new FileOutputStream("trafficGeneratorOutput_2.txt");
			pout = new PrintStream (fout);
			
			while (true) { 
				byte[] buf = new byte [1500];
				
				for (int packetcount = 0; packetcount < N; packetcount++) {
					DatagramPacket packet = new DatagramPacket(buf, L, addr, 4444);
					sys_current_time = System.nanoTime();
					socket.send(packet);
					total_send += 1;
					if (packetcount == 0) {
						pout.println(total_send + "\t" + 0 + "\t"+ L);
						sys_previous_time = sys_current_time;
					}
					else
						pout.println(total_send + "\t" + (sys_current_time - sys_previous_time)/1000 + "\t"+ L); 
					sys_previous_time = sys_current_time;
				}
				
				sys_current_time = System.nanoTime();
				while(sys_current_time - sys_previous_time < T * 1000 * 1000) {
					sys_current_time = System.nanoTime();
				}
				sys_previous_time = sys_current_time;
			}
		} catch (IOException e) {  
			// catch io errors from FileInputStream or readLine()  
			System.out.println("IOException: " + e.getMessage());  
		} finally {  
			// Close files   
			if (bis != null) { 
				try { 
					bis.close(); 
				} catch (IOException e) { 
					System.out.println("IOException: " +  e.getMessage());  
				} 
			} 
		} 
	}
	
}


