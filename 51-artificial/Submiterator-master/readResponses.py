import os

adjectives = ["red", "green", "blue", "ADJ1", "ADJ2"]

alien = ["ADJ1", "ADJ2"]

color = ["red", "green", "blue"]

fileNames = os.listdir(".")
fileNames = filter(lambda x:x.endswith("-trials.tsv"), fileNames)

for fileName in fileNames:
  subjectInfo = map(lambda x:x.split("\t"), open(fileName.replace("trials","subject_information"), "r").read().strip().split("\n"))
  header = subjectInfo[0]
  subjectInfo = subjectInfo[1:]
  adjective1PerSubject = map(lambda x:x[header.index("adjective1")], subjectInfo)
  adjective2PerSubject = map(lambda x:x[header.index("adjective2")], subjectInfo)

  with open(fileName, "r") as inFile:
   inFile = inFile.read().split("\n")
   header = inFile[0]
   inFile = inFile[1:]
   with open(fileName.replace(".tsv","-postprocessed.tsv"),"w") as outFile:
    header = header.split("\t") + ["ADJ2OrADJ1First", "ADJ2OrColorFirst", "ADJ1OrColorFirst"]
    def getColumn(x,line):
      return line[header.index(x)]
    print >> outFile, "\t".join(header)

    for line in inFile:
       workerid = int(getColumn("workerid", line))
       adj1 = adjective1PerSubject[workerid]
       adj2 = adjective2PerSubject[workerid]

       line = line.strip().split("\t")
       if len(line) < 10:
         print("Skipping line (presumably has to do with newlines)")
         print(fileName)
         print(line)
         continue
       response = getColumn("enteredText", line)
       if response != "NA":
          response = response.replace(adj1, "ADJ1")
          response = response.replace(adj2, "ADJ2")
          response = response.split("NEW_LINE")
          response = response[0].split(" ")
          response = filter(lambda x:x in adjectives, response)          
          if len(response) > 3:
            print("Skip")
            print line
          #print() 
          alienResponse = filter(lambda x:x in alien, response)
          withColor = map(lambda x:"COLOR" if x in color else x, response)
          response = response + (["NA"] * (3-len(response)))

#          print([response,alienResponse, withColor])

          ADJ2OrADJ1First = "Q_"+("_".join(alienResponse))
          ADJ2OrColorFirst = "R_"+("_".join(filter(lambda x:(x in ["COLOR", "ADJ2"]), withColor)))
          ADJ1OrColorFirst = "S_"+("_".join(filter(lambda x:(x in ["COLOR", "ADJ1"]), withColor)))
          #print([response, ADJ2OrADJ1First, ADJ2OrColorFirst, ADJ1OrColorFirst])

          line = line + [ADJ2OrADJ1First, ADJ2OrColorFirst, ADJ1OrColorFirst]
       else:
          line = line + (["NA"] * (len(header) - len(line)))


       print >> outFile, "\t".join(line)
         
