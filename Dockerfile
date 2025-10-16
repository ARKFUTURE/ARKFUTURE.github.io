
FROM debian:stable
 
RUN apt-get update && apt-get install -y curl wget \
    && apt-get clean
 
WORKDIR /work 
 
COPY . . 
 
CMD ["bash"] 