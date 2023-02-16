dev=/dev/nvme0n1
dev_boot=/dev/nvme0n1p1
dev_swap=/dev/nvme0n1p2
dev_root=/dev/nvme0n1p3

read -p "DANGER: Press <enter> to format $dev and install..."

timedatectl set-ntp true

memory_gb=$(free --giga | grep Mem | awk '{print $2}')
swap_gb=$(($memory_gb + 2))

(
	echo g;
	echo n; echo; echo; echo +256M; echo t; echo uefi;
	echo n; echo; echo; echo +${swap_gb}G; echo t; echo; echo swap;
	echo n; echo; echo; echo; echo t; echo; echo linux;
	echo w;
) | fdisk $dev --wipe always --wipe-partitions always

mkswap -L SWAP $dev_swap
mkfs.vfat -F 32 -n BOOT $dev_boot
mkfs.btrfs -L ROOT $dev_root

mount --mkdir $dev_root /mnt
btrfs subvolume create /mnt/@
btrfs subvolume create /mnt/@home
btrfs subvolume create /mnt/@tmp
btrfs subvolume create /mnt/@log
btrfs subvolume create /mnt/@pkg
btrfs subvolume create /mnt/@snapshots
umount /mnt

swapon $dev_swap
mount --mkdir -o subvol=@ $dev_root /mnt
mount --mkdir $dev_boot /mnt/boot
mount --mkdir -o subvol=@home $dev_root /mnt/home
mount --mkdir -o subvol=@tmp $dev_root /mnt/tmp
mount --mkdir -o subvol=@log $dev_root /mnt/var/log
mount --mkdir -o subvol=@pkg $dev_root /mnt/var/cache/pacman/pkg
mount --mkdir -o subvol=@snapshots $dev_root /mnt/.snapshots

mkdir -p /mnt/etc
genfstab -U /mnt > /mnt/etc/fstab

reflector

pacman -Sy --noconfirm archlinux-keyring

yes | pacstrap /mnt \
	base base-devel \
	linux linux-headers intel-ucode \
	linux-firmware sof-firmware \
	grub efibootmgr snapper grub-btrfs \
	man man-db man-pages \
	networkmanager \
	zsh git rsync

cat <<- "EOF" > /mnt/continue.sh
	cat <<- eof > /etc/tmpfiles.d/tmp.conf
		D! /tmp 1777 root root 0
	eof

	umount /.snapshots
	rm -r /.snapshots
	snapper --no-dbus --config root create-config /
	btrfs subvolume delete /.snapshots
	mount --mkdir /.snapshots
	systemctl enable grub-btrfsd

	grub-install \
		--target=x86_64-efi \
		--efi-directory=/boot \
		--bootloader-id=ARCH \
		--recheck

	key=GRUB_TIMEOUT
	sed -i "s/.*$key=.*/$key=1/g" /etc/default/grub
	key=GRUB_TIMEOUT_STYLE
	sed -i "s/.*$key=.*/$key=hidden/g" /etc/default/grub
	key=GRUB_DISABLE_RECOVERY
	sed -i "s/.*$key=.*/$key=false/g" /etc/default/grub

	grub-mkconfig -o /boot/grub/grub.cfg

	tz=Australia/Sydney
	ln -sf /usr/share/zoneinfo/$tz /etc/localtime
	hwclock --systohc

	keymap=us
	echo "KEYMAP=$keymap" > /etc/vconsole.conf
	loadkeys $keymap

	lang=en_AU.UTF-8
	echo "LANG=$lang" > /etc/locale.conf
	line="$lang"
	sed -i "s/#$line/$line/g" /etc/locale.gen
	locale-gen

	host=arch
	echo "$host" > /etc/hostname

	cat <<- eof > /etc/hosts
		::1		localhost
		127.0.0.1	localhost
		127.0.1.1	$host.localdomain $host
	eof

	systemctl enable NetworkManager.service

	chpasswd <<< "root:password"

	user=user
	useradd \
		--create-home \
		--groups wheel \
		--shell $(which zsh) \
		$user
	line="%wheel ALL=(ALL:ALL) ALL"
	sed -i "s/# $line/$line/g" /etc/sudoers

	chpasswd <<< "$user:password"

	cd /home/$user
	sudo -u $user touch .zshrc
	sudo -u $user mkdir -p ./{_dev,_zone}
	repo=peterboyer/dotfiles
	sudo -u $user git clone https://github.com/$repo.git _dotfiles
	sudo -u $user git -C _dotfiles remote set-url origin git@github.com:$repo
	cd -

	git clone https://aur.archlinux.org/yay-bin.git /tmp/yay
	(cd /tmp/yay && yes | makepkg -si --noconfirm)
	rm -rf /tmp/yay

	exit
EOF

chmod +x /mnt/continue.sh

arch-chroot /mnt /continue.sh

rm /mnt/continue.sh

cp $0 /mnt

arch-chroot /mnt "cd \$HOME/_dotfiles"

exit
