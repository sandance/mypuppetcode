class admin::ntp {
	package { "ntp":
		ensure => installed,
		require => File["/etc/ntp.conf"],
	}

	service { "ntp":
		ensure => running,
		require => Package["ntp"],
	}
	file { "/etc/ntp.conf":
		source => "puppet:///modules/admin/ntp.conf",
		notify => Service["ntp"],
		require => Package["ntp"],
	}
}
