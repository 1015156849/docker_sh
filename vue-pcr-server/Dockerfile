FROM python:3.8
RUN mkdir /data
WORKDIR /data
RUN git clone https://github.com/1015156849/pcr-guild-django.git
WORKDIR /data/pcr-guild-django
RUN pip install -r requirements.txt
RUN pip install django-extensions
RUN pip install django-werkzeug-debugger-runserver
RUN pip install pyOpenSSL
RUN python manage.py migrate
EXPOSE 80
CMD python manage.py runserver_plus --cert server.crt 0.0.0.0:80