import maya.cmds as mc

scriptDr = mc.internalVar(userScriptDir = True)
fName = '{0}nodes.txt'.format(scriptDr)
f = open(fName, 'r')

minScale = 3
maxScale = 8

lineList = f.readlines()
matrix = []

ptList = []

for i in range(len(lineList)):

    pos = lineList[i].split(',')
    valR = float(pos[4])/255
    valG = float(pos[5])/255
    valB = float(pos[6])/255
    radi = float(pos[3])
    
    pt = mc.polySphere(sx=6, sy=6)
    mc.xform(pt, t = (float(pos[0]), float(pos[1]), float(pos[2])))
    mc.xform(pt, s = (radi, radi, radi))
    mc.polyColorPerVertex(pt, rgb = (valR, valG, valB))







