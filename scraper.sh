#!/bin/bash

#This script runs who.is against every domain in domain.txt
#
#Some pre-processing 
#
#Stripping out sub-domains
#Removing duplicates
#

cat domains.txt | awk '{n = split($0,a,"."); print a[n-1] "." a[n]}'| sort -u >> newDomains.txt

while read DOMAIN; 
do     
google-chrome --headless --disable-gpu --dump-dom http://www.whoishostingthis.com/?q="$DOMAIN" | xmllint --noout CreDefault.XML 2>/dev/null --html --xpath '//h2[@class="pure-u-1"]//text()' - 
echo -e
done < newDomains.txt