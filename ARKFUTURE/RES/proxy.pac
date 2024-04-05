// ARKFUTURE
function FindProxyForURL(url, host) {

    if (shExpMatch(host, "*.*.*")) {
        return "DIRECT; SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555";
    }

    else if (dnsDomainIs(host, ".pornhub.com") || dnsDomainIs(host, ".xvideos.com") || dnsDomainIs(host, ".xnxx.com") || dnsDomainIs(host, ".xhamster.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else {
        return "DIRECT";
    }
}
