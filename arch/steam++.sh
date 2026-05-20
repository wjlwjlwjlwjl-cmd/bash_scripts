CER="$HOME/.local/share/Steam++/Plugins/Accelerator/SteamTools.Certificate.cer"
sudo cp "$CER" /etc/ca-certificates/trust-source/anchors/
sudo update-ca-trust extract

echo "alias watt-toolkit='watt-toolkit --no-browser-certificate'" >> ~/.bashrc
source ~/.bashrc

sudo chmod a+w /etc/hosts
