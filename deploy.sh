docker build -t gushov/multi-client:latest -t gushov/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t gushov/multi-server:latest -t gushov/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t gushov/multi-worker:latest -t gushov/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push gushov/multi-client:latest
docker push gushov/multi-server:lastest
docker push gushov/multi-worker:latest
docker push gushov/multi-client:$SHA
docker push gushov/multi-server:$SHA
docker push gushov/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=gushov/multi-server:$SHA
kubectl set image deployments/client-deployment client=gushov/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=gushov/multi-worker:$SHA