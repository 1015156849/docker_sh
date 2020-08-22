FROM python:3.8
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/CJowo/pcr-guild-django.git
WORKDIR /data/pcr-guild-django
RUN pip install -r requirements.txt
RUN python manage.py migrate
EXPOSE 80
CMD ["/bin/bash","python manage.py runserver 0.0.0.0:80"]