#!/bin/bash

install_inspec() {
    echo "Install Inspec"
    curl https://omnitruck.chef.io/install.sh | sudo bash -s -- -P inspec
    echo "Installation Completed"
}

install_inspec

if [[ "${?}" -eq 0 ]];
then
    inspec plugin install train-aws
    echo "Requirements Installed"
else
    echo "Installation Failed"
fi
