# Define the default target
.PHONY: all
all: install_python3.12 install_python_dependencies create_sym_link

install_python3.12:
	apt install -y software-properties-common
	add-apt-repository ppa:deadsnakes/ppa -y
	export DEBIAN_FRONTEND=noninteractive
	echo "tzdata tzdata/Areas select Europe" | debconf-set-selections
	echo "tzdata tzdata/Zones/Europe select Bucharest" | debconf-set-selections
	apt install python3.12-full -y
	export DEBIAN_FRONTEND=

install_python_dependencies: install_python3.12
	apt install -y python3-pip python3-dev build-essential 

create_sym_link: install_python_dependencies
	ln -s /usr/bin/python3 /usr/bin/python
