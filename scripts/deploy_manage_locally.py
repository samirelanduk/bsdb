import os
import subprocess
import utilities

paths = utilities.get_paths("manage")
os.chdir(paths["java_dir"])

subprocess.call('javac -source 1.6 -target 1.6 -cp "%s":"%s":"%s" *.java' % (
 paths["jar_dir"],
 paths["class_dir"],
 paths["servlet_dir"]
), shell=True)

os.chdir(paths["app_dir"])
subprocess.call("jar -cvf manage.war *", shell=True)

subprocess.call("sudo rm -r %smanage" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo rm -r %smanage.war" % paths["tomcat_dir"], shell=True)
subprocess.call("sudo mv manage.war %smanage.war" % paths["tomcat_dir"], shell=True)
