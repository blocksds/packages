#!/bin/bash

directory=$1
has_parent=$2

cd $directory

files=`ls -1`

cat << EOF > index.html
<!DOCTYPE html>
<html>
  <head>
    <title>$directory</title>
  </head>
  <body>
EOF

if [ "$has_parent" == "true" ]; then
    echo "    <a href=\"..\">..</a><br>" >> index.html
fi

for file in $files; do
    echo "    <a href=\"$file\">$file</a><br>" >> index.html
done

cat << EOF >> index.html
  </body>
</html>
EOF
