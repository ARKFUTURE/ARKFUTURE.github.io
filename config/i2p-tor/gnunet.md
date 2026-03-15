## Openwrt 中的 GnuNet
> https://www.gnunet.org/en/install-on-openwrt.html#:~:text=Running%20on%20OpenWrt%20allows%20having%20a%20GNUnet%20node,you%20how%20to%20install%2C%20run%2C%20and%20operate%20it.
* 
``` bash
opkg install gnunet gnunet-vpn gnunet-gns gnunet-fs gnunet-datastore gnunet-dht-cli gnunet-hostlist gnunet-communicator-tcp gnunet-communicator-udp gnunet-dhtcache-sqlite gnunet-fs-sqlite gnunet-gns-sqlite gnunet-peerstore-sqlite gnunet-sqlite gnunet-hostlist gnunet-messenger gnunet-abd gnunet-auction gnunet-conversation gnunet-conversation gnunet-fuse gnunet-rest gnunet-rps gnunet-utils
``` 
* 查看相关配置 `uci show gnunet`