import json
import sys

fils = sys.argv[1:]
stimes = []
for fil in fils:
    jsonfil = json.load(open(fil))
    stimes.append(jsonfil["solver_time"])
avg = sum(stimes)/len(stimes)
std1 = [ (i-avg)**2 for i in stimes]
std = math.sqrt(sum(std1)/(len(std1)-1))  if len(std1) > 1 else 0
print avg
print std
