import re
from capstone import *
from subprocess import *
import os, sys
import cPickle as pickle
import math


import json
import getopt
from elftools.elf.elffile import ELFFile

pat = r"(0x[0-9a-fA-F]+) : (.*)"

def filter_nops(code): return filter(lambda x: x != 'nop', code)
def strip(code): return map(lambda x: x.strip(), code)

if (len(sys.argv) < 3):
    print "Give as argument the path with the compiled binaries"
    print "python jop_rc.py <path-to-dot-o-files> <filename> <arch> <iter>"
    exit(0) 


path = sys.argv[1]
filename = ".".join(sys.argv[2].split(".")[:-1])
arch = sys.argv[3]
iterr = int(sys.argv[4])

# Open a file
dirs = os.listdir( path )

def calc_stats(summa, d):
    s = sum(summa)
    c = len(summa)
    avg = s/c
    std = [(i-avg)**2 for i in summa]
    std = math.sqrt(sum(std)/(len(std)-1))  if len(std) > 1 else 0.
    conf = 2.* std/math.sqrt(len(summa)) if len(summa) > 0 else 0.

    #data
    df = dict()
    for i in summa:
        if df.has_key(i):
            df[i] += 1
        else:
            df[i] = 1

    d["data"] = df
    d["summa"] = s
    d["count"] = c
    d["avg"] = avg
    d["std"] = std
    d["conf"] = conf

# def levenshtein_distance(s, t):
#         d = [[0 for i in range(len(s)+1)] for j in range(len(t)+1)]
#         for i in range(1, len(s)+1):
#                 d[0][i] = i
#         for i in range(1, len(t)+1):
#                 d[i][0] = i
# 
#         for i in range(1, len(s)+1):
#                 for j in range(1, len(t)+1):
#                         subcost = 0 if s[i-1] == t[j-1] else 1
#                         d[j][i] = min( d[j-1][i] + 1, d[j][i-1] +1 , d[j-1][i-1] + subcost)
# 
#         return d[-1][-1]
# 

# def reverse_order(c):
#         # print c
#         # exit(0)
#         d = [0 for _ in range(max(c))]
#         for i,ci in enumerate(c):
#                 if (ci == -1):
#                         continue
#                 d[ci-1] = i
#         return d
# 

# def distances(fil):
#     registers = fil['registers']
#     cyc = fil['cycles']
#     precycles = [ (c,j) for  c,j  in zip(fil['global_cycles'],fil['type']) if fil.has_key("global_cycles") and fil.has_key("type") and j in [0,1,2,3,4,14]] 
#     cycles = [ c for c,_ in precycles ]
#     prebrcycles = [ (i,c) for  i,(c,t)  in enumerate(precycles) if t in [1,2,3]]
# 
#     doublebrcycles = {j:(prebrcycles[j-1][0] if j>0 else 0)  for  j,(i,c)  in enumerate(prebrcycles) }
# 
#     brcycles = [ c for  i,c  in prebrcycles]
#     #####################
# 
#     levcycles = reverse_order(cycles)
#     #stime = fil['solver_time'] if fil.has_key('solver_time') else -1
#     #cost = fil['cost'] if fil.has_key('cost') else -1
#     
#     return {'cycles': cycles, 'brcycles': brcycles, 'prebrcycles': prebrcycles, 'doublebrcycles': doublebrcycles, 'levcycles': levcycles, 'registers': registers, 'cyc': cyc } 


#def update_dict(d, d1, d2, srate):
#    if srate in d:
#        d[srate].add(((tuple(d1['cyc']), tuple(d2['cyc'])), (tuple(d1['registers']), tuple(d2['registers']))))
#    else:
#        d[srate] = set(((tuple(d1['cyc']),tuple(d2['cyc'])), (tuple(d1['registers']), tuple(d2['registers']))))



files = dict()
jsonfiles = dict()
mncount = 0
maxnum = 0
for fil in dirs:
    if fil.endswith("%d.o"%iterr):
        #print fil
        try:
            num = int(fil.split(".")[0])
        except:
            continue
        newfile = os.path.join(path, fil)
        files[num] = newfile
    if fil.endswith("%d.out.json"%iterr):
        try:
            num = int(fil.split(".")[0])
            if num > maxnum:
                maxnum = num
        except: 
            continue
        newfile = os.path.join(path, fil)
        jsonfiles[num] = newfile

#print files
d = dict()
#print "Number divs", len(files)
d['numdivs'] = len(files)

def get_divtime(files):
    maxi = max(files.keys())
    maxfil = files[maxi]
    jsonfil = json.load(open(maxfil))
    res = int(jsonfil['solver_time'])
    return res

d['divtime'] = get_divtime(jsonfiles)
# print files

pat2 = r".*Gadgets information\n=+\n(.*)Unique gadgets found: ([0-9]+).*"
t = [ [ 0. for i in files ] for j in files ] 
res = []
filenums = sorted(files.keys())
#d_rc = dict()


