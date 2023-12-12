# OS Distribution
if [ -f /etc/os-release ]; then
    # Ubuntu
    grep -qi ubuntu /etc/os-release && OS="Ubuntu"

    # CentOS
    grep -qi centos /etc/os-release && OS="CentOS"
fi

# txt fle create for the network information
txt_file="network_info_$(date +'%Y-%m-%d').txt"

# Check OS and collect Information of Network 
if [ "$OS" = "Ubuntu" ]; then
    # Collect Information of Network for Ubuntu
    echo "=== Information of Network for Ubuntu ===" > "$txt_file"
    echo "=== IP Configuration ===" >> "$txt_file"
    ip addr >> "$txt_file"
    echo "=== Routing Table ===" >> "$txt_file"
    ip route >> "$txt_file"
    echo "=== Firewall Settings ===" >> "$txt_file"
    iptables -L >> "$txt_file"
    echo "=== Active Ports and Services ===" >> "$txt_file"
    ss -tuln >> "$txt_file"
elif [ "$OS" = "CentOS" ]; then
    # Collect Information of Network for CentOS
    echo "=== Information of Network for CentOS ===" > "$txt_file"
    echo "=== IP Configuration ===" >> "$txt_file"
    ifconfig >> "$txt_file"
    echo "=== Routing Table ===" >> "$txt_file"
    route -n >> "$txt_file"
    echo "=== Firewall Settings ===" >> "$txt_file"
    iptables -L >> "$txt_file"
    echo "=== Active Ports and Services ===" >> "$txt_file"
    netstat -tuln >> "$txt_file"
else
    echo "Unsupported OS" >> "$txt_file"
fi

echo "Information of Network collected in $txt_file"