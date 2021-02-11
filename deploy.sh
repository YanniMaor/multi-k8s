docker build -t maoryanni/multi-client:latest -t maoryanni/multi-client:$SHA -f ./client/Dockerfile ./client
docker build -t maoryanni/multi-server:latest -t maoryanni/multi-server:$SHA -f ./server/Dockerfile ./server
docker build -t maoryanni/multi-worker:latest -t maoryanni/multi-worker:$SHA -f ./worker/Dockerfile ./worker

docker push maoryanni/multi-client:latest
docker push maoryanni/multi-server:latest
docker push maoryanni/multi-worker:latest

docker push maoryanni/multi-client:$SHA
docker push maoryanni/multi-server:$SHA
docker push maoryanni/multi-worker:$SHA

kubectl apply -f k8s
kubectl set image deployment/server-deployment server=maoryanni/multi-server:$SHA
kubectl set image deployment/client-deployment client=maoryanni/multi-client:$SHA
kubectl set image deployment/worker-deployment worker=maoryanni/multi-worker:$SHA