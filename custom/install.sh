# Uncomment to change your shell to zsh

# allow users to change their shell without entering their password
# sudo apt install zsh
# echo 'auth       sufficient   pam_wheel.so trust group=chsh' | cat - /etc/pam.d/chsh > temp && sudo mv temp /etc/pam.d/chsh
# usermod -a -G chsh $(whoami)
# chsh -s $(which zsh) $(whoami)
# ln -s ~/zetup/zshrc.zsh ~/.zshrc
