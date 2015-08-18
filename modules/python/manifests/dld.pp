# Class: python::dld
#
# Install require python packages for dld
#
# Sample usage:
#   include python 
#   include python::dld
#

class python::dld (
    ) inherits python::params {

    $scipy_packages = [
        'atlas.x86_64',
        'atlas-devel.x86_64',
        'lapack.x86_64',
        'lapack-devel.x86_64',
        'blas.x86_64',
        'blas-devel.x86_64',
        'gcc-gfortran.x86_64',
        'openssl.x86_64',
        'openssl-devel.x86_64'
    ]
    case $::centosmajrelease {
        "7": { fail("This module has not been updated for Centos 7.") }
    }
    
    package { 
        $scipy_packages:
            ensure => present,
    }
    
    ## Used by "dagjobs" script in back_crunching
    python::package {
        'pytz-2012h':
            package => 'pytz-2012h',
    }

    ## Used by "dagjobs" script in back_crunching
    python::package {
        'configobj':
            package => 'configobj==4.7.2',
    }

    python::package {
        'netlib':
            package => 'netlib==0.2.1',
    }

    python::package {
        'numpy':
            package => 'numpy==1.6.2',
    }
    
    python::package {
        'scipy':
            package => 'scipy==0.11.0',
            require => [Package[$scipy_packages], Python::Package['numpy']],
    }
    
    python::package {
        'scikit-learn':
            package => 'scikit-learn==0.12.1',
            require => Python::Package['scipy'],
    }

    python::package {
        'cdma':
            package => 'cdma==0.4.8',
    }

    python::package {
        'dld':
            package => 'dld==2.1.0',
            require => [Python::Package['cdma'], Python::Package['netlib']],
    }

    python::package {
        'odd':
            package => 'odd-0.9.2',
            require => Python::Package['scikit-learn'],
    }


}
