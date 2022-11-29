import json
import sys

fils = sys.argv[1:]
costs = []
for fil in fils:
    jsonfil = json.load(open(fil))
    costs.append(jsonfil["cost"][0])

avg = sum(costs)/len(costs)
std1 = [ (i-avg)**2 for i in costs]
std = math.sqrt(sum(std1)/(len(std1)-1))  if len(std1) > 1 else 0
print avg
print std
