# ArgoCD Blue/Green Demo (nginx = blue, Apache = green)

Both versions run all the time. A single Service (`demo`) decides which one gets live traffic.
The switch is a Git commit that changes the Service selector; Argo CD syncs it. Rollback = switch back.

## Steps
1. Push this folder to your own Git repo (branch `main`).
2. `./01-argocd-install/install.sh` (needs a running cluster, e.g. kind/minikube)
3. `./03-argocd-app/apply.sh https://github.com/YOU/argocd-blue-green.git`
4. Check: `kubectl -n bluegreen get deploy,svc` then `./04-switch/test.sh` -> BLUE (nginx)
5. Preview green before switching: `kubectl -n bluegreen port-forward svc/demo-green 8082:80`
6. Switch: `./04-switch/switch.sh green` -> `test.sh` shows GREEN (Apache)
7. Rollback: `./04-switch/switch.sh blue`

Repo layout: `02-app/base` (both deployments, services, HTML), `02-app/overlays/active` (the only thing that changes).
Private repo: add credentials with `argocd repo add`.
