#To run- 
#Pushes list of running processes on **completed** Ubuntu image to the github repo, then removes all added files.
cd
sudo -i
#enter password
apt-get install git
git config -global user.name "Adamapb"
git config -global user.email "abeard2003@gmail.com"
mkdir cpprocesses
cd cpprocesses
git init
git remote add origin https://github.com/Adamapb/cpprocesses
touch cpprocesses.log
ps -a >> cpprocesses.log
git add cpprocesses.log
git commit -m 'CP default processes'
git push origin master
#Enter details; user is Adamapb, pass is 103624apb
apt-get remove git
cd
remove -rf cpprocesses
echo "end of script"