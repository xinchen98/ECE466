package fifo;

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
			int N = 9;
			
			while ( (currentLine = bis.readLine()) != null) { 

				/*
				 *  Parse line and break up into elements 
				 */
				StringTokenizer st = new StringTokenizer(currentLine); 
				String col1 = st.nextToken(); 
				String col2 = st.nextToken(); 
				String col3  = st.nextToken(); 
				/*
				 *  Convert each element to desired data type 
				 */
				int SeqNo = Integer.parseInt(col1);
				float timestamp = Float.parseFloat(col2);
				int Fsize = Integer.parseInt(col3);
				
				// the time is in millisecond(us)
				previous_time = current_time;
				current_time = (long)timestamp;
				// change the time to nanosecond(ns)
				time_difference = (current_time - previous_time)*1000;
				byte[] buf = new byte [1480];
				
				DatagramPacket packet =
						new DatagramPacket(buf, Fsize, addr, 4444);
				
				sys_current_time = System.nanoTime();
				// use time_differnece / N in order to decide the waiting time for transmitting the next packet
				// as N become larger, the idle time between two transmitting packet decreases
				while(sys_current_time - sys_previous_time < ((time_difference)/N)) {
					sys_current_time = System.nanoTime();
				}
				socket.send(packet);
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


