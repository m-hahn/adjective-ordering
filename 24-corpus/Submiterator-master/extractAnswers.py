import os

fileNames = os.listdir(".")
fileNames = filter(lambda x:x.endswith("-trials.tsv"), fileNames)

for fileName in fileNames:
  with open(fileName, "r") as inFile:
   inFile = inFile.read().split("\n")
   header = inFile[0]
   inFile = inFile[1:]
   with open(fileName.replace(".tsv","-postprocessed.tsv"),"w") as outFile:
    header = header.split("\t") + map(lambda x:"response_"+str(x), range(0,6))
    def getColumn(x,line):
      return line[header.index(x)]
    print >> outFile, "\t".join(header)

    for line in inFile:
       line = line.strip().split("\t")
       if len(line) < 3:
         print("Skipping line (presumably has to do with newlines)")
         print(fileName)
         print(line)
         continue
       response = getColumn("response", line)
       response = response[1:-1].split(", ")
       line = line + response
       print >> outFile, "\t".join(line)


