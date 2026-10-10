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
