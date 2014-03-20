$systemtype = $operatingsystem ? {
	"Ubuntu" => "debianlike",
	"Debian" => "debianlike",
	"RedHat" => "redhatlike",
}

notify { "You have a ${systemtype} system": }

class debianlike {
	notify { "Special manifest for debian like system": }
}

class redhatlike {
notify { "Special manifest for RedHat-like systems": }
}

case $operatingsystem {
	"Ubuntu",
	"Debian": {
		include debianlike
		}
	"RedHat",
	"Fedora",
	"CentOS": {
		include redhatlike
	}
}
