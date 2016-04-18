import os
import subprocess

bsdb_dir = "/home/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/manage"
class_dir = bsdb_dir + "/WEB-INF/classes"
jar_dir = bsdb_dir + "/WEB-INF/lib/postgresql-connector.jar"
java_dir = class_dir + "/org/bsdbmanage"
tomcat_dir = "/var/lib/tomcat7/webapps/"
servlet_dir = "/usr/share/tomcat7/lib/servlet-api.jar"

try:
    os.chdir(java_dir)
except FileNotFoundError:
    bsdb_dir = "/Users/sam/Dropbox/WORK/Inverse pharmacology project/bsdb/manage"
    class_dir = bsdb_dir + "/WEB-INF/classes"
    jar_dir = bsdb_dir + "/WEB-INF/lib/postgresql-connector.jar"
    java_dir = class_dir + "/org/bsdbmanage"
    tomcat_dir = "/usr/local/tomcat/webapps/"
    os.chdir(java_dir)

subprocess.call('javac -cp "%s":"%s":"%s" *.java' % (jar_dir, class_dir, servlet_dir), shell=True)

os.chdir(bsdb_dir)
subprocess.call("jar -cvf manage.war *", shell=True)

subprocess.call("sudo rm -r %smanage" % tomcat_dir, shell=True)
subprocess.call("sudo rm -r %smanage.war" % tomcat_dir, shell=True)
subprocess.call("sudo mv manage.war %smanage.war" % tomcat_dir, shell=True)
