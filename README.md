# packer-azure

Installed, active, on path:

- [Packer](https://packer.io/)
- **[packer-azure](https://github.com/MSOpenTech/packer-azure) plugin**
- Azure Xplat-CLI [azure-cli](https://www.npmjs.com/package/azure-cli) npm module
    - Bash [auto-completion](https://www.npmjs.com/package/azure-cli#configure-autocomplete)


Example: to bash in with packer on path and files in current working directory -

```
docker run --interactive --tty --volume `pwd`:/packer/files lukewpatterson/packer-azure
```

See [lukewpatterson/azure](https://registry.hub.docker.com/u/lukewpatterson/packer-azure/) in Docker Hub
