mkdir test
cd test
git init

echo "Hello, World!" > hello.txt
git add hello.txt
git commit -m "Add hello.txt"

git remote add origin https://github.com/andreyberdov72/test.git
git branch -M main
git push -u origin main

git checkout -b feature
echo "This is a new feature!" >> hello.txt
git add hello.txt
git commit -m "Add new feature to hello.txt"

git checkout main
git merge feature

git push origin main
