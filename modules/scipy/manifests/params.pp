class scipy::params () {
    $scipy_version = "0.14.0"
    case $::hostname {
        /^devvm.*/: {
            $scipy_timeout = 1800
        }
        default: {
            $scipy_timeout = 900
        }
    }
    $scipy_packages = [
        'atlas.x86_64', 'atlas-devel.x86_64',
        'lapack.x86_64', 'lapack-devel.x86_64',
        'blas.x86_64', 'blas-devel.x86_64',
        'gcc-gfortran.x86_64'
    ]
}
