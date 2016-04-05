import os
import subprocess

bsdb_dir = "/home/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/bsdb"
tomcat_dir = "/var/lib/tomcat7/webapps/"

try:
    os.chdir(bsdb_dir)
except FileNotFoundError:
    bsdb_dir = "/Users/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/bsdb"
    tomcat_dir = "/usr/local/tomcat/webapps/"

os.chdir(bsdb_dir)
subprocess.call("jar -cvf bsdb.war *", shell=True)

subprocess.call("sudo rm -r %sROOT" % tomcat_dir, shell=True)
subprocess.call("sudo rm -r %sROOT.war" % tomcat_dir, shell=True)
subprocess.call("sudo mv bsdb.war %sROOT.war" % tomcat_dir, shell=True)
