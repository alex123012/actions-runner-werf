# actions-runner-werf
actions runner image and instruct for werf
# Actions-runner
For deploying RunnerDeployment you must consider some points:
- Use proper security contexts
- Build image wth proper utils
- mount fuse device [with plugin](https://werf.io/documentation/v1.2/advanced/ci_cd/run_in_container/use_kubernetes.html#linux-kernel-without-rootless-overlayfs-and-non-privileged-container) (if you use _Linux kernel without rootless OverlayFS and non-privileged container_)
- if you use _Linux kernel without rootless OverlayFS and non-privileged container_ don't forget to [mount your fuse device](https://github.com/kuberenetes-learning-group/fuse-device-plugin#%E4%BD%BF%E7%94%A8)

# Template for _Linux kernel without rootless OverlayFS and non-privileged container_
```yaml
apiVersion: actions.summerwind.dev/v1alpha1
kind: RunnerDeployment
metadata:
  name: runner
  namespace: actions-runner-system
spec:
  replicas: 1
  template:
    metadata:
      annotations:
        container.apparmor.security.beta.kubernetes.io/runner: unconfined
    spec:
      imagePullSecrets:
      - name: registrysecret
      image: <Builded image>
      securityContext:
        seccompProfile:
          type: Unconfined
      organization: MyOrg
      dockerEnabled: false
      resources:
        limits:
          github.com/fuse: 1
```
