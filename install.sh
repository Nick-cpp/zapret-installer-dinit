#!/bin/bash

CURRENT_USER=$(whoami)
HOME_DIR=$(eval echo ~$CURRENT_USER)

cd
mkdir -p ~/.zapret/
git clone https://github.com/Sergeydigl3/zapret-discord-youtube-linux
mv ~/zapret-discord-youtube-linux/* ~/.zapret/
rm -rf zapret-discord-youtube-linux/

echo "Install zapret to autostart? y/n"
read -r autostart_choice
if [[ "$autostart_choice" =~ ^[Yy]$ ]]; then
    cat > /tmp/zapret-service << EOF
type            = process
command         = /bin/bash $HOME_DIR/.zapret/main_script.sh -nointeractive
smooth-recovery = true
depends-on      = NetworkManager
EOF
    
    sudo cp /tmp/zapret-service /etc/dinit.d/zapret
    sudo chmod +x /etc/dinit.d/zapret
    sudo dinitctl enable zapret
    rm -f /tmp/zapret-service
else
    echo "Installed zapret with autostart"
fi
echo "Installed zapret without autostart"
