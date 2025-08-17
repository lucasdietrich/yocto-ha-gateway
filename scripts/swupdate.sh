
#!/bin/bash

machine="rpi3ha"
image=ha-image
swu_path="build/tmp-rpi3ha/deploy/images/${machine}/${image}-${machine}.rootfs.swu"

ip="192.168.10.70"
port="8080"

curl -F "file=@${swu_path}" http://${ip}:${port}/upload