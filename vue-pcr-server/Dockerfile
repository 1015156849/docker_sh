FROM python:3.8
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/1015156849/pcr-guild-django.git
WORKDIR /data/pcr-guild-django
RUn pip install django-cors-headers
RUN pip install -r requirements.txt
RUN python manage.py migrate
EXPOSE 80
CMD python manage.py runserver 0.0.0.0:80