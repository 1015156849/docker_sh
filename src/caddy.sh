#!/bin/bash
clear
# 开始脚本
menuList=(
    安装
    卸载
    启动
    重启
    停止
    查看运行状态

)

selectMenu(){
    clear
    echo 
    while :; do
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menuList[*]}$none]"
            echo
            for ((i = 1; i <= ${#menuList[*]}; i++)); do
                Stream="${menuList[$i - 1]}"
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
                echo -e "$yellow 功能 = $cyan${menuList[$menu - 1]}$none"
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

selectMenu
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
chmod -x ./install.sh