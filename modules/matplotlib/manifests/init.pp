class matplotlib () inherits matplotlib::params {
	package { 'python-pip':
			ensure => installed,
	}

	package { 'matplotlib':
			ensure => present,
			provider => pip,
		#	version => $matplotlib_version,
			require => Package["python-pip"],
	}

	
#	exec { "apt-get update":
#			path => ["/usr/bin","/usr/sbin","/bin","/sbin"],
#	}

	package { ["libfreetype6-dev","libpng-dev"]:
			ensure => installed,
			require => Package["matplotlib"],
	}	
}	 
