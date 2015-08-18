class python::prerequisites () inherits python::params {
    include airsage
    # Building Python from source requires most of these packages. At some point,
    # we should separate out the others.
    package { "gcc$python::params::gcc_version": ensure => installed }
    package { "gcc-c++$python::params::gcc_version": ensure => installed }
    package { "readline-devel$python::params::readline_version": ensure => installed }
    package { "ncurses-devel$python::params::ncurses_version": ensure => installed }
    package { "zlib-devel$python::params::zlib_version": ensure => installed }
    package { "bzip2-devel$python::params::bzip2_version": ensure => installed }
    case $::centosmajrelease {
        "7": {
            package { "libdb4.x86_64": ensure => installed }
            package { "libdb4-devel.x86_64": ensure => installed }
            package { "libdb4-cxx.x86_64": ensure => installed }
            package { "libdb4-cxx-devel.x86_64": ensure => installed }
            package { "libdb4-utils.x86_64": ensure => installed }
            package { "compat-db47.x86_64": ensure => installed }
        }
        /[5,6]/: {
            package { "db4-devel$python::params::db4_version": ensure => installed }
        }
    }
    package { "tk-devel$python::params::tk_version": ensure => installed }
    package { "bluez-libs-devel$python::params::bluez_libs_version": ensure => installed }
    package { "sqlite-devel":
        name => "sqlite-devel$python::params::sqlite_version",
        ensure => present
    }
    package { "e2fsprogs-devel": ensure => installed }
    package { "openssl-devel":
        ensure => latest
    }

    # Required by Shapely
    package {
        "geos-devel":
            name => "geos-devel$python::params::geos_version",
            ensure => installed,
            require => Yumrepo["Operations"],
    }
    package { "make": ensure => installed }
    package { "gdbm-devel": ensure => installed }

}
