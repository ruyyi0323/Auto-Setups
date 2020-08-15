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
cd installations

# auto fetch miniconda 3 into installations
echo "Start Installing Miniconda ..."
wget https://repo.anaconda.com/miniconda/Miniconda3-latest-Linux-x86_64.sh
# auto install miniconda
bash Miniconda3-latest-Linux-x86_64.sh -b -p ~/miniconda
# initialize
cd ~/miniconda/bin/
./conda init
source ~/.bashrc
echo "Miniconda Installation Complete ..."

# ==== part 3: Install AWS-Cli ====
echo "Start Installing AWS-CLI 2 ..."
sudo apt install unzip
curl "https://awscli.amazonaws.com/awscli-exe-linux-x86_64.zip" -o "awscliv2.zip"
unzip awscliv2.zip
sudo ./aws/install
echo "AWS-Cli Installation Complete ..."

# ==== part 4: Install Virtual Environment ====
read -p "Please Specify a conda environment config path, If no file specified or Filepath is not valid, Script will skip this part" fname
if [ ! -f "$fname" ];
then
	echo "No a valid path $fname, Skip this process ..."
else
	conda env create -f $fname
fi

# ==== part 5: Install Bashtop ====
echo "Installing Bashtop, which allows you to track the system resource allocation by simply use command 'bashtop' "
sudo add-apt-repository ppa:bashtop-monitor/bashtop -y
sudo apt install --no-upgrade bashtop -y

# ==== part 6: Enhance vim ====
echo "Installing PlugIns for vim to Enhance the Power of it, check https://github.com/amix/vimrc"
vim_config_download_path="~/.vim_runtime"
if [ ! -d "$vim_config_download_path" ];
then
	echo "$vim_config_download_path Already Existed, Maybe you have already installed plugins from this repo, skipping ..."
else
	git clone --depth=1 https://github.com/amix/vimrc.git ~/.vim_runtime
	sh ~/.vim_runtime/install_awesome_vimrc.sh
fi

# ==== part 6.2: Install vim-airline ====
cd ~/.vim_runtime
vim_airline_download_path="my_plugins/vim-airline"
if [ ! -d "$vim_airline_download_path" ];
then
	echo "$vim_airline_download_path Already Existed, Maybe you have already installed plugins from this repo, skipping ..."
else
	git clone https://github.com/vim-airline/vim-airline.git my_plugins/vim-airline
fi


# ==== part 7: Clean up ====
cd ~
echo "All Steps Complete"
