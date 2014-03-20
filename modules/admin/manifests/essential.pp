class essential {
		package { ["cron","locate","lsof","rubygems","screen","sudo","unzip" ]:
				ensure => installed,
		}
}
