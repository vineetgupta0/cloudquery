# CloudQuery Configuration Setup

This script automates the setup and configuration of CloudQuery on a Linux system. CloudQuery is a service that connects to a PostgreSQL database using AWS Secrets Manager to retrieve database credentials securely. The script also configures systemd timers to automate the scheduling of CloudQuery service.

## Prerequisites

- AWS CLI installed and configured with the necessary permissions.
- jq (a lightweight and flexible command-line JSON processor) installed.
- PostgreSQL database credentials stored securely in AWS Secrets Manager.

## Installation

1. **Configuration Directory:**

   The default configuration directory is set to "/home/ubuntu/cloudquery". If the directory does not exist, it will be created.

2. **Retrieve Database Secrets:**

   Database credentials are fetched from AWS Secrets Manager. Ensure that AWS CLI is installed and configured before running the script.

3. **Environment File:**

   The script creates or updates the environment file located at "/etc/default/cloudquery" with the PostgreSQL connection string. The connection string is formed using the retrieved database credentials.

4. **Symlinks for systemd:**

   Symlinks for CloudQuery systemd service and timer files are created in the respective systemd directories ("/etc/systemd/system/"). This enables systemd to manage CloudQuery as a service and schedule its execution using a timer.

5. **Set Permissions:**

   Proper permissions (600) are set for the environment file to ensure the security of sensitive information.

6. **Enable and Start systemd Services:**

   The systemd timer and service for CloudQuery are enabled and started to ensure automatic scheduling and execution.

## Usage

Run the script using the following command:

```bash
sudo chmod +x init.sh
sudo ./init.sh
