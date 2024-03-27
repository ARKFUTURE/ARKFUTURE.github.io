// ARKFUTURE
function FindProxyForURL(url, host) {

    var proxyServer = "DIRECT; SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555";

    if (shExpMatch(host, "*.com") || shExpMatch(host, "*.org") || shExpMatch(host, "*.net")) {
        return proxyServer;
    }

    else if (dnsDomainIs(host, ".pornhub.com") || dnsDomainIs(host, ".xvideos.com") || dnsDomainIs(host, ".xnxx.com") || dnsDomainIs(host, ".xhamster.com")) {
        return proxyServer;
    }

    else {
        return "DIRECT";
    }
}
