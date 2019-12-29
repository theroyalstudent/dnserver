# update system repos
apt update

# check for python3 and python3 pip
if [ -z $(which python3) ]; then
	apt install python3 -y
fi

if [ -z $(which pip) ]; then
	apt install python3-pip -y
fi

# not sure whether systems have setuptools installed
apt install python3-setuptools -y

# check for supervisor
if [ -z $(which supervisorctl) ]; then
	apt install supervisor -y
	systemctl enable supervisor
	systemctl start supervisor
fi

# remove the folder if it already exists
if [ -a /etc/dnserver ]; then
	rm -rf /etc/dnserver
fi

cd /etc
git clone git@github.com:theroyalstudent/dnserver.git dnserver

if [ $? -ne 0 ]; then
	echo "Unable to clone repository. Please check your internet connectivity and try again."
	return -1
else
	cd dnserver
fi

# init supervisor config file
cat dnserver.supervisor.conf | sed "s/{FBIPV4}/$FALLBACK_IPV4/g" > dnserver.temp
cat dnserver.temp | sed "s/{FBIPV6}/$FALLBACK_IPV6/g" > /etc/supervisor/conf.d/dnserver.conf
rm dnserver.temp

cd src

# install dependencies
if [ -z $(which pip3) ]; then
	pip install -r requirements.txt
else
	pip3 install -r requirements.txt
fi

# disable systemd-resolved
systemctl stop systemd-resolved
systemctl disable systemd-resolved

# turning on dnserver
supervisorctl reread
supervisorctl update

echo "Successfully installed dnserver."