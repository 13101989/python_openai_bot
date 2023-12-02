# Define the default target
.PHONY: all
all: install_python3.12 install_python_dependencies create_sym_link

install_python3.12:
	apt install -y software-properties-common
	add-apt-repository ppa:deadsnakes/ppa -y
	apt update -y
	DEBIAN_FRONTEND=noninteractive
	apt install python3.12-full -y
	DEBIAN_FRONTEND=

install_python_dependencies:
	apt install -y python3-pip python3-dev build-essential

create_sym_link:
	ln -s /usr/bin/python3 /usr/bin/python
