class numpy () inherits numpy::params {
    include airsage
    include python
    case $::centosmajrelease {
        "7": {
            package { "numpy.x86_64":
                ensure => present
            }
        }
        /[5,6]/: {
            python::package { 'numpy':
                    package => 'numpy',
                    version => "$numpy_version",
                    timeout => "$numpy_timeout",
            }
        }
    }
}
