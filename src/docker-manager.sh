#!/bin/bash
clear
# 开始脚本
menu_list_docker_manager=(
    安装
    卸载
)

_install_docker_manager(){
    docker pull portainer/portainer
    docker run -d -p 9000:9000 --restart=always  -v /var/run/docker.sock:/var/run/docker.sock -v portainer_data:/data -v /etc/ChaChaPRO/pcrbox/dockerManager/zh:/public --name portainer portainer/portainer
}
_uninstall_docker_manager(){
    docker stop portainer
    docker rm portainer
    docker rmi portainer/portainer
}
_menu_install_docker_manager(){
    while :; do
            echo
            Portainer
            echo -e "$yellow ........................................Docker管理网站..................................................$none"
            echo
            echo -e "$yellow 安装的管理面板为 Portainer.io，因为823 pma安全事故，暂不加入国产的宝塔平台安装脚本。如果必须要用宝塔，请自行动手 $none"
            echo
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_list_docker[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_list_docker[*]}; i++)); do
                Stream="${menu_list_docker[$i - 1]}"
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