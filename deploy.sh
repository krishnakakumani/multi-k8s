docker build -t kotinephew/multi-client:latest -t kotinephew/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t kotinephew/multi-server:latest -t kotinephew/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t kotinephew/multi-worker:latest -t kotinephew/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push kotinephew/multi-client:latest
docker push kotinephew/multi-server:latest
docker push kotinephew/multi-worker:latest

docker push kotinephew/multi-client:$SHA
docker push kotinephew/multi-server:$SHA
docker push kotinephew/multi-worker:$SHA
kubectl apply -f k8s
kubectl set image deployments/server-deployment server=kotinephew/multi-server:$SHA
kubectl set image deployments/client-deployment client=kotinephew/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=kotinephew/multi-worker:$SHA


