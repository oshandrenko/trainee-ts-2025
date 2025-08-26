
# Add newuser to sudo (or wheel) group
sudo usermod -aG sudo newuser

# Create file and assign owner
touch file
chown root:root file
chmod 644 file

# Give newuser read and write access using ACL
setfacl -m u:neweuser:rw file

# Verify
getfacl file

############## QUOTA

sudo mkdir -p /mnt/tmpfs

# Create in-memory filesystem
sudo mount -t tmpfs -o size=101M tmpfs /mnt/tmpfs

# Create loop device with ext4 file system and quota support
sudo dd if=/dev/zero of=/tmp/loopdisk.img bs=1M count=100
sudo mkfs.ext4 -O quota /tmp/loopdisk.img

sudo mkdir -p /mnt/loopdisk
sudo mount -o loop,usrquota /tmp/loopdisk.img /mnt/loopdisk

sudo quotacheck -cu /mnt/loopdisk
sudo quotaon /mnt/loopdisk

# Add test file and set quotas
sudo touch /mnt/loopdisk/test.txt
sudo edquota -u jnovak


############### 5. Restrict login times (9:00 to 18:00 only)
echo "login;*;secureuser;Wk0900-1800" | sudo tee -a /etc/security/time.conf > /dev/null

echo "account required pam_time.so" | sudo tee -a /etc/pam.d/login > /dev/null



