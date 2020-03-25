package priority;

import priority.PacketScheduler.PacketScheduler;

public class SchedulerStarter
{
	public static void main(String[] args)
	{
		/*
		 * Create a new packet scheduler
		 * Scheduler listens on UDP port 4444 for incoming *packets
		 * and sends outgoing packets to localhost: 4445
		 * Transmission rate of scheduler is 20Mbps. The scheduler 
		 * has 2 queue, and accepts packets of maximum size 1480
		 * bytes.
		 * Capacity of both of the queues are 100 * 1024 bytes.
		 * Arrivals of packets are recorded to file ps.txt.
		 */
		
		PacketScheduler ps = new PacketScheduler(4444, 
				"localhost", 4445, 20000000, 2, 1480, 
				new long [] {100*1024, 100*1024}, "ps_prio9.txt");
		// start packet scheduler
		new Thread(ps).start();
	}
}