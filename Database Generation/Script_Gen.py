import random

course_list = []

fd = open("Course_list.txt","r")

str = fd.readline()
while str != "":
    str = str.split("\t")[0]
    course_list.append(str)
    str = fd.readline()

fd.close()
    
fd = open("Script.txt", "w")
fd.write("CREATE DATABASE TA_Apps;\n")
fd.write("USE TA_Apps;\n\n")
fd.write("CREATE TABLE Students (sid CHAR(5), PRIMARY KEY(sid));\n")

for i in range(1,101):
    fd.write("INSERT INTO Students VALUES (\"S" + "{0:0=4d}".format(i) + "\");\n")

fd.write("\n")
fd.write("CREATE TABLE Professors (pid CHAR(5), PRIMARY KEY(pid));\n")

for i in range(1,101):
    fd.write("INSERT INTO Professors VALUES (\"P" + "{0:0=4d}".format(i) + "\");\n")

fd.write("\n")
fd.write("CREATE TABLE Courses (cid CHAR(5), cnumber CHAR(7), PRIMARY KEY(cid));\n")

for i in range(1,101):
    fd.write("INSERT INTO Courses VALUES (\"C" + "{0:0=4d}".format(i) + "\",\"" + course_list[i-1] + "\");\n")

fd.write("\n")
fd.write("CREATE TABLE Apps (appid CHAR(5), sid CHAR(5), pid CHAR(5), cid CHAR(5), " + \
         "PRIMARY KEY(appid), " + \
         "FOREIGN KEY(sid) REFERENCES Students(sid), " + \
         "FOREIGN KEY(pid) REFERENCES Professors(pid), " + \
         "FOREIGN KEY(cid) REFERENCES Courses(cid));\n")

for i in range(1,101):
    temps = [random.randint(1,100), random.randint(1,100), random.randint(1,100)]
    fd.write("INSERT INTO Apps Values (\"A" + "{0:0=4d}".format(i) + "\"," + \
             "\"S" + "{0:0=4d}".format(temps[0]) + "\"," + \
             "\"P" + "{0:0=4d}".format(temps[1]) + "\"," + \
             "\"C" + "{0:0=4d}".format(temps[2]) + "\");\n")
    
fd.close()
