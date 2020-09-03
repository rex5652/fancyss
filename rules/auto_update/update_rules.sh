#!/bin/bash

./fwlist.py gfwlist_download.conf

grep -Ev "([0-9]{1,3}[\.]){3}[0-9]{1,3}" gfwlist_download.conf >gfwlist_download_tmp.conf
if [ -f "gfwlist_download.conf" ]; then
	cat gfwlist_download_tmp.conf gfwlist_koolshare.conf | grep -Ev "([0-9]{1,3}[\.]){3}[0-9]{1,3}" | sed "s/^/server=&\/./g" | sed "s/$/\/127.0.0.1#7913/g" >gfwlist_merge.conf
	cat gfwlist_download_tmp.conf gfwlist_koolshare.conf | sed "s/^/ipset=&\/./g" | sed "s/$/\/gfwlist/g" >>gfwlist_merge.conf
fi
sort -k 2 -t. -u gfwlist_merge.conf >gfwlist.conf
rm gfwlist_merge.conf

# delete site below
sed -i '/m-team/d' "gfwlist.conf"
sed -i '/windowsupdate/d' "gfwlist.conf"
sed -i '/v2ex/d' "gfwlist.conf"
rm gfwlist_download.conf gfwlist_download_tmp.conf
echo "copy gfwlist.conf to /jffs/.koolshare/ss/rules/gfwlist.conf"