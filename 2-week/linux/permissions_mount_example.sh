# Create user newuser with /home/newuser, bash-shell and wheel group
sudo useradd -m -s /bin/bash -G wheel newuser

touch file

# Set rw-r-r
chmod 644 file

# Create soft link to file
ln -s file sl_file

# List of block devices
lsblk

# Mount first partition of scsi device to /mnt
sudo mount /dev/sdc1 /mnt

# Mountpoints list
mount
