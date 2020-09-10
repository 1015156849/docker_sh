#!/bin/bash
clear
# 开始脚本
menu_list_docker=(
    安装
    卸载
)
_install_docker(){
    echo -e "$yellow ..........Docker安装过程中，请不要输入任何字符！..........$none"
    apt-get update
    curl -fsSL https://get.docker.com | bash -s docker --mirror Aliyun
    systemctl start docker
    systemctl enable docker
    echo -e "$green ..........Docker安装完毕..........$none"
}
_uninstall_docker(){
    apt-get remove docker docker-engine docker-ce docker.io
    rm -rf /var/lib/docker
    echo -e "$green ..........Docker卸载完毕..........$none"
}
_menu_install_docker(){
    while :; do
            echo
            echo -e "$yellow ..........Docker ..........$none"
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
                _install_docker
                break
                ;;
                2)
                #卸载
                _uninstall_docker
                break
                ;;
            *)
                error
                ;;
            esac
        done

}