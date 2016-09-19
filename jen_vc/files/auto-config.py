import os,time,urllib2
time.sleep(15)
timing=0
while timing <= 30:
	try:
		if urllib2.urlopen('http://127.0.0.1:8080/login').getcode() == 200:
			os.chdir('/files')
			init_pass = os.popen('cat /var/lib/jenkins/secrets/initialAdminPassword').read()
	                os.system('curl -O http://127.0.0.1:8080/jnlpJars/jenkins-cli.jar')
			with open('plugins_name') as f:
				plugins_list = map(str.rstrip, f)
			for plugin_name in plugins_list:
				print plugin_name				
				os.system('java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ install-plugin '+plugin_name+' --username admin --password '+init_pass)
			os.system('java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ restart --username admin --password '+init_pass)
                        time.sleep(60)
                        os.system('java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ create-job tomcat-ci < tomcat_ci.xml --username admin --password '+init_pass)
                        os.system('java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ create-job nexus-ci < nexus_ci.xml --username admin --password '+init_pass)
			os.system('java -jar jenkins-cli.jar -s http://127.0.0.1:8080/ groovy ldap.gr --username admin --password '+init_pass)
			exit(0)
		else:
			time.sleep(1)
			timing+=1

	except IOError, e:
          		time.sleep(1)
	       		timing+=1
