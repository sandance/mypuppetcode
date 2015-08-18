class shapely () inherits shapely::params {
    include airsage
    include python
    python::package {
        'shapely':
            package => 'shapely',
            version => "$shapely_version",
            require => Package["geos-devel"],
    }
}
