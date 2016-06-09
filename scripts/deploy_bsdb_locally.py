import os
import subprocess
import utilities

paths = utilities.get_paths("bsdb")
os.chdir(paths["java_dir"])

subprocess.call('javac -cp "%s":"%s":"%s" *.java' % (
 paths["jar_dir"],
 paths["class_dir"],
 paths["servlet_dir"]
), shell=True)

os.chdir(paths["app_dir"])
subprocess.call("jar -cvf ROOT.war *", shell=True)

subprocess.call("sudo rm -r %sROOT" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo rm -r %sROOT.war" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo mv ROOT.war %sROOT.war" % paths["tomcat_dir"], shell=True)
