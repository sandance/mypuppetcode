class matplotlib () inherits matplotlib::params {
    include airsage
    include python
    case $::centosmajrelease {
        "7": {
            package { "python-matplotlib.x86_64":
                ensure => present,
            }
        }
        /[5,6]/: {
            package { $matplotlib_dependencies:
                ensure => present,
                require => Yumrepo["Operations"],
            }
            python::package {
                'matplotlib':
                    package => 'matplotlib',
                    version => "$matplotlib_version",
                    require => [
                        Package[$matplotlib_dependencies]
                    ],
            }
        }
        default: { fail("No match for centosmajrelease: $::centosmajrelease .") }
    }
}
