# Monitor URLs and Display using Prometheus and Grafana

Monitor a list of URLs with Golang instrumented with Prometheus served on a Kubernetes Cluster and Display using Grafana

---

## Summary

-   A service written in Golang that queries two sample urls every 5 seconds:
    -   https://httpstat.us/503
    -   https://httpstat.us/200
-   The service checks:
    -   The external urls are up (based on http status code 200) return `1` if up, `0` if otherwise
    -   Response time in milliseconds
-   The service will run a simple http service that produces metrics (on `/metrics`) and output a Prometheus format when curling the service `/metrics` url

**Sample Response Format**:
sample_external_url_up{url="https://httpstat.us/200 "}  = 1
sample_external_url_response_ms{url="https://httpstat.us/200 "}  = [value]
sample_external_url_up{url="https://httpstat.us/503 "}  = 0
sample_external_url_response_ms{url="https://httpstat.us/503 "}  = [value]
___

## Technology Used

-   [Golang]
-   [Prometheus]
-   [Kubernetes]
-   [Helm]
-   [Grafana]

## Project Configuration

## Set-up

1. Configure [conf.json](conf.json) with URLs you wish to monitor

{
    "urls": ["https://httpstat.us/200", "https://httpstat.us/503"]
}

2. Build Docker image and push to repository of your choosing

docker build -t monitor-urls .
docker push monitor-urls

3. Create `monitoring` namespace

kubectl create namespace monitoring

4. Use `helm` to install Prometheus and Grafana to namespace
---

### Testing (Docker + MiniKube)

1. Install Minikube

2. Run `kubectl apply`

kubectl apply -f service.yml

3. View the deployment

kubectl get deployments

4. View the service

kubectl get services


---

## Tests

go test


## Configure Grafana
Configure Prometheus URL in Grafana Dashboard.
Prometheus URL: http://localhost:9090
Grafana URL: http://localhost:3000
