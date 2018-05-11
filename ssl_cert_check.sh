#!/bin/bash
#------------------------------------------------------------
# ssl_certs_check.sh
#
# Script checks for number of days until certificate expires or the issuing authority
# depending on switch passed on command line.
#
# Based on script from aperto.fr (http://aperto.fr/cms/en/blog/15-blog-en/15-ssl-certificate-expiration-monitoring-with-zabbix.html) with additions by racooper@tamu.edu
#------------------------------------------------------------

debug=0
if [ $debug -gt 0 ]
then
    exec 2>>/tmp/ssl_certs_check_debug.log
    set -x
fi

f=$1
host=$2
port=$3
sni=$4
proto=$5

if [ -z "$sni" ]
then
    servername=$host
else
    servername=$sni
fi

if [ -n "$proto" ]
then
    starttls="-starttls $proto"
fi

case $f in
-d)
end_date=`openssl s_client -servername $servername -connect $host:$port -showcerts $starttls </dev/null 2>/dev/null |
          sed -n '/BEGIN CERTIFICATE/,/END CERT/p' 2>/dev/null |
          openssl x509 -noout -enddate 2> /dev/null | cut -d= -f2 2>/dev/null`

if [ -n "$end_date" ]
then
    end_date_seconds=`date '+%s' --date "$end_date"`
    now_seconds=`date '+%s'`
    echo "($end_date_seconds-$now_seconds)/24/3600" | bc
fi
;;

-i)
issue_dn=`openssl s_client -servername $servername -connect $host:$port -showcerts $starttls </dev/null 2>/dev/null |
          sed -n '/BEGIN CERTIFICATE/,/END CERT/p' 2>/dev/null |
          openssl x509 -noout -issuer 2>/dev/null`

if [ -n "$issue_dn" ]
then
    issuer=`echo $issue_dn | sed -n 's/.*CN=*//p'`
    echo $issuer
fi
;;
*)
echo "Usage: $0 -i|-d hostname port sni"
echo "    -i - show issuer"
echo "    -d - show valid days remaining"
;;
esac

