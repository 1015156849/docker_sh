#!/bin/bash
clear
# 开始脚本
menu_list_caddy=(
    安装
    卸载
)
_creat_default_caddy_config(){
    if cat /etc/caddy/Caddyfile | grep "import sites" >/dev/null 
    then
        echo "已经添加import sites/*"
    else
        cat >>/etc/caddy/Caddyfile<<-EOF
import sites/*
EOF
    fi
    service caddy start
    service caddy reload
}

_install_caddy(){
    if [[ -d /etc/caddy/ && -f /etc/caddy/Caddyfile ]]; then
		echo
		echo "你已经安装 caddy ...无需重新安装,如果有问题，请执行脚本中的卸载命令 （可能会导致其他软件配置失效，请自行确认）"
		echo
    else
    _load download-caddy.sh
	_download_caddy_file
	_install_caddy_service
    fi
    sed -i "16s/User=www-data/User=root/; 17s/Group=www-data/Group=root/" "/lib/systemd/system/caddy.service"
    systemctl daemon-reload
    _creat_default_caddy_config
    echo -e "$yellow ..........Caddy代理服务 安装完毕 ..........$none"
    
}
_uninstall_caddy(){
    service caddy stop
    apt-get remove caddy
    rm -rf /etc/caddy/
    echo -e "$yellow ..........Caddy代理服务 卸载完毕 ..........$none"
}
_menu_install_caddy(){
    while :; do
            echo
            echo -e "$yellow ..........Caddy代理服务 ..........$none"
            echo
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_list_caddy[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_list_caddy[*]}; i++)); do
                Stream="${menu_list_caddy[$i - 1]}"
                if [[ "$i" -le 9 ]]; then
                    # echo
                    echo -e "$yellow  $i. $none${Stream}"
                else
                    # echo
                    echo -e "$yellow $i. $none${Stream}"
                fi
            done
            echo
            read -p "$(echo -e "(请输入 ${cyan}序号$none)"):" menu
            case $menu in
            1)
                _install_caddy
                break
                ;;
            2)
                _uninstall_caddy
                break
                ;;
            *)
                error
                ;;
            esac
        done

}