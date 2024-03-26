function FindProxyForURL(url, host) {
    const basic = [".twitter.com", ".youtube.com", ".telegram.org", ".instagram.com", ".tiktok.com", ".facebook.com", ".discord.com" ,".github.com"];
    const search = [".duckduckgo.com", ".google.com", ".yandex.com"]
    const other = [".pornhub.com", ".xvideos.com", ".xnxx.com", ".xhamster.com"];

    if (basic.some(domain => dnsDomainIs(host, domain))) {
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554; DIRECT";
    } 
    else if (search.some(domain => dnsDomainIs(host, domain))){
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554; DIRECT";
    }
    else if (other.some(domain => dnsDomainIs(host, domain))){
        return "PROXY 192.168.0.2:5555; SOCKS5 192.168.0.2:5554; DIRECT";
    }
    else {
        return "DIRECT";
    }
}

  
