function FindProxyForURL(url, host) {

    if (dnsDomainIs(host, ".twitter.com") && dnsDomainIs(host, ".youtube.com") && dnsDomainIs(host, ".telegram.org") && dnsDomainIs(host, ".instagram.com") && dnsDomainIs(host, ".tiktok.com") && dnsDomainIs(host, ".facebook.com") && dnsDomainIs(host, ".discord.com") && dnsDomainIs(host, ".github.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else if (dnsDomainIs(host, ".duckduckgo.com") && dnsDomainIs(host, ".google.com") && dnsDomainIs(host, ".yandex.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else if (dnsDomainIs(host, ".pornhub.com") && dnsDomainIs(host, ".xvideos.com") && dnsDomainIs(host, ".xnxx.com") && dnsDomainIs(host, ".xhamster.com")) {
        return "SOCKS5 192.168.0.2:5554; PROXY 192.168.0.2:5555; DIRECT";
    }

    else {
        return "DIRECT";
    }
}


