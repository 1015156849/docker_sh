#!/bin/bash
clear
# 开始脚本
menu_list_caddy=(
    安装
    卸载
)
_creat_default_caddy_config(){
    rm /etc/caddy/Caddyfile
    touch /etc/caddy/Caddyfile
    cat >>/etc/caddy/Caddyfile<<-EOF
import sites/*
EOF
    service caddy start
    service caddy reload
}

_install_caddy(){
    _load download-caddy.sh
	_download_caddy_file
	_install_caddy_service
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