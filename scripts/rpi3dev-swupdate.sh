
#!/bin/bash

machine="rpi3ha"
image=ha-image
swu_path="build/tmp-${machine}/deploy/images/${machine}/${image}-${machine}.rootfs.swu"

ip="192.168.10.244"
port="8087"

curl -F "file=@${swu_path}" http://${ip}:${port}/upload