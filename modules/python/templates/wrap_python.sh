#!/bin/bash 
set -e
source <%= @prefix -%>/activate_python.sh
python<%= @major_version -%> $@
