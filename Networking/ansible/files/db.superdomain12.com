$TTL 86400
@   IN  SOA superdomain12.com. root.superdomain12.com. (
        2025091401 ; Serial (YYYYMMDDXX)
        3600       ; Refresh
        1800       ; Retry
        604800     ; Expire
        86400 )    ; Minimum TTL

    IN  NS  ns1.superdomain12.com.
    IN  A   192.168.10.1     
ns1 IN  A   192.168.10.1
www IN  A   192.168.10.100

