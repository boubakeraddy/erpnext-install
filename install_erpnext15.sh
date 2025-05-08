#!/bin/bash

# Exit on error
set -e

# Variables
FRAPPE_USER=frappe
BENCH_NAME=erpnext-bench
SITE_NAME=erp.local
MYSQL_ROOT_PWD=root
ADMIN_PWD=admin
ERP_BRANCH=version-15
PYTHON_VERSION=3.11

echo "Installing dependencies..."
sudo apt update
sudo apt install -y python$PYTHON_VERSION python$PYTHON_VERSION-dev python3-pip python$PYTHON_VERSION-full \
    mariadb-server redis-server curl git software-properties-common \
    wkhtmltopdf libmysqlclient-dev nginx supervisor build-essential \
    libffi-dev libssl-dev xvfb libfontconfig wkhtmltopdf

# Ensure pip is linked to python
curl -sS https://bootstrap.pypa.io/get-pip.py | sudo python

# Add frappe user
sudo adduser --disabled-password --gecos "" $FRAPPE_USER
sudo usermod -aG sudo $FRAPPE_USER

# Install bench
sudo -H pip install frappe-bench

# Switch to frappe user
sudo su - $FRAPPE_USER << EOF

# Init bench
bench init $BENCH_NAME --frappe-branch $ERP_BRANCH --python $PYTHON_VERSION
cd $BENCH_NAME

# Create site
bench new-site $SITE_NAME --admin-password $ADMIN_PWD --mariadb-root-password $MYSQL_ROOT_PWD

# Get ERPNext app
bench get-app erpnext --branch $ERP_BRANCH
bench --site $SITE_NAME install-app erpnext

# Optional: Get custom app (replace with actual repo)
# bench get-app custom_app https://github.com/youruser/custom_app.git
# bench --site $SITE_NAME install-app custom_app

# Setup production
bench setup production $FRAPPE_USER

EOF

echo "✅ ERPNext v15 with Python $PYTHON_VERSION is installed in production mode."
echo "Access it at http://<your-server-ip> (or configure DNS and HTTPS)."

