# git-server
Provides a simple git server, using git-daemon, in a Docker image.

See [kineticfire/git-server at Docker Hub](https://hub.docker.com/r/kineticfire/git-server) for the git-server Docker image and additional documentation.


# Table of Contents
1. [Key Capabilities](#key-capabilities)
2. [License](#license)


# Key Capabilities
Key capabilities of git-server include:
1. Daily automated backup script
2. Does NOT run as root, and configurable UID/GID process owner
3. Host-mounted repositories

Note that a container run from this image does NOT support authentication or encrypted connections, and it is assumed that the container is run on a system that provides those mechanisms such as via ssh.


# License
- This image is released under [Apache License 2.0](https://www.apache.org/licenses/LICENSE-2.0)
- git is released under [GNU General Public License version 2](https://opensource.org/licenses/GPL-2.0)
