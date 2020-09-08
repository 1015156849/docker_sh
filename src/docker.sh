#!/bin/bash
clear
# 开始脚本
menu_list_docker=(
    安装Docker
    卸载Docker
    查看镜像
    查看容器
)

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
            [ -z "$menu" ] && menu=1
            case $menu in
            [1-9] | [1-2][0-9] | 3[0-2])
                echo
                echo
                echo -e "$yellow 功能 = $cyan${menu_list_docker[$menu - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                case $menu in
                1)
                #安装
                ;;
                2)
                #卸载
                ;;
                3)
                #查看镜像
                ;;
                4)
                #查看容器
                ;;
                break
                ;;
            *)
                error
                ;;
            esac
        done

}