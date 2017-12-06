# Note: somehow gets into trouble when there are transforms, presumably because transforms for individual paths are not considered.
# Use https://github.com/Klowner/inkscape-applytransforms to get rid of transforms.


from svg.path import Path, Line, Arc, CubicBezier, QuadraticBezier, parse_path

svg = open("windows.svg", "r").read()

svg = svg.split("<g")

initial = svg[0]
final = svg[-1].split("</g>")
svg[-1] = final[0]+"</g>"
final = final[1]

import re
pattern = re.compile('transform="translate\((.*),(.*)\)"')
groups = map(lambda x:"<g\n"+x, svg[1:])

pattern2 = re.compile('(.*)transform="translate\((.*),(.*)\)"(.*)', re.DOTALL)

groupIndices = {}

print("INITIAL GROUPS "+str(len(groups)))
for group in groups:
   groupLines = group.split("\n")
   paths = filter(lambda x:" d=" in x, groupLines)
   paths = map(lambda x:x.split(" "), paths)
   minima = [100000000000000000000000000000,100000000000000000000000000]
   maxima = [-100000000000000000000000000000,-100000000000000000000000000]

   #     originalEntry = 
   if "transform=" in group:
        assert False
        results = pattern2.findall(group)
        if results is None:
            xTransform, yTransform = 0.0, 0.0
        else:
    
          pre = results[0][0]
#          xTransform = float(results[0][1])
 #         yTransform = float(results[0][2])
          post = results[0][3]
          group = pre+post

   else:
        xTransform = 0.0
        yTransform = 0.0

   datapoints = False
   for path in paths:
      #print " ".join(path)
      svgPath = parse_path(" ".join(path))
      PRECISION = 10
      for i in range(0, PRECISION):
         node = svgPath.point(i / float(PRECISION), error=1e-1)
         node = [node.real, node.imag]
         maxima = map(max,zip(node,maxima)) 
         minima = map(min,zip(node,minima)) 


##      start = svgPath.point(0.0, error=1e-3)
# #     mid = svgPath.point(0.5, error=1e-3)
#
#      node1 = [start.real, start.imag]
#      node2 = [mid.real, mid.imag]
#
#      maxima = map(max,zip(node2,maxima)) 
#      minima = map(min,zip(node2,minima)) 
      datapoints = True
   if datapoints:
      print (minima, maxima)
      groupIndices[group] = (minima, maxima)

print("INDICES")
print(len(groupIndices))

print( "AT 61")
print(len(groups))

def overlapRow(group1, group2):
   ySpan1 = (groupIndices[group1][0][1], groupIndices[group1][1][1])
   ySpan2 = (groupIndices[group2][0][1], groupIndices[group2][1][1])
#   print ".."
#   print ySpan1
#   print ySpan2
   overlapStart = max(ySpan1[0], ySpan2[0])
   overlapEnd = min(ySpan1[1], ySpan2[1])
   overlapLength = max(0, overlapEnd-overlapStart)
#   print overlapStart
#   print overlapEnd
#   print "LENGTH "+str(overlapLength)
   length1 = ySpan1[1] - ySpan1[0]
   length2 = ySpan2[1] - ySpan2[0]
#   print ["lengths", length1, length2]

   assert length1 > 0
   assert length2 > 0
#   print overlapLength / min(length1, length2)

   return overlapLength / min(length1, length2)


haveNotBeenSelected = list(groupIndices.keys())


rows = []
print("GROUPS "+str(len(haveNotBeenSelected)))

while len(haveNotBeenSelected) > 0:
   newGroup = haveNotBeenSelected[0]
   del haveNotBeenSelected[0]
   sameRow = filter(lambda x:overlapRow(newGroup,x) > 0.01, haveNotBeenSelected) + [newGroup]
   haveNotBeenSelected = filter(lambda x:x not in sameRow, haveNotBeenSelected)
   rows.append(sameRow)

def minX(group):
  return groupIndices[group][0][0]
def minY(group):
  return groupIndices[group][0][1]
def maxX(group):
  return groupIndices[group][1][0]
def maxY(group):
  return groupIndices[group][1][1]


rows = sorted(rows, key=lambda x: minY(x[0]))
print("Y_mins")
print(map(lambda x: minY(x[0]), rows))
print("Lengths")
print(map(len, rows))
rows = map(lambda x:sorted(x, key=minX), rows)
for row in rows:
   print("MINX "+str(map(minX, row)))

if len(rows[-1]) == 1:
   rows[-2] = rows[-2][:7] + [rows[-1][0]] + rows[-2][7:]
   del rows[-1]

print(filter(lambda x:len(x) == 1, rows))

rowNames = ["1", "2","3","4","5"]
assert len(rows) == len(rowNames)
colNames = ["green-saucer", "green-rocket", "red-saucer", "red-rocket", "blue-saucer", "blue-rocket"]

for row, rowName in zip(rows, rowNames):
  for index, entry in zip(range(len(row)),row):
     modifiedInitial = initial+""
     indexStart = modifiedInitial.index("viewBox=")
     indexEnd = indexStart+modifiedInitial[indexStart:].index("\n")
     x_min = minX(entry)-10
     y_min = minY(entry)-10
     x_max = maxX(entry)+10
     y_max = maxY(entry)+10
     lengthX = x_max-x_min
     lengthY = y_max-y_min
     newLength = max(lengthX, lengthY)
     dLengthX = newLength - lengthX
     dLengthY = newLength - lengthY
     x_min -= 0.5 * dLengthX
     y_min -= 0.5 * dLengthY
     lengthX, lengthY = newLength, newLength
     modifiedInitial = modifiedInitial[:indexStart]+'viewBox="'+" ".join(map(str,[x_min, y_min, lengthX, lengthY]))+'"'+modifiedInitial[indexEnd:]
     print 'viewBox="'+" ".join(map(str,[x_min, y_min, x_max-x_min, y_max-y_min]))
     with open("AUTO-"+rowName+"-"+colNames[index]+".svg", "w") as outFile:
       print >> outFile, modifiedInitial+"\n"+entry+"\n"+final+"\n"


