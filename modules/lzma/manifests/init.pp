class lzma inherits lzma::params {
		
		exec { "apt-get update":
				path => ["/usr/bin","/usr/sbin","/bin","/sbin"],
		}
		
		package { [$xz_version,$pyliblzma_version] :
					ensure => present,	
		}
}
