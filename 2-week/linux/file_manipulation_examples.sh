#!/bin/bash

# Step 1: Create directory and files
mkdir -p mydir
cd mydir || exit

echo "Creating initial files..."
touch file1.txt file2.txt file3.txt file4.txt file5.txt

# Step 2: Move some files, delete others
mkdir -p moved_dir
mv file1.txt file2.txt moved_dir/
rm file3.txt file4.txt

# Step 3: Archive and compress
cd ..
tar -cvf mydir.tar mydir
gzip mydir.tar
echo "Archived and compressed as mydir.tar.gz"

# Step 4: Use grep to find a word in a text file
echo -e "This is a test file\nLet's search this pattern" > searchfile.txt
grep "pattern" searchfile.txt

# Step 5: Redirect `ls` output to file and view
ls -lh > ls_output.txt
cat ls_output.txt

# Step 6: Create >17k small files with dd (1KB each)
mkdir -p manyfiles
cd manyfiles || exit
echo "Creating >17,000 small files..."
for i in {1..17001}; do
    dd if=/dev/zero of=file_$i.txt bs=1k count=1 status=none
done

# Step 7: Remove files and measure time
echo "Deleting files using rm..."
time rm -f file_*.txt

# Step 8: Better solution for deletion (in bulk)
echo -e "\nBetter approach using xargs with find:"
# Recreate files for demonstration
echo "Creating >17,000 small files..."
for i in {1..17001}; do
    dd if=/dev/zero of=file_$i.txt bs=1k count=1 status=none
done

# Faster bulk deletion
echo "Deleting using find"
time find . -name "file_*.txt" -delete

# Recreate files for demonstration
echo "Creating >17,000 small files..."
for i in {1..17001}; do
    dd if=/dev/zero of=file_$i.txt bs=1k count=1 status=none
done

# Deleting whole dir
echo "Deleting whole dir"
cd ..
time rm -rf manyfiles
