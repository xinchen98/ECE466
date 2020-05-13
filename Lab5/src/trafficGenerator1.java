import java.io.*;
import java.net.*;
import java.util.StringTokenizer;
import java.util.Arrays;
import java.util.List;

public class trafficGenerator1 extends Thread{
	static private InetAddress addr;
	static private int sendPort;
	static private int N;
	static private int L;
	static private int r;
	static private int NoFile;
	static private int sinkPort;
	
	public trafficGenerator1 (InetAddress addr, int sendPort, int sinkPort, int N, int L, int r, int NoFile) {
		this.addr = addr;
		this.sendPort = sendPort;
		this.N = N;
		this.L = L;
		this.r = r;
		this.NoFile = NoFile;
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
		BufferedReader bis = null; 
		BufferedReader dis = null;
		int service_rate = 0;
		float service_curve = 0;
		
		try {
				for (int t_r = r; t_r <= 150; t_r = t_r+10) {
					long sys_pre = 0;
					long sys_cur = 0;
					long sys_init = 0;
					// wait_time is compute in us
					double rate = (double)(L*8)/(t_r*1000);
					long wait_time = (long) (rate * 1000000);
					
					DatagramSocket socket = new DatagramSocket();
					FileOutputStream fout =  new FileOutputStream("trafficGenerator"+ NoFile+".txt");
					pout = new PrintStream (fout);
					
					sys_init = System.nanoTime();
//					System.out.println("generator"+sys_init);
					
					for (int i = 1; i <= N; i++) {
						
						byte[] buf = new byte [L];
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
					
					
					/*
					 * read the generator and sink file in order to check the maximum backlog of the 
					 * arrival and departure function, and then decide to change the value of r
					 */
					int maximum = 0; // sequence number that maximum Bmax happened
					int Bmax = 0;
					float Bmaxt = 0; // time that Bmax happened

					
					sys_pre = System.nanoTime();
					sys_cur = System.nanoTime();
					
					while ((sys_cur - sys_pre) < 10*100000000) {
						sys_cur = System.nanoTime();
					}
					
					File pin = new File("trafficSinkoutput"+NoFile+".txt"); 
					FileReader pis = new FileReader(pin);  
					dis = new BufferedReader(pis);  
					
					String geneLine = null; 
					String sinkLine = null; 
					
					while ((sinkLine = dis.readLine()) != null) {
						StringTokenizer ss = new StringTokenizer(sinkLine); 
						String col1 = ss.nextToken(); 
						String col2 = ss.nextToken(); 
						String col3  = ss.nextToken(); 
						
						int seqNo1 = Integer.parseInt(col1);
						float timestamp1 = Float.parseFloat(col3);
						
						File fin = new File("trafficGenerator"+NoFile+".txt"); 
						FileReader fis = new FileReader(fin);  
						bis = new BufferedReader(fis);  
						
						while ((geneLine = bis.readLine()) != null) {
							StringTokenizer sg = new StringTokenizer(geneLine); 
							String col4 = sg.nextToken(); 
							String col5 = sg.nextToken(); 
							String col6  = sg.nextToken(); 
							
							int seqNo2 = Integer.parseInt(col4);
							float timestamp2 = Float.parseFloat(col6);
							
							if (timestamp2 >= timestamp1 && seqNo2 != 1 && seqNo2 != 2) {
								if (maximum < seqNo2 - seqNo1) {
									maximum = seqNo2 - seqNo1;
									Bmaxt = timestamp2; 
									Bmax = L* 8 * maximum;
									System.out.println(Bmax);
									System.out.println(t_r + "\t" + maximum + "\t");
									if ((t_r*Bmaxt/1000 - Bmax) >= service_curve) {
										service_curve = t_r*Bmaxt/1000-Bmax;
										service_rate = t_r;
									}
								}
								break;
							}
						}
					}
					NoFile ++;
				}
				System.out.println(service_rate);
		} catch (IOException e) {  
			// catch io errors from FileInputStream or readLine()  
			System.out.println("IOException: " + e.getMessage());  
		} 
	}

	private int r(int i) {
		// TODO Auto-generated method stub
		return 0;
	} 
	
}


