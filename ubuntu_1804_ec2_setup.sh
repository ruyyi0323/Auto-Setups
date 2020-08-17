#!bin/bash

# relocate to user folder
cd ~

# ==== part 1: Folder Setup =====
echo "Script is setting up 4 basic folders ..."
echo "... Folder [installation] is the place for you to download the pkg for your instance"
echo "... Folder [resource_setup] is the place for you to do git clone some of the repos you need before you manipulating them"
echo "... Folder [setups] is the place for you to copy some config files, setup scripts that helps you set up your environment (like conda, pip or system env)"
mkdir -p installations
mkdir -p resource_setup
mkdir -p setups
read -p "... Creating User Specific Folder, Enter Your Personal Folder Name: "fname \
&& mkdir -p $fname

# ==== part 2: Install Miniconda ====
cd ~/installations
# auto fetch miniconda 3 into installations
echo "Start Installing Miniconda ..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# auto install miniconda
bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda
# initialize
cd ~/miniconda/bin/
./conda init
echo "Miniconda Installation Complete ..."
source ~/.bashrc

# ==== part 3: Install AWS-Cli ====
cd ~/installations
# install preresiqute
echo "Start Installing AWS-CLI 2 ..."
sudo apt install unzip
# fetch aws-cli
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
# create credentails & config
mkdir ~/.aws
touch ~/.aws/credentials
touch ~/.aws/config
echo "AWS-Cli Installation Complete ..."

# ==== part 4: Install Bashtop ====
cd ~/
echo "Installing Bashtop, which allows you to track the system resource allocation by simply use command 'bashtop' "
sudo add-apt-repository ppa:bashtop-monitor/bashtop -y
sudo apt install --no-upgrade bashtop -y

# ==== part 5: Enhance vim ====
cd ~/
echo "Installing PlugIns for vim to Enhance the Power of it, check https://github.com/amix/vimrc"
vim_config_download_path="~/.vim_runtime"
if [ ! -d "$vim_config_download_path" ];
then
	mkdir $vim_config_download_path
	git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_awesome_vimrc.sh
else
	echo "$vim_config_download_path Already Existed, Maybe you have already installed plugins from this repo, skipping ..."
fi

# ==== part 5.2: Install vim-airline ====
cd ~/.vim_runtime
vim_airline_download_path="my_plugins/vim-airline"
if [ ! -d "$vim_airline_download_path" ];
then
	git clone https://github.com/vim-airline/vim-airline.git my_plugins/vim-airline
else
	echo "$vim_airline_download_path Already Existed, Maybe you have already installed plugins from this repo, skipping ..."
fi

# ==== part 6: vscode-server installation ====
cd ~/installations
echo "Installing vscode-server, usage of this service can be seen here https://github.com/cdr/code-server/blob/master/doc/install.md"
curl -fsSL https://code-server.dev/install.sh | sh
echo "Changing the binding port to 12110, the original port 8080 may be conflict with jupyter notebook"
systemctl --user enable --now code-server
code-server -vvv -bind-address localhost:12110
echo "Enter the password that appears in this folder ~/.config/code-server/config.yaml"

# ==== part 7: install docker (Test Script) ====
cd ~/installations
echo "Installing Docker"
curl -fsSL https://get.docker.com -o get-docker.sh
sudo sh get-docker.sh

# ==== part 8: Further Installation Guide ====
cd ~
echo "All Steps Complete"
