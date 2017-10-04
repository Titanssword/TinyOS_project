from TOSSIM import *
import sys

t = Tossim([])
r = t.radio();

t.addChannel("SimpleTransceiverC", sys.stdout)
t.addChannel("TestACK", sys.stdout)

m1 = t.getNode(1)
m2 = t.getNode(2)

# mote 1 is Tx, mote 2 is Rx. Refer to SimpleTransceiverC.nc
m1.bootAtTime(345321);
m2.bootAtTime(82123411);
r.add(1, 2, -30.0);
r.add(2, 1, -40.0);

noise = open("radio-noise.txt", "r")
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    m1.addNoiseTraceReading(val)
    m2.addNoiseTraceReading(val)

m1.createNoiseModel()
m2.createNoiseModel()

for i in range(0, 2000):
    t.runNextEvent();

    
