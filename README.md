# EC2-local

<img src="https://user-images.githubusercontent.com/7730843/216323604-7770ac01-f385-4fdb-bfd1-0d7c62a29b92.png" alt="sample" width="500px">

Create a virtual machine like Amazon Linux 2 for local.

## Requirements
- Docker
- Make

## Installation
```
make build
```

## Usage
```
USAGE
  make [TARGET]([ARGS])

TARGETS
  help                 print help message
  down                 stop containers
  destroy              remove all containers, images, and volumes
  build                build containers
  rebuild              rebuild containers
  up                   start containers
  restart              restart containers
  aml2                 login to amazon-linux-2 container
```
