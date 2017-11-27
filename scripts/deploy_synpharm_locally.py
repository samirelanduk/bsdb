import os
import subprocess
import utilities

paths = utilities.get_paths("synpharm")
os.chdir(paths["java_dir"])

subprocess.call('javac -source 1.6 -target 1.6 -cp "%s":"%s":"%s" *.java' % (
 paths["jar_dir"],
 paths["class_dir"],
 paths["servlet_dir"]
), shell=True)

os.chdir(paths["app_dir"])
subprocess.call("jar -cvf ROOT.war *", shell=True)

subprocess.call("sudo rm -r %sROOT" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo rm -r %sROOT.war" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo cp ROOT.war %sROOT.war" % paths["tomcat_dir"], shell=True)
