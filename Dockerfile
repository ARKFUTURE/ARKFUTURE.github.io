
FROM debian:testing
 
RUN apt-get update && apt-get install -y \ 
    curl \ 
    wget \
 
WORKDIR /work 
 
COPY . . 
 
CMD ["bash"] 