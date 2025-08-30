git clone https://github.com/andreyberdov72/test.git
cd test

git checkout -b feature2
echo "New feature2" >> hello.txt
git add example.txt
git commit -m "Add a new line"

git push -u origin feature2

#use github webclient to create pull request and aprove it

sleep 180

git checkout main
git pull origin main
