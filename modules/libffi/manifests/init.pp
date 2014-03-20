class libffi () inherits libffi::params {
#	exec { "apt-get update":
#		path => ["/usr/sbin","/usr/bin","/bin","/sbin"],
#	}
	
	package { "libffi-dev":
	#	version => $libffi_version,
		ensure => present,
	#	require => Exec["apt-get update"],
	}
	
#	notify("Libffi got installed on your machine")
}
