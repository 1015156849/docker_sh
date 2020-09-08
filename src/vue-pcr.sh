#!/bin/bash
clear
# 开始脚本
menuList=(
    更新网站
    仅更新后台
    仅启动后台
    更新并启动后台
    更新代理配置
)
error() {
	echo -e "\n$red 输入错误！$none\n"
}

installHtml(){
    chown www-data:www-data /etc/caddy/www
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
                case $menu in
                            1)
                            #更新网站
                            installHtml
                            ;;
                            2)
                            #仅更新后台
                            cleanServer
                            buildServer
                            updateCaddy
                            ;;
                            3)
                            #仅启动后台
                            stopServer
                            runServer
                            updateCaddy
                            ;;
                            4)
                            #更新并启动后台
                            cleanServer
                            buildServer
                            runServer
                            updateCaddy
                            ;;
                            5)
                            #更新代理配置
                            updateCaddy
                            ;;
                
                break
                ;;
            *)
                error
                ;;
            esac
        done
}
selectMenu