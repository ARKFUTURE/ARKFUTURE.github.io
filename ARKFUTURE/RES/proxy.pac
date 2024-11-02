// ARKFUTURE
function FindProxyForURL(url, host) {  
    if (dnsDomainIs(host, "*.pornhub.com") ||  
        dnsDomainIs(host, "*.xvideos.com") ||  
        dnsDomainIs(host, "*.xnxx.com") || 
        dnsDomainIs(host, "*.*.youtube.com") ||  
        dnsDomainIs(host, "*.xhamster.com")) {  
        return "SOCKS5 127.0.0.1:5554";  
    }  
    else if (shExpMatch(host, "*.onion")) {  
        return "SOCKS5 127.0.0.1:9050";
    }  
    else if (shExpMatch(host, "*.i2p")) {  
        return " SOCKS5 127.0.0.1:4447; PROXY 127.0.0.1:4444";
    }
    else {    
        return "DIRECT; SOCKS5 127.0.0.1:5554";  
    }  
}