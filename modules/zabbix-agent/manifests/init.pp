class zabbix-agent (
    $zabbix_server_ip="10.255.0.11"
) {
    package { "zabbix-agent":
        ensure  => present,
        require => Yumrepo["epel"],
    }
    file { "/etc/zabbix/zabbix_agent.conf":
        ensure  => present,
        content => template('zabbix-agent/zabbix_agent.conf.erb'),
        mode => 644,
        group => "root",
        owner => "root",
        require => Package["zabbix-agent"]
    }
    file { "/etc/zabbix/zabbix_agentd.conf":
        ensure  => present,
        content => template('zabbix-agent/zabbix_agentd.conf.erb'),
        mode => 644,
        group => "root",
        owner => "root",
        require => Package["zabbix-agent"]
    }
    service { "zabbix-agent":
        ensure  => running,
        require => [Package["zabbix-agent"], File["/etc/zabbix/zabbix_agent.conf"], File["/etc/zabbix/zabbix_agentd.conf"]],
    }
}
