## 选node作为基础镜像
FROM node:latest
##换源安装vuecli
RUN \
npm install -g @vue/cli \
&& npm install -g @quasar/cli
## 创建一个目录
RUN mkdir /data
## 指定工作目录
WORKDIR /data
RUN git clone https://github.com/CJowo/pcr-guild-vue.git 
WORKDIR /data/pcr-guild-vue
RUN npm install
RUN quasar build

