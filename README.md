# EC2-local
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
```
