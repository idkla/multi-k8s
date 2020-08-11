docker build -t idkla/multi-client:latest -t idkla/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t idkla/multi-server:latest -t idkla/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t idkla/multi-worker:latest -t idkla/multi-worker:$SHA -f ./worker/Dockerfile ./worker
docker push idkla/multi-client:latest
docker push idkla/multi-server:latest
docker push idkla/multi-worker:latest

docker push idkla/multi-client:$SHA
docker push idkla/multi-server:$SHA
docker push idkla/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployments/server-deployment server=idkla/multi-server:$SHA
kubectl set image deployments/client-deployment client=idkla/multi-client:$SHA
kubectl set image deployments/worker-deployment worker=idkla/multi-worker:$SHA