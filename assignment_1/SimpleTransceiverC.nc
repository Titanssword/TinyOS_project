
/*
* Studying Tossim radio model by setting up hidden terminal and exposed terminal scenario.
* @autor Wei Shen, Mittuniversitetet
* @date Feb.17 2010
*/
#include <unistd.h>


module SimpleTransceiverC @safe() {
  uses {
    interface Leds;
    interface Boot;
    interface Receive;
    interface AMSend;
    interface Timer<TMilli> as MilliTimer;
    interface Timer<TMilli> as Timer1;
    interface SplitControl as AMControl;
    interface Packet;
    interface AMPacket;
    interface PacketAcknowledgements;
    interface LocalTime<TMilli>;
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
	am_addr_t addr;
  
  event void Boot.booted() {      //1 when tinyos system initiates all of its components, turn on the radio.
    call AMControl.start();
  }

  event void AMControl.startDone(error_t err) {
    if (err == SUCCESS) {
	
		//if (TOS_NODE_ID == 1 || TOS_NODE_ID == 3) //2 after the radio is ready, start a timer of 4MHz.		
            call MilliTimer.startPeriodic(2500);
    }
    else {
      call AMControl.start();
    }
  }

  event void AMControl.stopDone(error_t err) {
    // do nothing
  }
  
  event void MilliTimer.fired() {                 //3. timer is fired, send a message with maxlen payload.(radom data)
    counter++;
   // dbg("SimpleTransceiverC", "SimpleTransceiverC: timer fired, counter is %hu.\n", counter);
    if (locked) { // busy
      return;
    }
    else {
	  //call PacketAcknowledgements.requestAck(&packet);// shwe
      if (call AMSend.send(AM_BROADCAST_ADDR, &packet, call AMSend.maxPayloadLength()) == SUCCESS) {// Broadcast doesn't need ACK.
	   // dbg("SimpleTransceiverC", "SimpleTransceiverC: packet sent.\n", counter);	
            start_time = call LocalTime.get();
		dbg("SimpleTransceiverC","send at %d\n",start_time);
	    locked = TRUE;
      }
	  //else send failed
    }
  }

  event message_t* Receive.receive(message_t* bufPtr, void* payload, uint8_t len) {   //4. when a message is received, come to here
   
    //dbg("SimpleTransceiverC", "Received packet of length %hhu.\n", len);  
     // dbg("SimpleTransceiverC", "ID=%s\n", call AMPacket.source(bufPtr));
	//dbg("SimpleTransceiverC", "ID=%d\n",bufPtr);
	if(len==5){
		
		end_time = call LocalTime.get();
		during_time = end_time - start_time;
		
		if(during_time <= t){
				dbg("SimpleTransceiverC","receive the response at %d\n",end_time);
				dbg("SimpleTransceiverC","****SUCCESS*******\n");	
		}
		else{
			dbg("SimpleTransceiverC","failed\n");	
		}
	}
	else{
	
	
	addr = call AMPacket.source(bufPtr);
	random_time = (float)(call Random.rand32())/max * 2 * t ;
	// sleep(random_time);
	call Timer1.startOneShot(random_time);

	//dbg("SimpleTransceiverC", "ID=%d\n",addr);
	//dbg("SimpleTransceiverC","random=%d\n",random_time);
	//call AMSend.send(addr, &packet, 5);
	
	}
    	    
return bufPtr;
    
  }

event void Timer1.fired() {
	//dbg("SimpleTransceiverC", "ID=%d\n",addr);
  		call AMSend.send(addr, &packet, 5);
	}


  event void AMSend.sendDone(message_t* bufPtr, error_t error) {  //5. Signaled in response to an accepted send request. bufPtr: send buffer, 
                                                   //and error indicates whether the send was successful, and if not, the cause of the failure. 
   
    locked = FALSE;
	
	if(call PacketAcknowledgements.wasAcked(bufPtr))   //shwe, in ACK-enable mode, success send means ACK is received.
	    nCountACK++;
	//dbg("TestACK", "current num of ACK received is %d; num of packets sent is %d\n", nCountACK,counter);
  }

}




