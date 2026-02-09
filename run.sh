#!/bin/sh

read -p "Username: " USERNAME;
read -s -p "Password: " PASSWORD;
echo
read -p "Hostname: " HOSTNAME;
KERNEL_HEADERS=$(echo -e "zen\nhardened\nlts\n--" | fzf --header "Kernel");
TIMEZONE=$(timedatectl list-timezones | fzf --header "Set timezone");
DISK=$(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print "/dev/"$2}' | fzf --header "Choose disk");
IS_ENCRYPT=$(echo -e "NO\nYES" | fzf --header "Encrypt partition?");

[[ "$IS_ENCRYPT" == "YES" ]] && IS_ENCRYPT=true || IS_ENCRYPT=false

echo -e "
  username: $USERNAME
  password: *********
  hostname: $HOSTNAME
  kernel_headers: $KERNEL_HEADERS
  timezone: $TIMEZONE
  disk: $DISK
  is_encrypted: $IS_ENCRYPT
"

read -p "Proceed?: (Y/n): " IS_PROCEED;

if [[ "$IS_PROCEED" == "Y"  ]]; then
  ./arch --username "$USERNAME" \
    --password "$PASSWORD" \
    --hostname "$HOSTNAME" \
    --kernel_headers $KERNEL_HEADERS \
    --settings 0 \
    --target_disk "$DISK" \
    --is_encrypt $IS_ENCRYPT \
    --timezone $TIMEZONE
else
  echo "NO"
fi 
