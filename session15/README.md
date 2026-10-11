### REF https://github.com/nicholasjackson/fake-service.git
```
wget https://github.com/nicholasjackson/fake-service/releases/download/v0.26.2/fake_service_linux_amd64.zip

unzip fake_service_linux_amd64.zip

sudo chmod +x fake-service

NAME=ratings LISTEN_ADDR=0.0.0.0:9095 MESSAGE="Response from ratings" ./fake-service &
NAME=details LISTEN_ADDR=0.0.0.0:9094 MESSAGE="Response from details" ./fake-service &
NAME=reviews-1 LISTEN_ADDR=0.0.0.0:9091 MESSAGE="Response from reviews-1" ./fake-service &
NAME=reviews-2 LISTEN_ADDR=0.0.0.0:9092 MESSAGE="Response from reviews-2" UPSTREAM_URIS="http://localhost:9095" ./fake-service &
NAME=reviews-3 LISTEN_ADDR=0.0.0.0:9093 MESSAGE="Response from reviews-3" UPSTREAM_URIS="http://localhost:9095" ./fake-service &
NAME=productpage LISTEN_ADDR=0.0.0.0:9090 MESSAGE="Response from productpage" \
UPSTREAM_URIS="http://localhost:9091,http://localhost:9092,http://localhost:9093,http://localhost:9094" \
UPSTREAM_WORKERS=4 \
./fake-service &


pgrep -a fake-service
curl -s localhost:9090 | jq -r '.. | .name? // empty'


```


### only accessible by product page only
```
NAME=ratings LISTEN_ADDR=localhost:9095 MESSAGE="Response from ratings" ./fake-service & NAME=details LISTEN_ADDR=localhost:9094 MESSAGE="Response from details" ./fake-service & NAME=reviews-1 LISTEN_ADDR=localhost:9091 MESSAGE="Response from reviews-1" ./fake-service & NAME=reviews-2 LISTEN_ADDR=localhost:9092 MESSAGE="Response from reviews-2" UPSTREAM_URIS="http://localhost:9095" ./fake-service & NAME=reviews-3 LISTEN_ADDR=localhost:9093 MESSAGE="Response from reviews-3" UPSTREAM_URIS="http://localhost:9095" ./fake-service & NAME=productpage LISTEN_ADDR=0.0.0.0:9090 MESSAGE="Response from productpage" UPSTREAM_URIS="http://localhost:9091,http://localhost:9092,http://localhost:9093,http://localhost:9094" UPSTREAM_WORKERS=4 ./fake-service &


kill $(lsof -t -i :9090-9095) 
pkill fake-service

lsof -t -i :9090-9095

```


NAME=ratings LISTEN_ADDR=localhost:9095 MESSAGE="Response from ratings" ./fake-service & NAME=details LISTEN_ADDR=localhost:9094 MESSAGE="Response from details" ./fake-service & NAME=reviews-1 LISTEN_ADDR=localhost:9091 MESSAGE="Response from reviews-1" ./fake-service & NAME=reviews-2 LISTEN_ADDR=localhost:9092 MESSAGE="Response from reviews-2" UPSTREAM_URIS="http://localhost:9095" ./fake-service & NAME=reviews-3 LISTEN_ADDR=localhost:9093 MESSAGE="Response from reviews-3" UPSTREAM_URIS="http://localhost:9095" ./fake-service & NAME=productpage LISTEN_ADDR=0.0.0.0:9090 MESSAGE="Response from productpage" UPSTREAM_URIS="http://localhost:9091,http://localhost:9092,http://localhost:9093,http://localhost:9094" UPSTREAM_WORKERS=4 ./fake-service &


NAME=account-svc LISTEN_ADDR=0.0.0.0:9092 MESSAGE="Response from account-svc" UPSTREAM_URIS="http://localhost:9093" ./fake-service 


NAME=account-svc LISTEN_ADDR=0.0.0.0:9092 MESSAGE="Response from account-svc" UPSTREAM_URIS="http://localhost:9093" \
nohup ./fake-service > account-svc.log 2>&1 &


NAME=account-svc LISTEN_ADDR=0.0.0.0:9091 MESSAGE="Response from profile-svc" UPSTREAM_URIS="http://172.16.3.82:9092" \
nohup ./fake-service > profile-svc.log 2>&1 &
