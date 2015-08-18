# Class: python
#
# Install python from tar.gz
#
# Parameters:
#   ['install_path']       - Default to /opt
#   ['prefix']             - Default to /opt/python2.7.3
#   ['version']            - Default 2.7.3
#   ['major_version']      - Default 2.7
#   ['setuptools_version'] - Default "0.6c11"
#   ['pip_version']        - Default "1.1" Ensure pip 1.1 is installed. pip 1.2.1 broke compatibility with 1.1.
#
# Sample usage:
#   include python 
#   or
#   class {"python":}
#

class python (
        $install_path = $python::params::install_path,
        $prefix = $python::params::prefix,
        $version = $python::params::version,
        $major_version = $python::params::major_version,
        $setuptools_version = $python::params::setuptools_version,
        $pip_version = $python::params::pip_version
    ) inherits python::params {

    include airsage::params
    include python::prerequisites
    $repository = $airsage::params::package_node

    case $::centosmajrelease {
        "7": {
            package { "python.x86_64":
                ensure => present,
            }
            package { "python-setuptools":
                ensure => present,
            }
            package { "python-pip":
                ensure => present,
            }
            # For compatibility reasons
            file { "$install_path/python2.7":
                ensure => directory,
                mode   => '0755',
                owner  => 'root',
                group  => 'root',
            }
            file { 
                "$install_path/python2.7/wrap_python.sh":
                    ensure  => present,
                    content => template('python/wrap_python.sh'),
                    mode    => '0755',
                    require => File["$install_path/python2.7"];
                "$install_path/python2.7/activate_python.sh":
                    ensure  => present,
                    content => template('python/activate_python.sh'),
                    mode    => '0755',
                    require => File["$install_path/python2.7"];
                "$install_path/python2.7/setuptools_version.py":
                    ensure  => present,
                    source  => 'puppet:///modules/python/setuptools_version.py',
                    mode    => '0755',
                    require => File["$install_path/python2.7"];
                "$install_path/python2.7/package_version.py":
                    ensure  => present,
                    source  => 'puppet:///modules/python/package_version.py',
                    mode    => '0755',
                    require => File["$install_path/python2.7"];
            }
        }
        /[5,6]/: {
            $install_python = "wget -q http://${repository}/share/${python_tgz_name} -O - | tar xzf -"
            exec { 
                "$install_python":
                   path => "$prefix/bin:/bin:/usr/bin",
                   cwd => "$install_path",
                   creates => "$prefix/bin/python${major_version}",
                   logoutput => true,
            }
            
            file {
                "$install_path/python2.7":
                    ensure => link,
                    target => "$prefix",
                    require => Exec["$install_python"];
            }
            
            # Hack to make bad code that expects python in /opt/python2.7.3 work with python2.7.5
            file {
                "$install_path/python2.7.3":
                    ensure => link,
                    target => "$install_path/python2.7",
                    require => [Exec["$install_python"], File["$install_path/python2.7"]];
            }

            file { 
                "$prefix/wrap_python.sh":
                    ensure  => present,
                    content => template('python/wrap_python.sh'),
                    mode    => '0755',
                    require => Exec["$install_python"];
                "$prefix/activate_python.sh":
                    ensure  => present,
                    content => template('python/activate_python.sh'),
                    mode    => '0755',
                    require => Exec["$install_python"];
                "$prefix/setuptools_version.py":
                    ensure  => present,
                    source  => 'puppet:///modules/python/setuptools_version.py',
                    mode    => '0755',
                    require => Exec["$install_python"];
                "$prefix/package_version.py":
                    ensure  => present,
                    source  => 'puppet:///modules/python/package_version.py',
                    mode    => '0755',
                    require => Exec["$install_python"];
            }
            
            $install_setuptools = "wget -q --timestamping http://$repository/pip/setuptools-${setuptools_version}-py${major_version}.egg && sh setuptools-${setuptools_version}-py${major_version}.egg --prefix=$prefix --site-dirs=$prefix/lib/python${major_version}/site-packages"
            exec {
                "$install_setuptools":
                    cwd => "$prefix",
                    path => "$prefix/bin:/bin:/usr/bin",
                    environment => "LD_LIBRARY_PATH=$prefix/lib:\$LD_LIBRARY_PATH",
                    unless => "$prefix/wrap_python.sh $prefix/setuptools_version.py ${setuptools_version}",
                    logoutput => true,
                    require => File["$prefix/setuptools_version.py"],
            }


            $install_pip = "wget -q --timestamping http://$repository/pip/pip-${pip_version}.tar.gz &&  easy_install -U pip-${pip_version}.tar.gz"
            exec {
                "$install_pip":
                    cwd => "$prefix",
                    path => "$prefix/bin:/bin:/usr/bin",
                    environment => "LD_LIBRARY_PATH=$prefix/lib:\$LD_LIBRARY_PATH",
                    unless => "$prefix/wrap_python.sh $prefix/package_version.py pip ${pip_version}",
                    require => [ Exec["$install_setuptools"], File["$prefix/package_version.py"] ],
            }
        }
    }
}



