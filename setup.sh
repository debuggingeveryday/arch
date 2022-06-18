

checkline() {
	$1
	read -p "continue?" confirmation
	if [[ "$confirmation" != "y" ]]; then
		exit 0
	fi
}

reset () {
	echo -e "
	DESKTOP=
	DISK=
	DISK_PREFIX=
	BOOT_TYPE=
	USERNAME=
	PASSWORD=
	GPU_TYPE=
	HOST_NAME=
	TOTAL_RAM=
	CPU_TYPE=
	DEBUG_VBOX=
	GRUB_TITLE=
	INSTALL_TYPE=
	" > ./settings.conf
}

update_settings () {
	sed -i "s/$1=/$1=$2/g" ./settings.conf
}

reset

# CONSTANTS
DESKTOP_LIST=('KDE')
DISK_LIST=$(lsblk -n --output TYPE,KNAME,SIZE | awk '$1=="disk"{print "/dev/"$2}')

# echo "
# 0: debug
# 1: basic
# 2: basic/gui
# "
# read -p "INSTALL_TYPE: " select_install_type

get_system_variables () {
	# [BEGIN]-GET CPU TOTAL #
	proc_type=$(lscpu)
	if grep -E "GenuineIntel" <<< ${proc_type}; then
		echo "Installing Intel microcode"
		cpu_type="INTEL"
	elif grep -E "AuthenticAMD" <<< ${proc_type}; then
		echo "Installing AMD microcode"
		cpu_type="AMD"
	fi

	update_settings "CPU_TYPE" "$cpu_type"

# [END]-GET CPU TOTAL #

# [BEGIN]-GET RAM TOTAL #
total_ram=$(cat /proc/meminfo | grep MemTotal | awk '$1=="MemTotal:"{print $2}')
# [END]-GET RAM TOTAL #

if grep -E "NVIDIA|GeForce" <<< $(lspci); then
	gpu_type="NVIDIA"
elif lspci | grep 'VGA' | grep -E "Radeon|AMD"; then
	gpu_type="AMD"
elif grep -E "Integrated Graphics Controller" <<< $(lspci); then
	gpu_type="INTEL_GRAPHICS"
elif grep -E "Intel Corporation UHD" <<< $(lspci); then
	gpu_type="INTEL_UHD"
else
	gpu_type="--"
fi

update_settings "GPU_TYPE" "$gpu_type"

# [BEGIN]-GET BOOT_TYPE #

if [[ -d "/sys/firmware/efi" ]]; then
	boot_type="EFI"
else
	boot_type="LEGACY"
fi

update_settings "BOOT_TYPE" "$boot_type"

# [END]-GET BOOT_TYPE #

}

get_users_variables () {

# [BEGIN]-GET BOOT_TYPE #
declare -a disk=()
declare -i index=0

echo ""
for i in $DISK_LIST
do
	index+=1
	echo "$index. $i"
	disk+=($(echo $i | cut -d'/' -f3))
done

if [[ "$DISK_LIST" == *"nvme0n"* ]]; then
	update_settings "DISK_PREFIX" "p"
fi
echo ""
read -p "CHOOSE DISK: " disk_choose && update_settings "DISK" "${disk[disk_choose-1]}"
read -p "HOST_NAME: " host_name && update_settings "HOST_NAME" "$host_name"
read -p "USERNAME: " username && update_settings "USERNAME" "$username"
read -sp "PASSWORD: " password && update_settings "PASSWORD" "$password"

# [END]-GET BOOT_TYPE #
}

get_desktop_variables () {

	echo ""
	echo ""
	for i in $DESKTOP_LIST
	do
		index+=1
		echo "$index. $i"
	done
	echo ""

	read -p "CHOOSE DESKTOP ENVIRONMENT: " desktop_environment && update_settings "DESKTOP" "${DESKTOP_LIST[desktop_environment - 1]}"
}

get_system_variables
get_users_variables
get_desktop_variables

cat ./settings.conf

exit 0
