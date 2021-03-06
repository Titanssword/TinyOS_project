
/*
* Studying Tossim radio model by setting up hidden terminal and exposed terminal scenario.
* @autor Wei Shen, Mittuniversitetet
* @date Feb.17 2010
*/
#include <unistd.h>
#include "RadioCountToLeds.h"

module SimpleTransceiverC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    //interface Timer<TMilli> as Timer1;
	
    interface SplitControl as AMControl;
    interface Packet;
    interface AMPacket;
    interface PacketAcknowledgements;
    interface LocalTime<TMilli>;
    //interface Graph;
    interface Random;
  }
}
implementation {

  message_t packet;
  int t = 500;
  uint32_t start_time;
  uint32_t end_time;
uint32_t  during_time;
  bool locked;
  uint16_t counter = 0;
  uint16_t nCountACK = 0;
  uint32_t max = 2147483647;
  uint32_t random_time;
  float random_NODE;
  int want =0;
	am_addr_t addr;
  int actuator[4][4] = { { 1,2,4,5}, { 2,3,5,6}, { 4,5,7,8}, { 5,6,8,9}};
  int i = 0;
  int count = 4; 
//buff
  int occupy = 0;// if occupy the resource occupy = 1
  
  event void Boot.booted() {      //1 when tinyos system initiates all of its components, turn on the radio.
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
	if(TOS_NODE_ID == 10 || TOS_NODE_ID == 11|| TOS_NODE_ID == 12|| TOS_NODE_ID == 13)
		//call Timer1.startPeriodic(3000);
		call Timer1.startOneShot(0);
		
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }
  
  event void MilliTimer.fired() {                 //3. timer is fired, send a message with maxlen payload.(radom data)
    //counter++;
   // dbg("SimpleTransceiverC", "SimpleTransceiverC: timer fired, counter is %hu.\n", counter);
    if (locked) { // busy
      return;
    }
    else {
	

	 // call PacketAcknowledgements.requestAck(&packet);// shwe
	if(locked) return;
      else if (call AMSend.send(AM_BROADCAST_ADDR, &packet, 1) == SUCCESS) {// Broadcast doesn't need ACK.
	    //dbg("SimpleTransceiverC", "SimpleTransceiverC: packet sent.\n", counter);	
            start_time = call LocalTime.get();
		dbg("SimpleTransceiverC","send at %d\n",start_time);
	    locked = TRUE;
      }
	  //else send failed
    }
  }

  event message_t* Receive.receive(message_t* bufPtr, void* payload, uint8_t len) {   //4. when a message is received, come to here
   
   
	
	addr = call AMPacket.source(bufPtr);
	
		
	want = 1;
	dbg("SimpleTransceiverC", "I'm activated by %d\n", addr);
		
	radio_count_msg_t* rcm = (radio_count_msg_t*)call Packet.getPayload(&packet, sizeof(radio_count_msg_t));

 	if (rcm == NULL) {
		return;
      	}

     	rcm->counter = 666;
        if (call AMSend.send(AM_BROADCAST_ADDR, &packet, sizeof(radio_count_msg_t)) == SUCCESS) {
		//dbg("RadioCountToLedsC", "RadioCountToLedsC: packet sent.\n", counter);	
		locked = TRUE;
      	}



	
    
  }

event void Timer1.fired() {
	
		random_NODE = (float)(call Random.rand32())/max * 10;
		//dbg("SimpleTransceiverC", "randomNOde: %f\n", random_NODE );
		if(random_NODE <3 && TOS_NODE_ID ==10)
			
           		 call MilliTimer.startOneShot(0);
		else if(random_NODE >3 && random_NODE <6 && TOS_NODE_ID ==11)
				
           		 call MilliTimer.startOneShot(0);
		else if(random_NODE >6 && random_NODE <9 && TOS_NODE_ID ==12)
				
           		 call MilliTimer.startOneShot(0);
		else if(random_NODE >9 && TOS_NODE_ID ==13)
			
           		 call MilliTimer.startOneShot(0);
	}




  event void AMSend.sendDone(message_t* bufPtr, error_t error) {  //5. Signaled in response to an accepted send request. bufPtr: send buffer, 
                                                   //and error indicates whether the send was successful, and if not, the cause of the failure. 
   
    
	if(error == SUCCESS) 
	//	;//dbg("SimpleTransceiverC", "Success\n", error);
		locked = FALSE;
	//else 
		//	dbg("SimpleTransceiverC", "Send Error\n", error);
	/*if(call PacketAcknowledgements.wasAcked(bufPtr))   //shwe, in ACK-enable mode, success send means ACK is received.
{
	dbg("SimpleTransceiverC", "shoudaole2 %d\n",  call AMPacket.source(bufPtr));
}
	*/	//return SUCCESS;
	    //nCountACK++;
	//dbg("SimpleTransceiverC", "%d\n", error);
	//dbg("TestACK", "current num of ACK received is %d; num of packets sent is %d\n", nCountACK,counter);
  }

}




