cat >> ~/.config/kitty/kitty.conf << EOF
font_size 18
font_family SF Mono
linux_display_server wayland
EOF

cat > ~/.pam_environment << EOF
GTK_IM_MODULE DEFAULT=ibus
QT_IM_MODULE DEFAULT=ibus
XMODIFIERS DEFAULT=@im=ibus
GLFW_IM_MODULE DEFAULT=ibus  
EOF

echo "Kitty 配置完成，重启 Kitty 即可"
