#!/bin/bash

# Function to reload pf rules on macOS
reload_pf() {
    sudo pfctl -f "$PF_CONF"
    sudo pfctl -e
}

# Function to handle firewall rules on Linux
handle_linux() {
    result=$(sudo iptables -S | grep "block jb")
    if [[ ! -z $result ]]; then
        echo "Found old IP"
        ip=$(echo $result | awk '{print $4}')
        echo $ip
        sudo iptables -D INPUT -s $ip -m comment --comment "block jb" -j DROP
        echo "Deleted old IP"
    fi

    ipaddresses=$(dig +short account.jetbrains.com)
    temp=()
    for i in $ipaddresses; do temp+=($i); done

    for ipaddress in ${temp[@]}; do
        echo $ipaddress
        sudo iptables -A INPUT -s $ipaddress -j DROP -m comment --comment "block jb"
    done
    echo "All good"
}

# Function to handle firewall rules on macOS
handle_macos() {
    PF_CONF="/etc/pf.conf"

    result=$(sudo pfctl -sr | grep "block drop from any to any")
    if [[ ! -z $result ]]; then
        echo "Found old IP"
        ip=$(echo $result | awk '{print $7}')
        echo $ip
        sudo pfctl -t blocklist -T delete $ip
        echo "Deleted old IP"
    fi

    ipaddresses=$(dig +short account.jetbrains.com)
    temp=()
    for i in $ipaddresses; do temp+=($i); done

    for ipaddress in ${temp[@]}; do
        echo $ipaddress
        echo "block drop from any to $ipaddress" | sudo tee -a "$PF_CONF"
    done

    reload_pf
    echo "All good"
}

# Detect the operating system and run the appropriate function
if [[ "$OSTYPE" == "linux-gnu"* ]]; then
    handle_linux
elif [[ "$OSTYPE" == "darwin"* ]]; then
    handle_macos
else
    echo "Unsupported operating system: $OSTYPE"
    exit 1
fi
