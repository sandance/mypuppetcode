import sys

print 'setuptools_version: %s' % ''.join(sys.argv)

try:
    import setuptools
except ImportError:
    print 'setuptools_version: ImportError'
    sys.exit(2)

if sys.argv[1] in setuptools.__file__:
    print 'setuptools_version: good (%s)' % sys.argv[1]
    sys.exit(0)
else:
    print 'setuptools_version: wrong (%s not found in %s)' % (sys.argv[1], setuptools.__file__)
    sys.exit(1)

