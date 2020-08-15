# Auto-Setups
A small easy and simple script to help you quickly hit the road of python development. Compared to a complex setup procedure to your computer / instance, the advantage of using this script are:
- Easy to Use
- Straight Forward Log
- No duplicated procedure

## Usage
The Execution of the script is something like this, depends on the system that you're using
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ruyyi0323/Auto-Setups/master/{the script name in repo}.sh)"
```
And follow the intrstuctions from what it pumps up from the shell

For Example, If you are creating an instance on AWS whose AMI is Ubuntu 18.04, you can do the following (actually this script should be working for a general Ubuntu instance who has curl and wget)
```bash
sh -c "$(curl -fsSL https://raw.githubusercontent.com/ruyyi0323/Auto-Setups/master/ubuntu_1804_ec2_setup.sh)"
```

## What it does
The whole process of this script can be treated as the following steps:
- **Setup folders for your development**
  - Script creates `installation` folder where you can store some setup script (like miniconda etc.)
  - Script creates 'resource_setup' which is the place for you to do git clone some of the repos you need before you manipulating them (usually my suggestion is if this repo is not a project specific one, or commonly used on**e, you can put it here)
  - Script creates 'setups' folder, which is the place that you can put the config files, where you need to setup your development environment (like conda requires `requirement.yml`, etc.)
- **Install Miniconda and initalize it**
  - Usually people are not using too much components like (spyder etc.) as they exist in Anaconda, thus I use miniconda instead to minimize the requirement of the instance that you are setting up
  - It downloads the install script from web to the `installations` folder, and automatic install it to `~/miniconda` folder, finally, it init the conda and refresh the shell tab so you are able to directly use it
- **Install AWS-CLI**
- **Helps Setup Virtual Envrionment if you have a existed requirement yml file**
- **Install Bashtop**
- **Install Plugins for vim**
- **CD back to the ~/ file**
