import java.io.*;
import java.net.*;
import java.util.StringTokenizer;
import java.util.Arrays;

public class trafficGenerator {

	public static void main(String[] args) throws IOException {
		DatagramSocket socket = new DatagramSocket();
		InetAddress addr = InetAddress.getByName(args[0]);
		BufferedReader bis = null; 
		String currentLine = null; 
		PrintStream pout = null;
		try {  

			/*
			 * Open input file as a BufferedReader
			 */ 
			File fin = new File("poisson3.data"); 
			FileReader fis = new FileReader(fin);  
			bis = new BufferedReader(fis);  
			
			long current_time = 0;
			long previous_time = 0;
			long time_difference = 0;
			long sys_current_time = 0;
			long sys_previous_time = 0;
			
			while ( (currentLine = bis.readLine()) != null) { 

				/*
				 *  Parse line and break up into elements 
				 */
				StringTokenizer st = new StringTokenizer(currentLine); 
				String col1 = st.nextToken(); 
				String col2 = st.nextToken(); 
				String col3  = st.nextToken(); 
//				String col4 = st.nextToken();
				/*
				 *  Convert each element to desired data type 
				 */
				int SeqNo = Integer.parseInt(col1);
				float timestamp = Float.parseFloat(col2);
				int Fsize = Integer.parseInt(col3);
				
				previous_time = current_time;
				current_time = (long)timestamp;
				time_difference = (current_time - previous_time)*1000;
				
				byte[] buf = new byte [1500];
				
				while (Fsize > 1024) {
//					System.out.println("I am here");
					DatagramPacket packet = new DatagramPacket(buf, 1024, addr, 4444);
					sys_current_time = System.nanoTime();
					while(sys_current_time - sys_previous_time < time_difference) {
						sys_current_time = System.nanoTime();
					}
					socket.send(packet);
//					socket.send() also occupy timing in transporting
					sys_previous_time = sys_current_time;
					Fsize = Fsize - 1024;
				}
				DatagramPacket packet =
						new DatagramPacket(buf, Fsize, addr, 4444);
				
				sys_current_time = System.nanoTime();
				while(sys_current_time - sys_previous_time < time_difference) {
					sys_current_time = System.nanoTime();
				}
				socket.send(packet);
//				socket.send() also occupy timing in transporting
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


