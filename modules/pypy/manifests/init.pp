class pypy {
    case $::centosmajrelease {
        "7": {
            package { 'pypy.x86_64':
                ensure => present,
                require => Yumrepo["Operations"],
            }
            package { 'pypy-devel.x86_64':
                ensure => present,
                require => Yumrepo["Operations"],
            }
        }
        /[5,6]/: {
            $pkgname = 'pypy'
            case $::centosmajrelease {
                "6": {
                    $version = "2.0.2-Centos6.4"
                }
                "5": {
                    $version = "2.0.2-Centos5.9"
                }
                default: { fail("No regex match found for ::centosmajrelease $::centosmajrelease in pypy init.pp.") }
            }
            $file_name = "${pkgname}-${version}.tgz"
            $prefix = "/opt"
            $install_dir = "${prefix}/${pkgname}-${version}"
            $pypy_executable = "$install_dir/pypy/goal/pypy-c"
            $timeout = 300
            
            package { 'pypy':
                ensure => absent,
                require => Yumrepo["Operations"],
            }

            exec {
                "install ${pkgname}":
                    timeout => $timeout,
                    cwd => $prefix,
                    creates => "${prefix}/${pkgname}-${version}/${pkgname}-${version}-complete",
                    command => "wget -q http://${airsage::params::package_node}/pkg/${file_name} -O - | tar -xzf - && touch ${prefix}/${pkgname}-${version}/${pkgname}-${version}-complete",
                    path => ["/bin", "/sbin", "/usr/bin", "/usr/sbin"],
            }

            file { '/usr/bin/pypy':
               ensure => 'link',
               target => $pypy_executable,
               require => Exec["install ${pkgname}"],
            }
        }
    }

}
