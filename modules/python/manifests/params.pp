class python::params {
    include airsage::params

    $version = '2.7.7'
    $major_version = '2.7'
    $install_path = "/opt"
    $setuptools_version = "0.6c11"
    $pip_version = "1.1"
    $pip_repository = "http://${::airsage::params::package_node}/pip"
    case $::centosmajrelease {
        "7": {
            $gcc_version = '.x86_64'
            $readline_version = '.x86_64'
            $ncurses_version = '.x86_64'
            $zlib_version = '.x86_64'
            $bzip2_version = '.x86_64'
            $db4_version = '.x86_64'
            $tk_version = '.x86_64'
            $bluez_libs_version = '.x86_64'
            $sqlite_version = '.x86_64'
            # openssl version is now set to latest, so use of this variable should be considered deprecated
            $openssl_version = '.x86_64'
            $geos_version = '.x86_64'
            $python_tgz_name = ""
            $prefix = "/usr"
        }
        "6": {
            $gcc_version = '.x86_64'
            $readline_version = '-6.0-4.el6.x86_64'
            $ncurses_version = '-5.7-3.20090208.el6.x86_64'
            $zlib_version = '-1.2.3-29.el6.x86_64'
            $bzip2_version = '-1.0.5-7.el6_0.x86_64'
            $db4_version = '-4.7.25-18.el6_4.x86_64'
            $tk_version = '-8.5.7-5.el6.x86_64'
            $bluez_libs_version = '-4.66-1.el6.x86_64'
            $sqlite_version = '-3.6.20-1.el6.x86_64'
            # openssl version is now set to latest, so use of this variable should be considered deprecated
            $openssl_version = '-1.0.1e-16.el6_5.7.x86_64'
            $geos_version = '-3.3.9-1.rhel6.x86_64'
            #$geos_version = '-3.3.8-2.el6.x86_64' # this version was mistakenly put into production
            $python_tgz_name = "python${version}-Centos6.4.tgz"
            $prefix = "$install_path/python$version"
        }
        "5": {
            $gcc_version = ""
            $readline_version = ""
            $ncurses_version = ""
            $zlib_version = ""
            $bzip2_version = ""
            $db4_version = ""
            $tk_version = ""
            $bluez_libs_version = ""
            $sqlite_version = '-3.3.6-7'
            $openssl_version = ""
            $geos_version = ""
            $python_tgz_name = "python${version}-Centos5.9.tgz"
            $prefix = "$install_path/python$version"
        }
        default: { fail("No regex match found for ::centosmajrelease $::centosmajrelease in python params.pp.") }
    }

}
