# Building Images
docker build -t clauke/k8s-multi-docker-client:latest -t clauke/k8s-multi-docker-client:$SHA -f ./client/Dockerfile ./client
docker build -t clauke/k8s-multi-docker-server:latest -t clauke/k8s-multi-docker-server:$SHA -f ./server/Dockerfile ./server
docker build -t clauke/k8s-multi-docker-worker:latest -t clauke/k8s-multi-docker-worker:$SHA -f ./worker/Dockerfile ./worker

# Push latest Images to Docker Hub
docker push clauke/k8s-multi-docker-client:latest
docker push clauke/k8s-multi-docker-server:latest
docker push cclauke/k8s-multi-docker-worker:latest

# Push SHA Images to Docker Hub for Version controll
docker push clauke/k8s-multi-docker-client:$SHA
docker push clauke/k8s-multi-docker-server:$SHA
docker push cclauke/k8s-multi-docker-worker:$SHA

# Apply the K8S Config
kubectl apply -f k8s

# Force to always use newest Image even without changes in configuration file(s)
kubectl set image deployments/server-deployment server=clauke/k8s-multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=clauke/k8s-multi-docker-client:$SHA
kubectl set image deployments/server-deployment server=clauke/k8s-multi-docker-client:$SHA
