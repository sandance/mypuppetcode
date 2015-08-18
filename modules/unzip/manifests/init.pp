class unzip () inherits unzip::params {
    include airsage
    package {
        "unzip${unzip_version}":
            ensure => installed,
    }
}
