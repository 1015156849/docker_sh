## 选node作为基础镜像
FROM python:3.8
##换源安装vuecli
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/CJowo/pcr-guild-django.git
WORKDIR /data/pcr-guild-django
RUN pip install -r requirements.txt
RUN python manage.py migrate
RUN python manage.py runserver 0.0.0.0:80

