user=$(echo $USER)

if [ $user != "root" ]
then
  echo "请通过root身份运行脚本"
  exit 1
fi

pacman -S --noconfirm fcitx5 fcitx5-qt fcitx5-gtk fcitx5-configtool fcitx5-chinese-addons

cat >> /etc/environment << EOF
INPUT_METHOD=fcitx5
GTK_IM_MODULE=fcitx5
QT_IM_MODULE=fcitx5
XMODIFIERS=@im=fcitx5
EOF

echo "
======================
配置完成，请重启电脑
======================
"
