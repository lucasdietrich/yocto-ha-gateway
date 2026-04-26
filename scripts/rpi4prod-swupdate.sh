
#!/bin/bash

machine="rpi4ha"
config="rpi4ha-prod"
image=ha-image
swu_path="build/tmp-${config}/deploy/images/${machine}/${image}-${machine}.rootfs.swu"

ip="192.168.10.49"
port="8087"

curl -F "file=@${swu_path}" http://${ip}:${port}/upload