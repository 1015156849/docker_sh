#!/bin/bash
clear
# 开始脚本
menu_list_docker_manager=(
    安装
    卸载
)
_creat_docker_manager_caddy_config(){
    rm /etc/caddy/sites/caddy_docker
    touch /etc/caddy/sites/caddy_docker
    cat >/etc/caddy/sites/caddy_docker<<-EOF
$portainer_url  {
    gzip
    timeouts none
    proxy / 127.0.0.1:9000
}
EOF
    service caddy reload
}

_install_docker_manager(){
    docker pull portainer/portainer
    docker run -d -p 9000:9000 --restart=always  -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /etc/ChaChaPRO/pcrbox/dockerManager/zh:/public --name portainer portainer/portainer

    while :; do
		echo
		echo -e "请输入一个 $magenta正确的域名$none，来映射到Docker管理网站"
		read -p "(例如：github.com): " portainer_url
		[ -z "$portainer_url" ] && error && continue
		echo
		echo
		echo -e "$yellow 你的域名 = $cyan$portainer_url$none"
		echo "----------------------------------------------------------------"
        _creat_docker_manager_caddy_config
       
		break
	done
}
_uninstall_docker_manager(){
    docker stop portainer
    docker rm portainer
    docker rmi portainer/portainer
    rm /etc/caddy/sites/caddy_docker
    service caddy reload
}
_menu_install_docker_manager(){
    while :; do
            echo
            echo -e "$yellow ........................................Docker管理网站..................................................$none"
            echo
            echo -e "$yellow 安装的管理面板为 Portainer.io，因为823 pma安全事故，暂不加入国产的宝塔平台安装脚本。如果必须要用宝塔，请自行动手 $none"
            echo
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_list_docker_manager[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_list_docker_manager[*]}; i++)); do
                Stream="${menu_list_docker_manager[$i - 1]}"
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
                    #安装
                    _install_docker_manager
                    break
                    ;;
                2)
                    #卸载
                    _uninstall_docker_manager
                    break
                    ;;
                *)
                    error
                    ;;
            esac
        done

}