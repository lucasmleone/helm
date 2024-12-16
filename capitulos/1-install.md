
Crear archivo de configuracion de K0sctl
```
k0sctl init > k0sctl.yaml
```

Agregar los Workers en configuracion
```
apiVersion: k0sctl.k0sproject.io/v1beta1
kind: Cluster
metadata:
  name: k0s-cluster
spec:
  hosts:
  - ssh:
      address: 192.168.105.21
      user: ubuntu
      port: 22
      keyPath: .ssh/id_rsa
    role: controller
  - ssh:
      address: 192.168.105.22
      user: ubuntu
      port: 22
      keyPath: .ssh/id_rsa
    role: worker
  - ssh:
      address: 44.211.155.146
      user: ubuntu
      port: 22
      keyPath: .ssh/vockey
    role: worker
```

Opcional cambiar el Role del controller
```
role: controller+worker
```

Aplicar cambios para instalar Kubernetes
```
k0sctl apply --config ./k0sctl.yaml
```

Crear el archivo de kubeconfig
```
k0sctl kubeconfig --config k0sctl.yaml > k0s.config
```

setear variable de KUBECTL
```
export KUBECONFIG=/path/to/k0s.config
```
