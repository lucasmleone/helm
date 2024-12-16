# Configuración de un Clúster Kubernetes con K0sctl

Este archivo describe cómo configurar e instalar un clúster Kubernetes utilizando **K0sctl**, una herramienta para gestionar clústeres basados en **k0s** de manera simple y efectiva. Sigue los pasos detallados para inicializar, configurar e implementar tu clúster.

---

## Requisitos Previos

1. **Servidor/VM Controlador y Workers**:
   - Un nodo controlador y uno o más nodos de trabajo.
   - Asegúrate de tener acceso SSH a estos nodos.
   - Cada nodo debe tener una clave SSH configurada y permisos de administrador (sudo).

2. **Herramientas Necesarias**:
   - [k0sctl](https://github.com/k0sproject/k0sctl): Instalado en tu máquina local.
   - [kubectl](https://kubernetes.io/docs/tasks/tools/): Instalado para interactuar con el clúster.

3. **Red y Seguridad**:
   - Asegúrate de que los puertos necesarios para Kubernetes estén abiertos.
   - Configura las direcciones IP de los nodos y las claves SSH adecuadas.

---

## Pasos para Configurar el Clúster

### 1. Crear el archivo de configuración inicial

Usa el siguiente comando para generar un archivo de configuración básico para k0sctl:

```bash
k0sctl init > k0sctl.yaml
```

Este archivo será la base para definir los nodos de tu clúster.

---

### 2. Configurar los nodos en el archivo `k0sctl.yaml`

Edita el archivo generado para incluir la información de los nodos (Controlador y Workers). Aquí tienes un ejemplo de configuración:

```yaml
apiVersion: k0sctl.k0sproject.io/v1beta1
kind: Cluster
metadata:
  name: k0s-cluster
spec:
  hosts:
  - ssh:
      address: 192.168.105.21 # Dirección IP del nodo
      user: ubuntu            # Usuario SSH
      port: 22                # Puerto SSH
      keyPath: .ssh/id_rsa    # Ruta de la clave SSH privada
    role: controller          # Rol del nodo
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

#### Opcional: Configurar nodos híbridos
Si deseas que el nodo controlador también actúe como Worker, puedes cambiar su rol de esta manera:

```yaml
role: controller+worker
```

---

### 3. Aplicar la configuración e instalar Kubernetes

Ejecuta el siguiente comando para aplicar los cambios y desplegar el clúster:

```bash
k0sctl apply --config ./k0sctl.yaml
```

---

### 4. Generar el archivo de configuración para `kubectl`

Una vez que el clúster esté desplegado, genera el archivo de configuración para `kubectl` con el siguiente comando:

```bash
k0sctl kubeconfig --config k0sctl.yaml > k0s.config
```

---

### 5. Configurar `kubectl`

Establece la variable de entorno `KUBECONFIG` para usar el archivo generado:

```bash
export KUBECONFIG=/path/to/k0s.config
```

Esto permitirá que `kubectl` interactúe con el clúster recién creado.

---

## Validar la Configuración

Después de completar los pasos anteriores, valida que el clúster esté operativo:

1. **Verificar los nodos disponibles**:
   ```bash
   kubectl get nodes
   ```

2. **Comprobar el estado del clúster**:
   ```bash
   kubectl cluster-info
   ```

---

## Referencias

- [Documentación oficial de K0sctl](https://docs.k0sproject.io/k0sctl/)
- [Kubernetes CLI (`kubectl`)](https://kubernetes.io/docs/reference/kubectl/)

---

Este README te guiará desde la configuración básica hasta la validación del clúster, asegurándote de que tu entorno Kubernetes esté listo para desplegar aplicaciones.
