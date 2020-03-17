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
			
			int N = 5;
			long T = 1;
			int L = 100;
			long sys_current_time = 0;
			long sys_previous_time = 0;
			long start_time = 0;
			int total_send = 0;
			
			File fin = new File("movietrace.data"); 
			FileReader fis = new FileReader(fin);  
			bis = new BufferedReader(fis);  
			
			while ((currentLine = bis.readLine())!= null) { 
				byte[] buf = new byte [2000];
				
				StringTokenizer st = new StringTokenizer(currentLine); 
				String col1 = st.nextToken(); 
				String col2 = st.nextToken(); 
				String col3  = st.nextToken(); 
				String col4 = st.nextToken();
				/*
				 *  Convert each element to desired data type 
				 */
				int SeqNo = Integer.parseInt(col1);
				float timestamp = Float.parseFloat(col2);
				int Fsize = Integer.parseInt(col4);
				
				while (Fsize > 1024) {
					DatagramPacket packet = new DatagramPacket(buf, 1024, addr, 4444);
					sys_current_time = System.nanoTime();
					while(sys_current_time - sys_previous_time < T*1000*1000) {
						sys_current_time = System.nanoTime();
					}
					socket.send(packet);
					sys_previous_time = sys_current_time;
					Fsize = Fsize - 1024;
				}
				DatagramPacket packet =
						new DatagramPacket(buf, Fsize, addr, 4444);
				
				sys_current_time = System.nanoTime();
				while(sys_current_time - sys_previous_time < T*1000*1000) {
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


