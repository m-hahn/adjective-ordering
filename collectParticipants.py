import os


exps = os.listdir(".")

for exp in exps:
  if os.path.isdir(exp):
     subpath = exp+"/Submiterator-master/"
     if os.path.isdir(subpath):
        files = os.listdir(subpath)
        done = filter(lambda x:x.endswith("success"), files)
        total = 0
        men = 0
        women = 0
        for name in done:
           with open(subpath+name, "r") as inFile:
              text = inFile.read().strip()
              if text == "NONE":
                continue
           subjinfo = subpath+name.replace(".success", "-subject_information.tsv")
           if not os.path.isfile(subjinfo):
              print "ERROR "+subjinfo
              continue
           with open(subjinfo, "r") as inFile:
               table = map(lambda x:x.split("\t"), inFile.read().strip().split("\n"))
               header = table[0]
               table = table[1:]
               total += len(table)
               if "gender" in header:
                 gender = header.index("gender")
                 gender = map(lambda x:x[gender], table)
                 #print gender
                 for x in gender:
                    if x == "Male":
                       men += 1
                    elif x == "Female":
                       women += 1
                 
        print "\t".join(map(str,[exp, exp[:exp.index("-")], total, men, women]))