for iinp, ii in enumerate(filenums): 
    print filenums
    inp = files[ii]
    with open(inp, 'rb') as f:
        text_section = ELFFile(f).get_section_by_name(".text")
    text_start = text_section.header.sh_offset
    text_end = text_start + text_section.header.sh_size
    if arch == "thumb":
        command = "ROPgadget --range %s-%s --binary %s --rawArch arm --rawMode thumb --rawEndian little --nosys" %(hex(text_start), hex(text_end), inp)
    elif arch == "mips":
        command = "ROPgadget --range %s-%s --binary %s --rawArch mips --rawMode 32 --rawEndian little --nosys" %(hex(text_start), hex(text_end), inp)
    else:
        print "Wrong architecture. Supported architectures are <thumb|mips>"
        exit(1)
    # for non-thumb arm archs: command = "ROPgadget --range %s-%s --binary %s --rawArch arm --rawMode 32 --rawEndian little --nosys" %(hex(text_start), hex(text_end), inp)
    p1 = Popen(command.split(), stdout=PIPE)
    output,err = p1.communicate()
    print command, output

    out, numbergadgets = re.match(pat2, output, re.DOTALL).groups()
    numbergadgets = int(numbergadgets)

    if numbergadgets == 0:
        continue
    a = [re.match(pat,i).groups() for i in filter(lambda x: x!='', out.split("\n"))]

    b = [ (i,strip(j.split(";"))) for i,j in a]

    c = [ (int(i,16), filter_nops(j)) for i,j in b]

    addresses, code = zip(*c)
    maxgad = 20*4

    ## open json
    #jsinp = jsonfiles[ii]
    
    #jsinpfil = json.load(open(jsinp))
    #fil1 = distances(jsinpfil)

    

    ## Not working need to take care of headers etc
    for iinp2, i2 in enumerate(filenums):
        if iinp2 == iinp: continue

        inp2 = files[i2]
        #if inp == inp2: break

        fil = open(inp2, "rb").read()
        if arch == "thumb":
            md = Cs(CS_ARCH_ARM, CS_MODE_THUMB + CS_MODE_LITTLE_ENDIAN)
        elif arch == "mips":
            md = Cs(CS_ARCH_MIPS, CS_MODE_MIPS32 + CS_MODE_LITTLE_ENDIAN)
        else:
            print "Give architecture <thumb|mips>"
            exit(1)

        count = 0.0
        for i,ad in enumerate(addresses):
            code2 = []
            for cod in md.disasm(fil[ad:ad+maxgad], ad):    
                code2.append("%s %s" %(cod.mnemonic,cod.op_str))
            code2 = filter_nops(strip(code2))
            for j, ci in enumerate(code[i]):
                if len(code2) <= j or ci != code2[j]:
                    break
            else:
                count += 1.0

        t[iinp][iinp2] = count/(1.0*numbergadgets)
        res.append((count, numbergadgets))

        #jsinp2 = jsonfiles[i2]
    
        #jsinpfil2 = json.load(open(jsinp2))
        #fil2 = distances(jsinpfil2)
        #dist = compare_dist(fil1, fil2)
        #if sum(zip(*dist.items())[1])>20 and t[iinp][iinp2]>0.5:
        #    print "Interesting", dist, t[iinp][iinp2] 
        #    print filename, inp, inp2

        #update_dict(d_rc, fil1, fil2, t[iinp][iinp2])
        # create_dict(dist_vs_gadgets, dist, t[iinp][iinp2])
        #create_point_dict(dist_vs_gadgets_points, dist, t[iinp][iinp2])
        


#for inp in d:
if (len(res) ==  0): 
    print "No results generated. Exiting..."
    exit(0)

c,ng = zip(*res)
#print "All Count", sum(c)
d["all_count"] = sum(c)
#print "All Gadgets", sum(ng) 
d["all_gadgets"] = sum(ng)
#d["rc"] = d_rc



summa = []
for i in range(len(t)):
    for j in range(i+1,len(t)):
        summa.append(max(t[i][j],t[j][i]))

d["max"] = dict()
calc_stats(summa, d["max"])

summa = []
for i in range(len(t)):
    for j in range(len(t)):
        if j==i: continue
        summa.append(t[i][j])

d["both"] = dict()
calc_stats(summa, d["both"])

pickle.dump(d, open(os.path.join(path , filename + "_" + str(iterr) + "_result.pickle"), "w"))


# 
# try:
#     opts, args = getopt.getopt(sys.argv[1:],"hp:",["pathname="])
# except getopt.GetoptError:
#     print "$ python calculate.py -p <path of the measurments>"
#     # print 'test.py -i <inputfile> -o <outputfile>'
#     sys.exit(2)
# 
# for opt, arg in opts:
#     if opt == '-h':
#         print "$ python calculate.py -p <path of the measurments>"
#         sys.exit()
#     elif opt in ("-p", "--pathname"):
#         pathname = arg
#         print "path", opt, arg
#     else:
#         print "Not correct", opt




