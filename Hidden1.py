from TOSSIM import *
import sys

t = Tossim([])    # 1. define an object of TOSSIM
r = t.radio();    # 2. define an object of radio model

t.addChannel("SimpleTransceiverC", sys.stdout) # 3. channels here mean formats outputing debug information (standard output or a file). 
t.addChannel("TestACK", sys.stdout)            # the first parameter is the channel destination, the second is the channel.

m1 = t.getNode(1)             # 4. define an object representing a specific mote.
m2 = t.getNode(2)

# mote 1 is Tx, mote 2 is Rx. Refer to SimpleTransceiverC.nc
m1.bootAtTime(345321);        # 5. start the mote; ticks,time unit.   t.ticksPerSecond(), one second.  10 to the power 10 ticks per second.
m2.bootAtTime(82123411);
r.add(1, 2, -60.0);           # 6. add a link, src is mote 1, the dest is mote 2.
r.add(2, 1, -60.0);     

noise = open("radio-noise.txt", "r")  # 7. configure the CPM radio model. the radio noise is a piece of data from real mote platform experiment.
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    m1.addNoiseTraceReading(val)
    m2.addNoiseTraceReading(val)

m1.createNoiseModel()
m2.createNoiseModel()

for i in range(0, 2000):          #  make the simulator run 2000 clock ticks.
    t.runNextEvent();             # 8. the way running a TOSSIM simulator is with "runNextEvent()"   
                                  
    
