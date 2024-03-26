function FindProxyForURL(url, host) {
    if (dnsDomainIs(host, ".google.com")) {
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554";
    } 
    else if (dnsDomainIs(host, ".twitter.com")) {
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554";
    } 
    else {
        return "DIRECT";
    }
  }
  
