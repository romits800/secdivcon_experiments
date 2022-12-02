#! env python

# grep -E "(python create|^Average|^Number divs)" out2 &> out
#import re
import sys
#from uncertainties import ufloat
#from uncertainties import unumpy  # Array manipulation
##import uncertainties
#import math
import cPickle as pickle
#import os
import getopt
import os
import json
import math
#from masking import *
#from spec_cpu  import *

def bucks_to_csv (dbucks, buckets, nums, filename):
    num = sum(nums)/len(nums) # avg
    if filename != None :
        with open(filename, "w") as f:
            f.write(",".join(map(str,buckets)) + "," + "num")
            f.write("\n")
            vals = [dbucks[b] for b in buckets if dbucks.has_key(b)]
            f.write(",".join(["-" if not dbucks.has_key(b) else ("\\\\textbf{" + str(dbucks[b]) + "}" if dbucks[b] == max(vals) else str(dbucks[b])) for b in buckets]) + "," + str(num))
            f.write("\n")
    else:
        print ",".join(map(str,buckets))
        vals = [dbucks[b] for b in buckets if dbucks.has_key(b)]
        print (",".join(["-" if not dbucks.has_key(b) else ("\\\\textbf{" + str(dbucks[b]) + "}" if dbucks[b] == max(vals) else str(dbucks[b])) for b in buckets]) + "," + str(num))
        #print ",".join([str(dbucks[b]) if dbucks.has_key(b) else "-" for b in buckets])

def stime_to_file (stimeall, filename):
    stime = sum(stimeall)/len(stimeall) ## Avg
    stimestd = [ (i - stime)**2 for i in stimeall]
    std = math.sqrt(sum(stimestd)/(len(stimestd)-1))  if len(stimestd) > 1 else 0.
    if filename != None :
        with open(filename, "w") as f:
            f.write("divstd")
            f.write("\n")
            f.write(str(round(std/1000.,3)))
            f.write("\n")
            f.write("divtime")
            f.write("\n")
            f.write(str(round(stime/1000.,3)))
            f.write("\n")
    else:
        print "divstd: ", std
        print "divtime: ", stime

def data_to_buckets(data, buckets):
    tmp = {i:0 for i in buckets}
    ndat = dict()
    #temp = d[ag][bench][r][m][meas]["data"]
    allsum = sum(data.values())
    for i in data:
        for v in buckets:
            if i <= v:
                tmp[v] += data[i]
                break  # We found the bucket
    for v in tmp:
        val = int(round(100*tmp[v]/float(allsum),0))
        if val > 0.0 :
            ndat[v] = val
    return ndat


def extend_dict(dold, nd):
    for i in nd:
        if dold.has_key(i):
            dold[i] += nd[i]
        else:
            dold[i] = nd[i]
    return dold

def read_files(agap, rrate, path, cgadgets, iterr):
  files = []
  data  = dict()
  num   = []
  solver_time = []
  for meas in os.listdir(path):
    if meas.endswith("_result.pickle"):
        fil = pickle.load(open(meas))
        files.append(fil)
        if (fil.has_key(cgadgets)): 
            num.append(fil['numdivs'])
            solver_time.append(fil['divtime'])
            data = extend_dict(data,fil[cgadgets]['data'])
            #break
  return data, num, solver_time

def help():
      print 'test.py -r <relax_rate> -g <optimality_gap> -p <path> -c <both|max> -b <bucket-in-json> -f <csv-filename> -i <iteration>'


def main(argv):
   rrate = -1
   agap = -1
   path = "/tmp/"
   gadgets = "both"
   buckets = [0., .2, 1.]
   #buckets = [0., 0.1, 0.4, 1.]
   filename = None
   stimefname = None
   iterr = None
   try:
      opts, args = getopt.getopt(argv,"hr:g:p:c:b:f:s:i:",["relax_rate=","optimality_gap=", "path=", "count_gadgets=", "buckets=", "filename=", "stimefname=", "iteration="])
   except getopt.GetoptError:
      help()
      sys.exit(2)
   for opt, arg in opts:
      if opt == '-h':
          help()
          sys.exit()
      elif opt in ("-r", "--relax_rate"):
         rrate = arg
      elif opt in ("-g", "--optimality_gap"):
         agap = arg
      elif opt in ("-p", "--path"):
         path = arg
      elif opt in ("-c", "--count_gadgets"):
         gadgets = arg # has to be either both or max
      elif opt in ("-b", "--buckets"):
         buckets = json.loads(arg)
      elif opt in ("-f", "--filename"):
         filename = arg
      elif opt in ("-s", "--stimefname"):
         stimefname = arg
      elif opt in ("-i", "--iteration"):
         iterr = arg





   #print agap, rrate, path, gadgets, buckets, filename
   data, num, stime = read_files(agap, rrate, path, gadgets, iterr)
   stime_to_file(stime, stimefname)
   if (num > 1) :
       dbucks = data_to_buckets(data, buckets)
       bucks_to_csv(dbucks, buckets, num, filename)

if __name__ == "__main__":
   main(sys.argv[1:])


#sys.exit()


