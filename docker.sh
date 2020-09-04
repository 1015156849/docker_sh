#!/bin/bash
clear
# 定义颜色变量
red='\e[91m'
green='\e[92m'
yellow='\e[93m'
magenta='\e[95m'
cyan='\e[96m'
none='\e[0m'
_red() { echo -e ${red}$*${none}; }
_green() { echo -e ${green}$*${none}; }
_yellow() { echo -e ${yellow}$*${none}; }
_magenta() { echo -e ${magenta}$*${none}; }
_cyan() { echo -e ${cyan}$*${none}; }
# 开始脚本
menu_main=(
    dockerManager
    pcr_box网站
)
menu_pcrbox=(
    更新 网站
    仅更新 后台
    更新并启动 后台  
    启动 后台
    更新 代理配置
)
selectMenu
error() {
	echo -e "\n$red 输入错误！$none\n"
}
selectMenu(){
    echo 
    while :; do
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_main[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_main[*]}; i++)); do
                Stream="${menu_main[$i - 1]}"
                if [[ "$i" -le 9 ]]; then
                    # echo
                    echo -e "$yellow  $i. $none${Stream}"
                else
                    # echo
                    echo -e "$yellow $i. $none${Stream}"
                fi
            done
            echo
            read -p "$(echo -e "(请输入 ${cyan}序号$none)"):" menu_1
            [ -z "$menu_1" ] && menu_1=1
            case $menu_1 in
            [1-9] | [1-2][0-9] | 3[0-2])
                echo
                echo
                echo -e "$yellow 功能 = $cyan${menu_main[$menu_1 - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                selectMenu_pcrbox
                break
                ;;
            *)
                error
                ;;
            esac
    done
}

selectMenu_pcrbox(){
    clear
    echo 
    while :; do
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_pcrbox[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_pcrbox[*]}; i++)); do
                Stream="${menu_pcrbox[$i - 1]}"
                if [[ "$i" -le 9 ]]; then
                    # echo
                    echo -e "$yellow  $i. $none${Stream}"
                else
                    # echo
                    echo -e "$yellow $i. $none${Stream}"
                fi
            done
            echo
            read -p "$(echo -e "(请输入 ${cyan}序号$none)"):" menu_2
            [ -z "$menu_2" ] && menu_2=1
            case $menu_2 in
            [1-9] | [1-2][0-9] | 3[0-2])
                echo
                echo
                echo -e "$yellow 功能 = $cyan${menu_pcrbox[$menu_2 - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                break
                ;;
            *)
                error
                ;;
            esac
        done

}


# echo -e "${GREEN} docker管理脚本--------------- ${RES}"
# echo -e "${GREEN} 【1】注册 dockerManager${RES}"
# echo -e "${GREEN} 【2】更新 pcr_box网站${RES}"
# echo -e "${GREEN} 【3】更新 pcr_box网站后台 ${RES}"
# echo -e "${GREEN} 【4】启动 pcr_box网站后台 ${RES}"
# echo -e "${GREEN} 【5】更新 pcr_box 代理配置 ${RES}"
# echo -e "${GREEN} 请输入序号----------- ${RES}"
# read code
# case "$code" in
# 1)
#     echo -e "${YELLOW}->>开始执行 注册dockerManager 命令${RES}"
#     {
#         cp ~/docker_sh/caddy_docker /etc/caddy/sites
#         service caddy reload
#     }
#     echo -e "${GREEN}->>执行完毕${RES}"
# ;;
# 2)
#     echo -e "${YELLOW}->>开始执行 部署pcr_box网站前台 命令${RES}"
#     {
#         chmod +x ./vue-pcr/vue-pcr.sh
#         ./vue-pcr/vue-pcr.sh
#         chmod -x ./vue-pcr/vue-pcr.sh
#     }
# ;;
# 3)
#     echo -e "${YELLOW}->>开始执行 重新Build pcr_box网站后台 Docker镜像 命令${RES}"
#     {
#         docker rmi vuepcrserver:1.0
#         cd ./vue-pcr-server
#         docker build -t vuepcrserver:1.0 .
#     }
#     echo -e "${GREEN}->>执行完毕${RES}"
# ;;
# 4)
#     echo -e "${YELLOW}->>开始执行 部署pcr_box网站后台到docker并启动 命令${RES}"
#     {
#        chmod +x ./vue-pcr-server/vue-pcr-server.sh
#        ./vue-pcr-server/vue-pcr-server.sh
#        chmod -x ./vue-pcr-server/vue-pcr-server.sh
#     }
# ;;
# 5)
#     echo -e "${YELLOW}->>开始执行 部署pcr_box caddy 命令${RES}"
#     {
#         cp ~/docker_sh/vue-pcr-server/caddy_vue_pcr_box_server /etc/caddy/sites
#         service caddy reload
#     }
# ;;
# *)
# echo -e "${GREEN}退出脚本${RES}"
# ;;
# esac
chmod -x ./docker.sh