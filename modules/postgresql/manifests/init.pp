#####################
#	class {'postgresql':
#			version	=>'9.2',
#			manage_package_repo	=> true,
#	}
#
#
#
#
[*version] 
	The postgresql version to install . If not specified, the module will use whatever version is the default for your OS distro
[*manage_package_repo*] 
	This determines whether or not the module attempt to manage postgresql package repositiry for your distro. Defaults to "false" ,
	But if set to "true" , it can be used to setup the official postgres yum/apt package repositories for you.
[*package_source*]
	This setting is only used if 'manage_package_repo' is set to true. It determines which package repository should be used to install
	the postgres packages


