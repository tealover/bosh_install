#!/bin/sh
echo "所需要的gem包如下所示:" > ./gems.info
for gem in `ls ./`; do
  echo $gem >> ./gems.info
done
