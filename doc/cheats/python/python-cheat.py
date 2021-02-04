# python cheat sheet

virtualenv -p python3.5  env

sudo apt-get intall -y python3.6
sudo ln -sfn /usr/bin/python3.6 /usr/bin/python ; ls -la /usr/bin/python

sudo apt-get install python3-pip

# install pip3 on mac
wget https://bootstrap.pypa.io/get-pip.py
python3 get-pip.py && rm -v get-pip.py


python3 -m venv /path/to/new/virtual/environment


# instal virtualenv
sudo pip3 install virtualenv

# build new virtualenv
cd $your_proj_dir
virtualenv .venv

#to activate your virtualev
source .venv/bin/activate

# to deactivate your virtualev
deactivate

# install new packages After activating your virtualenv
pip install <some-package>

# output the currently intalled modules in requirement.txt format
pip freeze


echo 'eval "$(pyenv init -)"' >> ~/.python_opts.`hostname -s`
source ~/.bash_profile
pyenv install 3.5.0
pyenv install 3.7.0

# list all the python vrersioned on this system
pyenv install -l | grep -ow [0-9].[0-9].[0-9]

# which are  my vesions 
pyenv versions
# Set a specific version of Python as your local version.

pyenv local 3.x.x
Set Python version globally.

pyenv global 3.x.x

pyenv install 3.4.5
pyenv global 3.4.5

python -V

# ubuntu 
CFLAGS="-I$(brew --prefix openssl)/include" \
LDFLAGS="-L$(brew --prefix openssl)/lib" \
pyenv install -v 3.4.0

# mac
brew install 'openssl@1.1'
CONFIGURE_OPTS="--with-openssl=$(brew --prefix openssl@1.1)" pyenv install 3.4.0