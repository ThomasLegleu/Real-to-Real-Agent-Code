import maya.cmds as mc

scriptDr = mc.internalVar(userScriptDir = True)
fName = '{0}faces.txt'.format(scriptDr)
f = open(fName, 'r')

lineList = f.readlines()

for i in range(  len(lineList)/2, len(lineList)):
    pos = lineList[i].split('/')
    if len(pos) == 5:
        ptList = []
        for j in range(0,4):
            temp = pos[j].split(',')
            newPt = [float(temp[0]), float(temp[1]), float(temp[2])]
            ptList.append(newPt)
        newFace = mc.polyCreateFacet(p = ptList)
        col = pos[4].split(',')
        mc.polyColorPerVertex(newFace, rgb = (float(col[0])/255, float(col[1])/255, float(col[2])/255))
    if len(pos) == 4:
        ptList = []
        for j in range(0,3):
            temp = pos[j].split(',')
            newPt = [float(temp[0]), float(temp[1]), float(temp[2])]
            ptList.append(newPt)
        newFace = mc.polyCreateFacet(p = ptList)
        col = pos[3].split(',')
        mc.polyColorPerVertex(newFace, rgb = (float(col[0])/255, float(col[1])/255, float(col[2])/255))