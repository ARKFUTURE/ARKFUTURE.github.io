function FindProxyForURL(url, host) {
    const targetDomains = [".google.com", ".twitter.com", ".youtube.com", ".telegram.org", ".instagram.com", ".tiktok.com", ".facebook.com", ".discord.com"];

    if (targetDomains.some(domain => dnsDomainIs(host, domain))) {
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554";
    } 
    else if (dnsDomainIs(host, ".github.com")){
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554; DIRECT";
    }
    else {
        return "DIRECT";
    }
}

  
