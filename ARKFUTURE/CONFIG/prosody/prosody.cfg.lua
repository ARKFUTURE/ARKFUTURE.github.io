-- 这是prosody的全局配置文件,由 ARKFUTURE 修改,编码为UTF-8 ,主要为配置文件解释翻译成中文
-- 不同的大范围规定空两行, 相同范围规定空一行
-- 有关配置prosody的更多信息,请访问我们的网站：https://prosody.im/doc/configure
-- 提示：完成配置后,您可以运行以下命令检查此文件的语法是否正确：
--     prosodyctl check config
-- 如果有任何错误,它会告诉您错误的位置和内容,否则它将保持沉默



---------- 服务器范围设置 ----------
-- 管理员设置
-- 详细请参考 https://prosody.im/doc/creating_accounts

admins = { }

-- 插件储存路径 
-- 详细请参考 https://modules.prosody.im/
plugin_paths = { "/usr/local/lib/prosody/modules" }

-- 启动服务器时将使用的插件(模块)
modules_enabled = {

	-- Generally required
		"disco"; -- Service discovery
		"roster"; -- Allow users to have a roster. Recommended ;)
		"saslauth"; -- Authentication for clients and servers. Recommended if you want to log in.
		"tls"; -- Add support for secure TLS on c2s/s2s connections

	-- Not essential, but recommended
		"blocklist"; -- Allow users to block communications with other users
		"bookmarks"; -- Synchronise the list of open rooms between clients
		"carbons"; -- Keep multiple online clients in sync
		"dialback"; -- Support for verifying remote servers using DNS
		"limits"; -- Enable bandwidth limiting for XMPP connections
		"pep"; -- Allow users to store public and private data in their account
		"private"; -- Legacy account storage mechanism (XEP-0049)
		"smacks"; -- Stream management and resumption (XEP-0198)
		"vcard4"; -- User profiles (stored in PEP)
		"vcard_legacy"; -- Conversion between legacy vCard and PEP Avatar, vcard

	-- Nice to have
		"csi_simple"; -- Simple but effective traffic optimizations for mobile devices
		"invites"; -- Create and manage invites
		"invites_adhoc"; -- Allow admins/users to create invitations via their client
		"invites_register"; -- Allows invited users to create accounts
		"ping"; -- Replies to XMPP pings with pongs
		"register"; -- Allow users to register on this server using a client and change passwords
		"time"; -- Let others know the time here on this server
		"uptime"; -- Report how long server has been running
		"version"; -- Replies to server version requests
		--"mam"; -- Store recent messages to allow multi-device synchronization
		--"turn_external"; -- Provide external STUN/TURN service for e.g. audio/video calls

	-- Admin interfaces
		"admin_adhoc"; -- Allows administration via an XMPP client that supports ad-hoc commands
		"admin_shell"; -- Allow secure administration via 'prosodyctl shell'

	-- HTTP modules
		--"bosh"; -- Enable BOSH clients, aka "Jabber over HTTP"
		--"http_openmetrics"; -- for exposing metrics to stats collectors
		--"websocket"; -- XMPP over WebSockets

	-- Other specific functionality
		"posix"; -- POSIX functionality, sends server to background, enables syslog, etc.
		--"announce"; -- Send announcement to all online users
		--"groups"; -- Shared roster support
		--"legacyauth"; -- Legacy authentication. Only used by some old clients and bots.
		--"mimicking"; -- Prevent address spoofing
		--"motd"; -- Send a message to users when they log in
		--"proxy65"; -- Enables a file transfer proxy service which clients behind NAT can use
		--"s2s_bidi"; -- Bi-directional server-to-server (XEP-0288)
		--"server_contact_info"; -- Publish contact information for this service
		--"tombstones"; -- Prevent registration of deleted accounts
		--"watchregistrations"; -- Alert admins of registrations
		--"welcome"; -- Welcome users who register accounts
}

-- 自动加载的插件(模块)禁用,下面插件是自动加载的, 在此处去掉注释代表禁用以下插件
modules_disabled = {
	-- "offline"; -- Store offline messages
	-- "c2s"; -- Handle client connections
	-- "s2s"; -- Handle server-to-server connections
}

-- pid文件即路径 (默认即可)
pidfile = "/run/prosody/prosody.pid";

-- 服务器到服务器身份验证
-- 如果您希望服务器之间相互通信,则必须启用此功能
s2s_secure_auth = true
--s2s_insecure_domains = { "insecure.example" }
--s2s_secure_domains = { "jabber.org" }

-- 传输限制
limits = {
	c2s = {
		rate = "10kb/s";
	};
	s2sin = {
		rate = "30kb/s";
	};
}

-- 身份验证 
-- 有关更多信息,请参考https://prosody.im/doc/authentication 和 https://prosody.im/doc/creating_accounts
authentication = "internal_hashed"

-- 储存
-- 有关更多信息,请参考https://prosody.im/doc/storage (其他的不翻译了)
--storage = "sql"
--sql = { driver = "SQLite3", database = "prosody.sqlite" } -- Default. 'database' is the filename.
--sql = { driver = "MySQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }
--sql = { driver = "PostgreSQL", database = "prosody", username = "prosody", password = "secret", host = "localhost" }

-- 归档
-- 请参考配置文件 https://prosody.im/doc/modules/mod_mam
archive_expires_after = "1w" -- 1 周后删除已归档的消息

-- 音频/视频呼叫中继 (STUN/TURN)
-- 请参考配置 https://prosody.im/doc/turn
--turn_external_host = "turn.example.com"
--turn_external_secret = "your-secret-turn-access-token"


-- 日志
-- 请参考 https://prosody.im/doc/logging
log = {
	-- Log files (change 'info' to 'debug' for debug logs):
	info = "/var/log/prosody/prosody.log";
	error = "/var/log/prosody/prosody.err";
	-- Syslog:
	{ levels = { "error" }; to = "syslog";  };
}

-- 统计信息
-- 请参考 https://prosody.im/doc/statistics
-- statistics = "internal"

-- 证书
-- 请参考 https://prosody.im/doc/certificates
certificates = "certs"


------ 额外的配置文件 ------
-- 出于组织目的,您可能更喜欢在自己的配置文件中添加VirtualHost和组件定义
-- 所有的配置文件在 /etc/prosody/conf.d/
-- Prosody需要至少一个启用的VirtualHost才能运行
-- 一旦添加了另一个 localhost ,您就可以安全地删除或禁用它
VirtualHost "localhost"
VirtualHost "example.com"
ssl = {
	key = "/etc/prosody/certs/example.com.key";
	certificate = "/etc/prosody/certs/example.com.crt";
	}


------ 组件 ------
-- 您可以指定组件以添加提供特殊服务(如多用户会议和传输)的主机
-- 请参考 https://prosody.im/doc/components 以下配置不翻译
--Include "conf.d/*.cfg.lua"

Component "conference.example.com" "muc"

---------- End of the Prosody Configuration file ----------
-- 请参阅https://prosody.im/doc/configure 更多信息
