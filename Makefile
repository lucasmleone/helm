requirements:
	@ansible-galaxy install -r requirements.yaml

start:
	@ansible-playbook vms.yaml -t "start"

stop:
	@ansible-playbook vms.yaml -t "stop"

setup:
	@k0sctl apply --config ./k0sctl.yaml

kubeconfig:
	@k0sctl kubeconfig --config k0sctl.yaml > k0s.config
	export KUBECONFIG=./k0s.config

clean:
	@rm -rf k0s.config
	@rm -rf k0sctl.yaml
	@rm -rf inventory.ini
	@rm -rf .ssh
	multipass delete k8s-controller --purge
	multipass delete k8s-worker --purge
