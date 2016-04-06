import os
import subprocess

bsdb_dir = "/home/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/bsdb"
class_dir = bsdb_dir + "/WEB-INF/classes"
jar_dir = bsdb_dir + "/WEB-INF/lib/mysql-connector.jar"
java_dir = class_dir + "/org/bsdb"
tomcat_dir = "/var/lib/tomcat7/webapps/"

try:
    os.chdir(java_dir)
except FileNotFoundError:
    bsdb_dir = "/Users/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/bsdb"
    class_dir = bsdb_dir + "/WEB-INF/classes"
    jar_dir = bsdb_dir + "/WEB-INF/lib/mysql-connector.jar"
    java_dir = class_dir + "/org/bsdb"
    tomcat_dir = "/usr/local/tomcat/webapps/"
    os.chdir(java_dir)

subprocess.call('javac -cp "%s":"%s" *.java' % (jar_dir, class_dir), shell=True)

os.chdir(bsdb_dir)
subprocess.call("jar -cvf bsdb.war *", shell=True)

subprocess.call("sudo rm -r %sROOT" % tomcat_dir, shell=True)
subprocess.call("sudo rm -r %sROOT.war" % tomcat_dir, shell=True)
subprocess.call("sudo mv bsdb.war %sROOT.war" % tomcat_dir, shell=True)
