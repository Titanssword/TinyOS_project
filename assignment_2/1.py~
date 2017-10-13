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
m11 = t.getNode(11)
m12 = t.getNode(12)
m13 = t.getNode(13)


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
m10.bootAtTime(563492);
m11.bootAtTime(963492);
m12.bootAtTime(1163492);
m13.bootAtTime(1363492);


r.add(1, 2, 20.0);
r.add(1, 5, 20.0);
r.add(1, 4, 20.0);

r.add(2, 1, 20.0);
r.add(2, 3, -60.0);
r.add(2, 4, 20.0);
r.add(2, 5, -55.0);
r.add(2, 6, -65.0);

r.add(3, 2, -51.0);
r.add(3, 5, -60.0);
r.add(3, 6, -62.0);

r.add(4, 1, 20.0);
r.add(4, 2, 20.0);
r.add(4, 5, 20.0);
r.add(4, 7, -58.0);
r.add(4, 8, -60.0);

r.add(5, 1, 20.0);
r.add(5, 2, 20.0);
r.add(5, 3, -62.0);
r.add(5, 4, 20.0);
r.add(5, 6, -61.0);
r.add(5, 7, -63.0);
r.add(5, 8, -59.0);
r.add(5, 9, -55.0);

r.add(6, 2, -57.0);
r.add(6, 3, -58.0);
r.add(6, 5, -69.0);
r.add(6, 8, -61.0);
r.add(6, 9, -55.0);

r.add(7, 4, -50.0);
r.add(7, 5, -48.0);
r.add(7, 8, -58.0);

r.add(8, 4, -60.0);
r.add(8, 5, -61.0);
r.add(8, 6, -62.0);
r.add(8, 7, -63.0);
r.add(8, 9, -64.0);

r.add(9, 5, -59.0);
r.add(9, 6, -56.0);
r.add(9, 8, -55.0);



r.add(10, 1, 10.0);
r.add(10, 2, 10.0);
r.add(10, 4, 10.0);
r.add(10, 5, 10.0);

r.add(11, 2, 50.0);
r.add(11, 3, 50.0);
r.add(11, 5, 50.0);
r.add(11, 6, 50.0);


r.add(12, 4, -10.0);
r.add(12, 5, -10.0);
r.add(12, 7, -10.0);
r.add(12, 8, -10.0);

r.add(13, 5, -10.0);
r.add(13, 6, -10.0);
r.add(13, 8, -10.0);
r.add(13, 9, -10.0);





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
    m11.addNoiseTraceReading(val)
    m12.addNoiseTraceReading(val)
    m13.addNoiseTraceReading(val)
        
	
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
m11.createNoiseModel()
m12.createNoiseModel()
m13.createNoiseModel()

for i in range(0, 50000):
    t.runNextEvent();

    
