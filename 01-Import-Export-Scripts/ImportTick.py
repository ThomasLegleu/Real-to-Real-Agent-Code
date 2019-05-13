import maya.cmds as mc

scriptDr = mc.internalVar(userScriptDir = True)
fName = '{0}ticks.txt'.format(scriptDr)
f = open(fName, 'r')

lineList = f.readlines()

for i in range(len(lineList)):
    pos = lineList[i].split('/')
       
    start = pos[0].split(',')
    end = pos[1].split(',')
    startPt = [float(start[0]), float(start[1]), float(start[2])]
    endPt = [float(end[0]), float(end[1]), float(end[2])]
    newLine = mc.curve(p = [startPt,endPt], d = 1)


