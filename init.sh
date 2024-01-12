#!/bin/sh
config_dir="/home/ubuntu/cloudquery"
Environmentfile="/etc/default/cloudquery"
Secretid="cloudquery"
aws_region="ap-south-1"

# Create the directory if it doesn't exist
if [ ! -d "$config_dir" ]; then
    mkdir -p "$config_dir"
fi

dbsecrets=$(aws secretsmanager get-secret-value --secret-id  $Secretid --query SecretString  --region $aws_region | jq -r)
db_user=$(echo $dbsecrets | jq '.username' -r)
db_passwd=$(echo $dbsecrets | jq '.password' -r)
db_host=$(echo $dbsecrets | jq '.host' -r)
db_dbname=$(echo $dbsecrets | jq '.dbname' -r)

# Create or update the environment file
cat > "$Environmentfile" <<EOF
PG_CONNECTION_STRING = "postgresql://${db_user}:${db_passwd}@${db_host}/${db_dbname}?sslmode=disable"
EOF

# Set proper permissions for the environment file
chmod 600 "$Environmentfile"

#  do the symlink 
sudo ln -svf "${config_dir}/cloudquery.service" "/etc/systemd/system/cloudquery.service"
sudo ln -svf "${config_dir}/cloudquery.timer" "/etc/systemd/system/cloudquery.timer"

#start the service and timer
sudo systemctl enable cloudquery.timer
sudo systemctl start cloudquery.timer

sudo systemctl enable cloudquery.service
sudo systemctl start cloudquery.service
