from TOSSIM import *
import sys

t = Tossim([])
r = t.radio();

t.addChannel("SimpleTransceiverC", sys.stdout)
t.addChannel("TestACK", sys.stdout)

m1 = t.getNode(1)
m2 = t.getNode(2)
m3 = t.getNode(3)

# Set up a hidden terminal scenario, where 1 and 3
# are closely synchronized, but cannot hear each other.
m1.bootAtTime(345321);
m2.bootAtTime(82123411);
m3.bootAtTime(345325);
r.add(1, 2, -30.0);
r.add(2, 1, -30.0);
r.add(2, 3, -30.0);
r.add(3, 2, -30.0);

noise = open("radio-noise.txt", "r")
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    m1.addNoiseTraceReading(val)
    m2.addNoiseTraceReading(val)
    m3.addNoiseTraceReading(val)

m1.createNoiseModel()
m2.createNoiseModel()
m3.createNoiseModel()

for i in range(0, 20000):
    t.runNextEvent();

    
