# CloudQuery Configuration Setup

This script automates the setup and configuration of CloudQuery on a Linux system. CloudQuery is a service that connects to a PostgreSQL database using AWS Secrets Manager to retrieve database credentials securely. The script also configures systemd timers to automate the scheduling of CloudQuery service.

## Prerequisites

- AWS CLI installed and configured with the necessary permissions.
- jq (a lightweight and flexible command-line JSON processor) installed.
- PostgreSQL database credentials stored securely in AWS Secrets Manager.


## Usage

Run the script using the following command:

```bash
sudo chmod +x init.sh
sudo ./init.sh
