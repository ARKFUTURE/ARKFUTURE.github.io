function FindProxyForURL(url, host) {

    if (shExpMatch(host, "*.com") || shExpMatch(host, "*.org") || shExpMatch(host, "*.net")) {
        return "DIRECT; SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555;";
    }

    else if (dnsDomainIs(host, ".github.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else if (dnsDomainIs(host, ".pornhub.com") || dnsDomainIs(host, ".xvideos.com") || dnsDomainIs(host, ".xnxx.com") || dnsDomainIs(host, ".xhamster.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else if (shExpMatch(host, "*.cn") || shExpMatch(host, "*.gov.cn") || shExpMatch(host, "*.org.cn") || shExpMatch(host, "*.edu.cn") ) {
        return "DIRECT";
    }

    else {
        return "DIRECT";
    }
}


