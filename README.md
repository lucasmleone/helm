# Curso - Kubernetes primeros pasos

## Requisitos

- Python3 >= 3.8.0
- Multipass (https://multipass.run/install)
- pipx (https://pipx.pypa.io/stable/)
- K0sctl (https://github.com/k0sproject/k0sctl)

##

Lo primero sera clonar este proyecto

```bash
git clone https://github.com/yosoyfunes/ansible-k8s.git
```

## Instrucciones uso

### Instalación

```bash
pipx install --include-deps ansible
```

### Instalar pre-requisitos

```bash
make requirements
```

### Crear ambiente de prueba

```bash
make start
```

### Setup ambiente de K8s

```bash
make setup
```

### Configurar kubeconfig en K8s

```bash
make kubeconfig
```

### Destruir ambiente de prueba

```bash
make stop
```

## Capitulos

- [1. Instalación](./capitulos/1-install.md)
- [2. Configuración](./capitulos/2-config.md)
