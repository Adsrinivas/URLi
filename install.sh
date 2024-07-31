#!/bin/bash

# Function to check if a command exists
command_exists () {
    type "$1" &> /dev/null ;
}

# Update and upgrade the system
echo "Updating and upgrading the system..."
sudo apt-get update -y && sudo apt-get upgrade -y

# Install dependencies
echo "Installing dependencies..."
sudo apt-get install -y golang-go git

# Create a Go workspace if it doesn't exist
if [ ! -d "$HOME/go" ]; then
    mkdir -p "$HOME/go"
    echo "export GOPATH=$HOME/go" >> ~/.profile
    echo "export PATH=$PATH:$GOPATH/bin" >> ~/.profile
    source ~/.profile
fi

# Install Waybackurls
if ! command_exists waybackurls; then
    echo "Installing Waybackurls..."
    go install github.com/tomnomnom/waybackurls@latest
else
    echo "Waybackurls is already installed."
fi

# Install Hakrawler
if ! command_exists hakrawler; then
    echo "Installing Hakrawler..."
    go install github.com/hakluke/hakrawler@latest
else
    echo "Hakrawler is already installed."
fi

# Install Gospider
if ! command_exists gospider; then
    echo "Installing Gospider..."
    go install github.com/jaeles-project/gospider@latest
else
    echo "Gospider is already installed."
fi

# Install Httpx
if ! command_exists httpx; then
    echo "Installing Httpx..."
	go install -v github.com/projectdiscovery/httpx/cmd/httpx@latest
else
    echo "Httpx is already installed."
fi

# Install Paramspider
if ! command_exists paramspider; then
    echo "Installing Paramspider..."
    git clone https://github.com/devanshbatham/ParamSpider.git
    cd ParamSpider
    sudo pip install .
    cd ..
else
    echo "Paramspider is already installed."
fi

echo "All tools have been installed successfully."

# Move Go binaries with confirmation
sudo mv ~/go/bin/* /usr/bin
