#Import Points from CSV
 
import rhinoscriptsyntax as rs
 
#Select a file to open
filename = rs.OpenFileName("Open CSV file","*.csv|", None, None, None)
 
#open the file for reading
file = open(filename, 'r')
 
lines = file.readlines()
 
file.close()
 
#delete the first line because it's a header
del lines[0]
#print to check the data
print(lines)
 
ptNumber = 0
 
for line in lines:
    #remove the \n
    line = line.strip()
    #split the line by the comma
    ptInfo = line.split(',')
    x = float(ptInfo[0])
    y = float(ptInfo[1])
    z = float(ptInfo[2])
    pt = rs.AddPoint(x,y,z)
