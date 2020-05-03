FROM debian:stable

RUN apt-get update

RUN apt-get install -y git python2.7 python-psycopg2 python-django rabbitmq-server python-pip

RUN git clone --recursive git://github.com/benadida/helios-server.git /helios

WORKDIR /helios

RUN pip install -r requirements.txt

ENV DEBUG 0
ENV SECRET_KEY ChangeMe
ENV URL_HOST http://localhost:8000/
ENV SECURE_URL_HOST https://localhost:8000/
ENV EMAIL_HOST localhost
ENV EMAIL_PORT 25
ENV EMAIL_USE_TLS 1
ENV DEFAULT_FROM_EMAIL helios@example.org
ENV DEFAULT_FROM_NAME Helios
ENV HELP_EMAIL_ADDRESS help@example.org
ENV AUTH_ENABLED_AUTH_SYSTEMS password
ENV AUTH_ENABLED_AUTH_SYSTEM password
ENV TIME_ZONE 'Europe/Amsterdam'
ENV HELIOS_PRIVATE_DEFAULT 1
ENV DATABASE_URL postgres://

EXPOSE 8000

CMD env \
    VOTER_UPLOAD_REL_PATH='voters/%Y/%m/%d' \
    DATABASE_URL=${DATABASE_URL} \
    python manage.py runserver 0.0.0.0:8000

