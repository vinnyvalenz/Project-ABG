import os 
import math as m
import shutil

dir = "/home/saturn/ABG/ABG_classification/data/pngs"

adir = dir+"/anthro/"
bdir = dir+"/bio/"
gdir = dir+"/geo/"
odir = dir+"/other/"

names = ["anthro","bio","geo","other"]

for i in range(4):
    os.mkdir(dir+"/testing/"+names[i])
    os.mkdir(dir+"/validation/"+names[i])
    os.mkdir(dir+"/training/"+names[i])


af = os.listdir(adir)
bf = os.listdir(bdir)
gf = os.listdir(gdir)
of = os.listdir(odir)

# 50 imgs of each category for test
al = m.floor(len(af)/50)
bl = m.floor(len(bf)/50)
gl = m.floor(len(gf)/50)
ol = m.floor(len(of)/50)

for i in range(50):
    shutil.move(adir+af[i*al], dir+"/testing/anthro/")
    shutil.move(bdir+bf[i*bl], dir+"/testing/bio/")
    shutil.move(gdir+gf[i*gl], dir+"/testing/geo/")
    shutil.move(odir+of[i*ol], dir+"/testing/other/")

af = os.listdir(adir)
bf = os.listdir(bdir)
gf = os.listdir(gdir)
of = os.listdir(odir)

# 200 imgs of category ABG and 50 of O for test
al = m.floor(len(af)/200)
bl = m.floor(len(bf)/200)
gl = m.floor(len(gf)/200)
ol = m.floor(len(of)/50)

for i in range(200):
    shutil.move(adir+af[i*al], dir+"/validation/anthro/")
    shutil.move(bdir+bf[i*bl], dir+"/validation/bio/")
    shutil.move(gdir+gf[i*gl], dir+"/validation/geo/")

for i in range(50):
    shutil.move(odir+of[i*ol], dir+"/validation/other/")

af = os.listdir(adir)
bf = os.listdir(bdir)
gf = os.listdir(gdir)
of = os.listdir(odir)

for i in range(len(af)):
    shutil.move(adir+af[i], dir+"/training/anthro/")

for i in range(len(bf)):
    shutil.move(bdir+bf[i], dir+"/training/bio/")

for i in range(len(gf)):
    shutil.move(gdir+gf[i], dir+"/training/geo/")

for i in range(len(of)):
    shutil.move(odir+of[i], dir+"/training/other/")

