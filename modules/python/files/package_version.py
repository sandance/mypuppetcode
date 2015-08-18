import sys
import pkg_resources

print 'package_version: %s' % ' '.join(sys.argv)

try:
    version = pkg_resources.require(sys.argv[1])[0].version
except:
    print 'package_version: error'
    sys.exit(2)
    
if version == sys.argv[2]:
    print 'package_version: good (%s)' % sys.argv[2]
    sys.exit(0)
else:
    print 'package_version: %s wrong version (%s != %s)' % (sys.argv[1], sys.argv[2], pkg_resources.require(sys.argv[1])[0].version)
    sys.exit(1)

