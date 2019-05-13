import rhinoscriptsyntax as rs
import random
import math
fName = rs.OpenFileName()
f = open(fName, 'r')

lineList = f.readlines()

obj = rs.GetObject("select component",32)
rs.EnableRedraw(False)
for i in range(len(lineList)):
    
    pos1 = lineList[i].split(',')
    
    p1 = [float(pos1[0]),float(pos1[1]), float(pos1[2])]
    p2 = [float(pos1[3]),float(pos1[4]), 0]
    p2 = rs.VectorUnitize(p2)
    p2 = rs.VectorScale(p2, float(pos1[6]))
    p2 = rs.VectorAdd(p2,p1)
    scal = float(pos1[6])
    if math.isnan(p1[0]) != True:
        
        newObj = rs.ScaleObject(obj, [0,0,0], [scal,scal,scal], copy = True)
        
        rs.OrientObject(newObj, [[0,0,0],[1,0,0]], [p1,p2])
        
rs.EnableRedraw(True)


