sudo wipefs /dev/sdX
sudo wipefs -o 0x8001 -f /dev/sdX
# make partition sdX3 in gparted
cryptsetup --verbose --verify-passphrase --cipher aes-xts-plain64 --key-size 512 --hash whirlpool --pbkdf argon2id luksFormat /dev/sdX3
cryptsetup luksOpen /dev/sdX3 usb
mkfs.ext4 -L persistence /dev/mapper/usb
e2label /dev/mapper/usb persistence
mount /dev/mapper/usb /mnt
echo "/ union" > /mnt/persistence.conf
umount /dev/mapper/usb
cryptsetup luksClose /dev/mapper/usb
