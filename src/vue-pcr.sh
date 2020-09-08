#!/bin/bash
clear
# 开始脚本
menu_list_pcr_box_vue=(
    更新网站
    仅更新后台
    仅启动后台
    更新并启动后台
    更新代理配置
)

installHtml(){
    chown root:root /etc/caddy/www
    mkdir -p /etc/caddy/www/vuepcr
    cd /etc/caddy/www/vuepcr 
    wget -c https://github.com/1015156849/pcr-guild-vue/releases/download/1.0/dist.zip
    unzip dist.zip
    rm dist.zip
}
cleanServer(){
    stopServer
    docker rmi vuepcrserver   
}
buildServer(){
    docker build -t vuepcrserver:1.0 ~/docker_sh/pcr_box/.
}
stopServer(){
    docker stop vuepcrserver
    docker rm vuepcrserver
}
runServer(){
    docker run -itd -p 8081:80 --name vuepcrserver vuepcrserver:1.0
        
}
updateCaddy(){
    cp ~/docker_sh/pcr_box/caddy_vue_pcr_box_server /etc/caddy/sites
    service caddy reload
}

_menu_install_pcr_box_vue(){
    while :; do
            echo
            echo -e "$yellow ..........公主连结公会战box网站 ..........$none"
            echo
            echo -e "请选择 "$yellow"功能"$none" 序号 [${magenta}1-${#menu_list_pcr_box_vue[*]}$none]"
            echo
            for ((i = 1; i <= ${#menu_list_pcr_box_vue[*]}; i++)); do
                Stream="${menu_list_pcr_box_vue[$i - 1]}"
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
                echo -e "$yellow 功能 = $cyan${menu_list_pcr_box_vue[$menu - 1]}$none"
                echo "----------------------------------------------------------------"
                echo
                ;;
            1)
            #更新网站
            installHtml
            break
            ;;
            2)
            #仅更新后台
            cleanServer
            buildServer
            updateCaddy
            break
            ;;
            3)
            #仅启动后台
            stopServer
            runServer
            updateCaddy
            break
            ;;
            4)
            #更新并启动后台
            cleanServer
            buildServer
            runServer
            updateCaddy
            break
            ;;
            5)
            #更新代理配置
            updateCaddy
            break
            ;; 
            *)
                error
                ;;
            esac
        done
}
