class admin::exim {

	if $lsbdistid == "Ubuntu" {
		notice("Running on Ubuntu")
	}
	elsif $lsbdistid == "Debian" {
		notice("Close enough")
	}
	else {
		notice("Non-Ubuntu system detected.")
	}

	if $lsbdistdescription =~ /LTS/ {
		notice("Looks like you are using a Long Term Support version of	Ubuntu.")
	}
	else {
		notice("You might want to upgrade to a Long Term Support")
	}
	
	package { "exim4":
		ensure => installed,
	}
	
	service { "exim4":
		ensure => running,
		require => Package["exim4"],
	}
	
	file { "/etc/exim4/exim4.conf":
			content => template("admin/exim4.conf"),
			notify  => Service["exim4"],
			require => Package["exim4"],
	}
}

