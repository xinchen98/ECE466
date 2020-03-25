package DRR;

import DRR.PacketScheduler.PacketScheduler;

public class SchedulerStarter
{
	public static void main(String[] args)
	{
		/*
		 * Create a new packet scheduler
		 * Scheduler listens on UDP port 4444 for incoming *packets
		 * and sends outgoing packets to localhost: 4445
		 * Transmission rate of scheduler is 10Mbps. The scheduler 
		 * has 3 queue, and accepts packets of maximum size 1480
		 * bytes.
		 * Capacity of the queue is 100 * 1024 bytes.
		 * Arrivals of packets are recorded to file ps.txt.
		 */
		
		PacketScheduler ps = new PacketScheduler(4444, 
				"localhost", 4445, 10000000, 3, 1480, 
				new long [] {100*1024,100*1024,100*1024}, "ps_drr2.txt");
		// start packet scheduler
		new Thread(ps).start();
	}
}