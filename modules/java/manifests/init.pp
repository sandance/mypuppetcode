class java {
	include apt
	include stdlib
		
#	apt::ppa { 'ppa:ferramroberto/java': }
	
	#file { "/etc/apt/sources.list" :
	#		source => "puppet:///etc/apt/sources.list"
#	}

	package { "python-software-properties":
			ensure => installed,
	#	#	path => ["/usr/sbin" ,"/usr/bin","/sbin", "/bin"],
	}
	
	apt::ppa { 'ppa:sun-java-community-team/sun-java6': }
	apt::ppa { 'ppa:ferramroberto/java': }
	
	exec { "apt-get update":
			path => ["/usr/sbin" ,"/usr/bin","/sbin", "/bin"],
		#	subscribe => File ["/etc/apt/sources.list"],
	}

	file { "/var/cache/debconf/sun-jdk6.pressed":
			source => "/etc/sun-java-6/sun-jdk6.pressed",
			ensure => present,
	}

	package { "sun-java6-jdk":
			ensure => installed,
		#	responsefile => "/var/cache/debconf/sun-jdk6.pressed",
			require => [File["/var/cache/debconf/sun-jdk6.pressed"]],
	}

	# Ensure we have sun-java set as default alternatives 


	exec { "update-java-alternatives -s --set java-6-sun":
			path => ["/usr/sbin","/usr/bin","/bin","/sbin"],
			require => Package["sun-java6-jdk"],
	}
}
