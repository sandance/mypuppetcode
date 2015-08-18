class unzip::params () {
    case $::centosmajrelease {
        "7": {
            $unzip_version = '.x86_64'
        }
        "6": {
            $unzip_version = '-6.0-1.el6.x86_64'
        }
        "5": {
            $unzip_version = ".x86_64"
        }
        default: { fail("No regex match found for ::centosmajrelease $::centosmajrelease in unzip params.pp.") }
    }
}
