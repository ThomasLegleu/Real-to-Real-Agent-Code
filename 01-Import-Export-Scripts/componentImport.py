import maya.cmds as mc

scriptDr = mc.internalVar(userScriptDir = True)
fName = '{0}nodesVel.txt'.format(scriptDr)
f = open(fName, 'r')

minScale = 3
maxScale = 8

lineList = f.readlines()

comp = 'pPyramid3'

for i in range(len(lineList)):

    pos = lineList[i].split(',')
    valR = float(pos[7])/255
    valG = float(pos[8])/255
    valB = float(pos[9])/255
    radi = float(pos[6])
    newObj = mc.duplicate(comp)
    mc.xform(newObj, t = (float(pos[0]), float(pos[1]), float(pos[2])))
    mc.xform(newObj, s = (radi, radi, radi))
    mc.polyColorPerVertex(newObj, rgb = (valR, valG, valB))







