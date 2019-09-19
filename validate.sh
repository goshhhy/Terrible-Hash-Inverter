#!/bin/bash

out=$(./gen 0)

data="$(echo $out | awk '{print $1}')"
genhash="$(echo $out | awk '{print $2}')"
sslhash=$(echo -en $data | openssl dgst -sha256 -binary | openssl dgst -sha256 | awk '{print $2}')

echo gen: $genhash
echo ssl: $sslhash

if [ "$genhash" == "$sslhash" ]; then
    echo "ok!"
else
    echo "failed!"
fi