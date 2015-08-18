# Installs a Python package using the Python version installed under /opt.
# If py_username is provided, installs to that user account. Otherwise
# installs globally.
#
# The version check assumes that the package name can be import-ed in Python
# once it's installed. TODO: Add an optional parameter to specify the internal
# module name if it's different from the package name (e.g. "Genshi" vs.
# "genshi").
#
# TODO: It'd be nice if the caller could pass in additional requirements besides
# the automatic ones computed here. This is tricky (or impossible?!) in the
# Puppet language but should be straightforward in the Puppet Ruby DSL.

define python::package (
    $package, 
    $pip_options = "--no-index",
    $python_prefix = $python::params::prefix,
    $pip_repository = $python::params::pip_repository,
    $version = "",
    $timeout=300,
    $extra_path="",
) {
    include python::params
    include python::prerequisites

    # Version parameter is required, but an empty string means "don't care".
    # Needed for a few packages like pytz, which do not have a version.
    if $version != "" {
        $pip = "$python_prefix/bin/pip install -f ${pip_repository} ${pip_options} ${package}==${version}"
        #$unless = "${python_prefix}/wrap_python.sh ${python_prefix}/package_version.py ${package} ${version}"
        $unless = "${python_prefix}/bin/pip freeze | grep -i ^${package}==${version}"
    }
    else
    {
        $pip = "$python_prefix/bin/pip install -f ${pip_repository} ${pip_options} ${package}"
        $unless = "${python_prefix}/bin/pip freeze | grep -i ^${package}=="
    }
    exec {
        "$pip":
            path => "$python_prefix/bin:/bin:/usr/bin${extra_path}",
            environment => "LD_LIBRARY_PATH=$python_prefix/lib:\$LD_LIBRARY_PATH",
            timeout => $timeout,
            unless => $unless,
            require => [Class["python"], Yumrepo["Operations"], Class["python::prerequisites"]];
    }
}
