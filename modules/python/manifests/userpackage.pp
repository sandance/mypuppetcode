#   This function installs a package into the user environment.
#
# Parameters:
#   [*user*]  - The user that will install the package.
#   [*prefix*]  - The path to the installation directory.
#   [*python_prefix*]  - The path to python bin/ and lib/ directories.
#   [*package*]  - The name of the package(s).
#
# Actions:
#
# Requires:
#
# Sample Usage:
#
include python::params

define python::userpackage (
    $user,
    $prefix,
    $package,
    $creates = "",
    $pip_options = "--no-index",
    $python_prefix = $python::params::prefix,
    $pip_repository = $python::params::pip_repository
) {

    $install = "${python_prefix}/bin/pip install ${pip_options} --install-option='--prefix=${prefix}' -f $pip_repository ${package}"
    exec {
        "$install":
            path => "$python_prefix/bin:/bin:/usr/bin",
            environment => "LD_LIBRARY_PATH=$python_prefix/lib:\$LD_LIBRARY_PATH",
            user => $user,
            cwd => "$prefix",
            creates => $creates,
            logoutput => true,
            require => Class["python"];
    }
}

