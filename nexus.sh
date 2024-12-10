#!/bin/bash

# Fetch and run external logo script
curl -s https://raw.githubusercontent.com/BORN2COD/logo/main/logo.sh | bash
sleep 5

# Text styling variables
BOLD=$(tput bold)
NORMAL=$(tput sgr0)
PINK='\033[1;35m'


# Function to show status messages
show() {
    case $2 in
        "error")
            echo -e "${PINK}${BOLD}❌ $1${NORMAL}"
            ;;
        "progress")
            echo -e "${PINK}${BOLD}⏳ $1${NORMAL}"
            ;;
        *)
            echo -e "${PINK}${BOLD}✅ $1${NORMAL}"
            ;;
    esac
}

# Variables
SERVICE_NAME="nexus"
SERVICE_FILE="/etc/systemd/system/$SERVICE_NAME.service"

# Step 1: Install Rust
show "Installing Rust..." "progress"
wget -qO - https://raw.githubusercontent.com/BORN2COD/Installation-scripts/main/rust.sh | bash
if [ $? -ne 0 ]; then
    show "Failed to install Rust." "error"
    exit 1
fi

# Step 2: Update package list
show "Updating package list..." "progress"
sudo apt update
if [ $? -ne 0 ]; then
    show "Failed to update package list." "error"
    exit 1
fi

# Step 3: Check and install Git
if ! command -v git &> /dev/null; then
    show "Git is not installed. Installing git..." "progress"
    sudo apt install git -y
    if [ $? -ne 0 ]; then
        show "Failed to install git." "error"
        exit 1
    fi
else
    show "Git is already installed."
fi

# Step 4: Clean up any existing repository
if [ -d "$HOME/network-api" ]; then
    show "Deleting existing repository..." "progress"
    rm -rf "$HOME/network-api"
fi
sleep 3

# Step 5: Clone the Nexus-XYZ network API repository
show "Cloning Nexus-XYZ network API repository..." "progress"
git clone https://github.com/nexus-xyz/network-api.git "$HOME/network-api"
if [ $? -ne 0 ]; then
    show "Failed to clone the repository." "error"
    exit 1
fi

cd "$HOME/network-api/clients/cli" || { show "Failed to enter required directory." "error"; exit 1; }

# Step 6: Install dependencies
show "Installing required dependencies..." "progress"
sudo apt install pkg-config libssl-dev protobuf-compiler -y
if [ $? -ne 0 ]; then
    show "Failed to install dependencies." "error"
    exit 1
fi

# Step 7: Stop and disable existing service if running
if systemctl is-active --quiet nexus.service; then
    show "nexus.service is currently running. Stopping and disabling it..."
    sudo systemctl stop nexus.service
    sudo systemctl disable nexus.service
else
    show "nexus.service is not running."
fi

# Step 8: Create a new systemd service
show "Creating systemd service..." "progress"
sudo bash -c "cat > $SERVICE_FILE" <<EOF
[Unit]
Description=Nexus XYZ Prover Service
After=network.target

[Service]
User=$USER
WorkingDirectory=$HOME/network-api/clients/cli
Environment=NONINTERACTIVE=1
ExecStart=$HOME/.cargo/bin/cargo run --release --bin prover -- beta.orchestrator.nexus.xyz
Restart=always
RestartSec=10

[Install]
WantedBy=multi-user.target
EOF

if [ $? -ne 0 ]; then
    show "Failed to create the systemd service file." "error"
    exit 1
fi

# Step 9: Reload systemd and start the service
show "Reloading systemd and starting the service..." "progress"
sudo systemctl daemon-reload
if [ $? -ne 0 ]; then
    show "Failed to reload systemd." "error"
    exit 1
fi

sudo systemctl start "$SERVICE_NAME.service"
if [ $? -ne 0 ]; then
    show "Failed to start the service." "error"
    exit 1
fi

sudo systemctl enable "$SERVICE_NAME.service"
if [ $? -ne 0 ]; then
    show "Failed to enable the service." "error"
    exit 1
fi

# Final Step: Success message
show "Nexus Prover installation and service setup complete!"
show "You can check Nexus Prover logs using this command: journalctl -u nexus.service -fn 50"
echo
