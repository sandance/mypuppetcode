<%- if scope['::centosmajrelease'] != "7" -%>
# Use our Python, not the system Python.

PYTHON_SITEPACKAGES=<%= @prefix -%>/lib/python<%= @major_version -%>/site-packages

export LD_LIBRARY_PATH=<%= @prefix -%>/lib:$LD_LIBRARY_PATH
export PYTHONPATH=$PYTHONPATH:$PYTHON_SITEPACKAGES:$PYTHON_SITEPACKAGES/GDAL-1.9.2-py2.7-linux-x86_64.egg
export PATH=<%= @prefix -%>/bin:$HOME/.local/bin:$PATH
<%- end -%>
