from TOSSIM import *
import sys

t = Tossim([])
r = t.radio();

t.addChannel("SimpleTransceiverC", sys.stdout)
t.addChannel("TestACK", sys.stdout)

m1 = t.getNode(1)
m2 = t.getNode(2)
m3 = t.getNode(3)
m4 = t.getNode(4)
m5 = t.getNode(5)
m6 = t.getNode(6)
m7 = t.getNode(7)
m8 = t.getNode(8)
m9 = t.getNode(9)
m10 = t.getNode(10)

# Set up a hidden terminal scenario, where 1 and 3
# are closely synchronized, but cannot hear each other.
m1.bootAtTime(345321);
m2.bootAtTime(321234);
m3.bootAtTime(345325);
m4.bootAtTime(400000);
m5.bootAtTime(410000);
m6.bootAtTime(420340);
m7.bootAtTime(430544);
m8.bootAtTime(449503);
m9.bootAtTime(456793);
m10.bootAtTime(463492);

r.add(1, 2, -30.0);
r.add(2, 3, -30.0);
r.add(3, 4, -60.0);
r.add(4, 5, -30.0);
r.add(5, 6, -50.0);
r.add(6, 7, -40.0);
r.add(7, 8, -20.0);
r.add(8, 9, -10.0);
r.add(9, 10, -20.0);
r.add(10, 1, -30.0);
r.add(1, 10, -30.0);
r.add(2, 1, -60.0);
r.add(3, 2, -30.0);
r.add(4, 3, -50.0);
r.add(5, 4, -40.0);
r.add(6, 5, -20.0);
r.add(7, 6, -10.0);
r.add(8, 7, -20.0);
r.add(9, 8, -30.0);



noise = open("radio-noise.txt", "r")
lines = noise.readlines()
for line in lines:
  str = line.strip()
  if (str != ""):
    val = int(str)
    m1.addNoiseTraceReading(val)
    m2.addNoiseTraceReading(val)
    m3.addNoiseTraceReading(val)
    m4.addNoiseTraceReading(val)
    m5.addNoiseTraceReading(val)
    m6.addNoiseTraceReading(val)
    m7.addNoiseTraceReading(val)
    m8.addNoiseTraceReading(val)
    m9.addNoiseTraceReading(val)
    m10.addNoiseTraceReading(val)
        
	
m1.createNoiseModel()
m2.createNoiseModel()
m3.createNoiseModel()
m4.createNoiseModel()
m5.createNoiseModel()
m6.createNoiseModel()
m7.createNoiseModel()
m8.createNoiseModel()
m9.createNoiseModel()
m10.createNoiseModel()
for i in range(0, 20000):
    t.runNextEvent();

    
