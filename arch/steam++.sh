cat << EOF
目前在NyArch上测试过，执行完后，重启。
重启后，再次打开，仍汇报错，再次打开，证书异常解决
EOF
read test

sudo trust anchor --store SteamTools.Certificate.cer
sudo update-ca-trust extract
