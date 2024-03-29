// ARKFUTURE
function FindProxyForURL(url, host) {

    var proxyServer1 = "DIRECT; SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555";
    var proxyServer2 = "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT; ";

    if (shExpMatch(host, "*.*")) {
        return proxyServer1;
    }

    else if (dnsDomainIs(host, ".pornhub.com") || dnsDomainIs(host, ".xvideos.com") || dnsDomainIs(host, ".xnxx.com") || dnsDomainIs(host, ".xhamster.com") || dnsDomainIs(host, ".twitter.com") || dnsDomainIs(host, ".instagram.com") || dnsDomainIs(host, ".facebook.com") || dnsDomainIs(host, ".discord.com") || dnsDomainIs(host, ".telegram.org")) {
        return proxyServer2;
    }

    else {
        return "DIRECT";
    }
}
