class scipy () inherits scipy::params {
    include airsage
    include python
    include numpy
    case $::centosmajrelease {
        "7": {
            package { "scipy.x86_64":
                ensure => present,
            }
        }
        /[5,6]/: {
            package { $scipy_packages:
                ensure => present,
                require => Yumrepo["Operations"],
            }
            python::package {
                'scipy':
                    package => 'scipy',
                    version => "$scipy_version",
                    timeout => "$scipy_timeout",
                    require => [
                        Package[$scipy_packages],
                        Python::Package['numpy'],
                    ],
            }
        }
    }
}
