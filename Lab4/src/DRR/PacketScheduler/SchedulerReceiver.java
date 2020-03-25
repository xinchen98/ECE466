package DRR.PacketScheduler;

import java.io.FileOutputStream;
import java.io.PrintStream;
import java.net.DatagramPacket;
import java.net.DatagramSocket;


/**
 * Listens on specified port for incoming packets.
 * Packets are stored to queues.
 */
public class SchedulerReceiver implements Runnable
{
	// queues used to store incoming packets 
	private Buffer[] buffers;
	// port on which packets are received
	private int port;
	// name of output file
	private String fileName;
	
	/**
	 * Constructor.
	 * @param buffers Buffers to which packets are stored. 
	 * @param port Port on which to lister for packets.
	 * @param fileName Name of output file.
	 */
	public SchedulerReceiver(Buffer[] buffers, int port, String fileName)
	{
		this.buffers = buffers;
		this.port = port;
		this.fileName = fileName;
	}

	/**
	 * Listen on port and send out or store incoming packets to buffers.
	 * This method is invoked when starting a thread for this class.
	 */  
	public void run()
	{		
		DatagramSocket socket = null;
		PrintStream pOut = null;	
		byte Queue;
		int buf1Drop = 0;
		int buf2Drop = 0;
		int buf3Drop = 0;
		try
		{
			FileOutputStream fOut =  new FileOutputStream(fileName);
			pOut = new PrintStream (fOut);
			long previsuTime = 0;
			
			socket = new DatagramSocket(port);
			
			// receive and process packets
			while (true)
			{
				byte[] buf = new byte[Buffer.MAX_PACKET_SIZE];
				DatagramPacket packet = new DatagramPacket(buf, buf.length);
				
				// wait for packet, when arrives receive and recored arrival time
				socket.receive(packet);
				long startTime=System.nanoTime();
				
				/*
				 * Record arrival to file in following format:
				 * elapsed time (microseconds), packet size (bytes), backlog in buffers ordered by index in array (bytes).
				 */
				// to put zero for elapsed time in first line
				if(previsuTime == 0)
				{
					previsuTime = startTime;
				}
				pOut.print((startTime-previsuTime)/1000 + "\t" + packet.getLength() + "\t");
				for (int i = 0; i<buffers.length; i++)
				{
					long bufferSize = buffers[i].getSizeInBytes();
					pOut.print(bufferSize + "\t");
				}
				previsuTime = startTime;
				
				/*
				 * Process packet.
				 */
				Queue = packet.getData()[0];
				/*
				 * TODO: 
				 * Replace previous command with code that:
				 * - implements packet classifier 
				 * - stores packets to appropriate queue
				 * - reports and/or logs packets drops with all information you need
				 */
				if (Queue == (byte)1) {
					if (buffers[0].addPacket(new DatagramPacket(packet.getData(), packet.getLength())) < 0)
					{	
						System.err.println("Packet dropped (queue full).");
						buf1Drop = buf1Drop + 1;
					}
				}
				else if (Queue == (byte)2) {
					if (buffers[1].addPacket(new DatagramPacket(packet.getData(), packet.getLength())) < 0)
					{	
						System.err.println("Packet dropped (queue full).");
						buf2Drop = buf2Drop + 1;
					}
				}
				else if (Queue == (byte)3) {
					if (buffers[2].addPacket(new DatagramPacket(packet.getData(), packet.getLength())) < 0)
					{	
						System.err.println("Packet dropped (queue full).");
						buf3Drop = buf3Drop + 1;
					}
				}
				pOut.print(buf1Drop + "\t" + buf2Drop + "\t" + buf3Drop + "\t");
				pOut.println();
			}
		} 
		catch (Exception e)
		{
			// TODO Auto-generated catch block
			e.printStackTrace();
		}	
	}
}