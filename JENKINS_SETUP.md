# Jenkins Credentials Setup Guide

## 1. Docker Hub Credentials
**Type:** Username with password  
**ID:** docker-hub-credentials  
**Username:** ytthpch (Docker Hub username)  
**Password:** Docker Hub password or access token  

### Steps:
1. Dashboard > Manage Jenkins > Manage Credentials
2. Stores scoped to Jenkins > (global) > Add Credentials
3. Kind: Username with password
4. Username: ytthpch
5. Password: [Docker Hub password/token]
6. ID: docker-hub-credentials
7. Scope: Global

## 2. Environment Variables Credentials
**Type:** Secret text  
**ID:** nestjs-jenkin-k8s-env  
**Secret:** 
```
NODE_ENV=production
PORT=3000
API_VERSION=1.0
```

### Steps:
1. Same location as above
2. Kind: Secret text
3. Secret: [Paste the env variables above]
4. ID: nestjs-jenkin-k8s-env
5. Scope: Global

## 3. Kubernetes Credentials (Optional - for later)
**Type:** Kubernetes configuration (kubeconfig)  
**ID:** k8s-config  

### Steps:
1. Generate kubeconfig: `kubectl config view --raw > kubeconfig.yaml`
2. Kind: Kubernetes configuration (kubeconfig)
3. Upload kubeconfig.yaml file
4. ID: k8s-config

## 4. Docker Hub Access Token (Recommended)
Instead of password, use access token:
1. Go to Docker Hub > Account Settings > Security
2. Create new Access Token
3. Use token as password in credentials

## Current Jenkinsfile Features:
✅ Node.js 20 setup with nvm  
✅ Build application  
✅ Build Docker image  
✅ Push to Docker Hub  
❌ Kubernetes deployment (commented out)  

## To Enable Kubernetes:
1. Set up k8s-config credentials
2. Uncomment Kubernetes stages in Jenkinsfile
