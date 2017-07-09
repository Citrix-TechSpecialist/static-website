FROM controlchannels/alpine-nginx
COPY ./webapp /var/www
RUN mkdir /etc/nginx/ssl
ADD ./certs/server.crt /etc/nginx/ssl
ADD ./certs/server.key /etc/nginx/ssl
CMD 'nginx'
