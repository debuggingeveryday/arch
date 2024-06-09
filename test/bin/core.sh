#!/bin/sh

source $MAIN_PATH/util/remote.sh

modify_files() {
    [[ "$is_encrypt" == true ]] && sed -r -i 's/(HOOKS=)\((.*?)\)/\1(base udev autodetect modconf block keyboard encrypt lvm2 filesystems fsck)/g' /mnt/etc/mkinitcpio.conf || echo "exit"

    # hostname
    echo "scrubs" > /mnt/etc/hostname

    # timezone
    ln -sf /mnt/usr/share/zoneinfo/$timezone  /mnt/etc/localtime

    # hosts
    echo "
    127.0.0.1 localhost
    ::        localhost
    127.0.1.1  scrubs.localdomain scrubs" > /mnt/etc/hosts

    # users allow root access
    # sed -i 's/# %wheel ALL=(ALL) ALL/%wheel ALL=(ALL) ALL/g' /mnt/etc/sudoers # -- under investigate
    echo "scrubs ALL=(ALL) ALL" >> /mnt/etc/sudoers

    # allow multilib pacman package
    sed -i "s/#\[multilib]/[multilib]/" /mnt/etc/pacman.conf
    sed -i "$!N;s/\(\[multilib]\n\)#\(Include\)/\1\2/;P;D" /mnt/etc/pacman.conf

    # set swap size and create zram swap service
    echo "
    [Unit]
    Description=zRam block devices swapping

    [Service]
    Type=oneshot
    ExecStart=/usr/bin/bash -c 'modprobe zram && echo lz4 > /sys/block/zram0/comp_algorithm && echo ${swap_size} > /sys/block/zram0/disksize && mkswap --label zram0 /dev/zram0 && swapon --priority 100 /dev/zram0'
    ExecStop=/usr/bin/bash -c 'swapoff /dev/zram0 && rmmod zram'
    RemainAfterExit=yes

    [Install]
    WantedBy=multi-user.target

    " > /mnt/etc/systemd/system/zram-swap.service

    # date format
    sed -i 's/#en_US.UTF-8/en_US.UTF-8/g' /mnt/etc/locale.gen
    echo "LANG=en_US.UTF-8" > /mnt/etc/locale.conf

    genfstab -U /mnt >> /mnt/etc/fstab
}

core_packages() {
    local packages=(
        "networkmanager" 
        "dhcpcd" 
        "iwd" 
        "vim" 
        "git" 
    )
    
    if [[ "$is_encrypt" == true ]]; then
        packages+=(
            "lvm2" 
        )
    fi

    pacstrap -i /mnt --needed --noconfirm --verbose "${packages[@]}"
}

start_services() {
    remote systemctl enable NetworkManager.service
    remote systemctl enable dhcpcd.service
    remote systemctl enable iwd.service
    remote systemctl enable zram-swap.service ;
}