#!/bin/bash
# 开始脚本
menu_list_yobot=(
    一键部署
    修改域名
)

_creat_yobot_web_caddy_config(){
    while :; do
		echo
		echo -e "请输入一个 $magenta正确的域名$none，来映射到yobot网站"
		read -p "(例如：github.com): " yobot_web_url
		[ -z "$yobot_web_url" ] && error && continue
		echo
		echo
		echo -e "$yellow 你的域名 = $cyan$yobot_web_url$none"
		echo "----------------------------------------------------------------"
                echo -e "$green 更新Caddy代理配置$none"
                cat >/etc/caddy/sites/caddy_yobot_web<<-EOF
$yobot_web_url {
    gzip
    proxy / 127.0.0.1:10263
}
EOF
    service caddy restart
    service caddy reload
       
		break
	done
   
}
_init_bot(){
    while :; do
		echo
		echo -e "请输入一个 $magenta正确的QQ号$none，配置到yobot"
		read -p ": " botqqid
		[ -z "$botqqid" ] && error && continue
		echo
		echo
		echo -e "$yellow 你的机器人QQ = $cyan$botqqid$none"
		echo "----------------------------------------------------------------"
            while :; do
                echo
                echo -e "请输入一个 $magenta正确的密码$none，配置到yobot"
                read -p ": " botqqpswd
                [ -z "$botqqpswd" ] && error && continue
                echo
                echo
                echo -e "$yellow 你的机器人QQ密码 = $cyan$botqqpswd$none"
                echo "----------------------------------------------------------------"
                _config_bot_qq
                break
            done
        break
	done
}
_config_bot_qq(){
# 创建持久化文件夹
cd 
miraidir=$(pwd)/mirai
mkdir ${miraidir}

# 配置自动登录文件
echo "
----------
login ${botqqid} ${botqqpswd}

" > ${miraidir}/config.txt
# 如果你需要手动编辑这个文件，请注意：
# 第一行的 ---------- 不可省略
# 最后一个换行不可省略
# 换行必须使用 \n，不能用 \r\n（不要在 Windows 下编辑再上传）

# 配置 cqhttp-mirai
echo "
\"${botqqid}\":
  ws_reverse:
    - enable: true
      postMessageFormat: string
      reverseHost: yobot
      reversePort: 10263
      reversePath: /ws/
      accessToken: null
      reconnectInterval: 3000
" > ${miraidir}/setting.yml
}
_install_yobot(){
    docker network create qqbotnet    
    docker pull yobot/yobot
    docker run -d --name yobot -p 10263:9222 -v $(pwd)/yobot_data:/yobot/yobot_data --network qqbotnet yobot/yobot
    _creat_yobot_web_caddy_config
    echo -e "$yellow ..........yobot网站安装完成 ..........$none"
    echo -e "$yellow ..........开始安装mirai ..........$none"
    docker pull lqbing/miraiok
    _init_bot
    docker run -it \  # 首次启动建议使用 -it 在前台交互，以便输入验证码
                --name miraiok \
                -v ${miraidir}/tmp:/tmp \
                -v ${miraidir}/config.txt:/workdir/config.txt \
                -v ${miraidir}/setting.yml:/workdir/plugins/CQHTTPMirai/setting.yml \
                -v ${miraidir}/device.json:/workdir/device.json \
                -v ${miraidir}/log:/workdir/log \
                --network qqbotnet \
                lqbing/miraiok
}

_menu_install_yobot(){
    while :; do
            echo
            echo -e "$yellow ..........yobot机器人 ..........$none"
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
            case $menu in
            1)
            #一键部署
            _install_yobot
            break
            ;;
            2)
            #修改域名
            _creat_yobot_web_caddy_config
            break
            ;;
            *)
            error
            ;;
            esac
        done
}
