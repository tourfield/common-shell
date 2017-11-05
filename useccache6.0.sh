#/bin/bash
###################################################################
#
#
#
#
###################################################################
#export USE_CCACHE=1
#export CCACHE_DIR=./.ccache
#echo insert | sudo -S prebuilts/misc/linux-x86/ccache/ccache  -M 50G 

echo `sudo update-alternatives --config java << EOF
1
EOF` >> /dev/null

echo `sudo update-alternatives --config javac <<EOF
1
EOF` >> /dev/null

export JACK_SERVER_VM_ARGUMENTS="-Dfile.encoding=UTF-8 -XX:+TieredCompilation -Xmx4g"
./prebuilts/sdk/tools/jack-admin kill-server
./prebuilts/sdk/tools/jack-admin start-server
