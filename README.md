# packer-azure
[Packer](https://packer.io/) with [packer-azure](https://github.com/MSOpenTech/packer-azure) plugin

Example: to bash in with packer on path and files in current working directory -

```
docker run --interactive --tty --volume `pwd`:/packer/files lukewpatterson/packer-azure
```
