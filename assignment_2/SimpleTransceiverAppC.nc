
/*
* Studying Tossim radio model by setting up hidden terminal and exposed terminal scenario.
* @autor Wei Shen, Mittuniversitetet
* @date Feb.17 2010
*/

#include "RadioCountToLeds.h"
configuration SimpleTransceiverAppC {}
implementation {

  enum {
	  AM_SIMPLE_TRANSCEIVER_MSG = 10, // specify the AM type of the packet.
  };
  
  components MainC, SimpleTransceiverC as App, LedsC;
  components LocalTimeMilliC;
  //components CounterMilliC;
  components new AMSenderC(AM_SIMPLE_TRANSCEIVER_MSG);
  components new AMReceiverC(AM_SIMPLE_TRANSCEIVER_MSG);
  components new TimerMilliC();
  components new TimerMilliC() as Timer1;


  //components GraphC;
  components ActiveMessageC;
	components RandomC;
  
  App.Boot -> MainC.Boot;
  
  App.Receive -> AMReceiverC;             //use this interface to receive msg
  App.AMSend -> AMSenderC;                //use this interface to send msg
  App.AMControl -> ActiveMessageC;
  App.Leds -> LedsC;
  App.MilliTimer -> TimerMilliC;
  App.Packet -> AMSenderC;
  App.Timer1 -> Timer1 ;

 // App.Graph -> GraphC;
  App.AMPacket -> AMSenderC;
  App.PacketAcknowledgements -> AMSenderC;

  App.LocalTime -> LocalTimeMilliC; 
App.Random -> RandomC;
   //App.LocalTime -> CounterMilliC;
}


