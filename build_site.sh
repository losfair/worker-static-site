#!/bin/sh

SCRIPT="`dirname $0`/dist/main.js"

if [ -z "$SCRIPT" ]; then
    echo "[-] Script not built"
    exit 1
fi

SOURCE="$1"

if [ -z "$SOURCE" ]; then
    echo "[-] Missing source directory"
    exit 1
fi

TMP="/tmp/worker-static-site-build-`uuidgen || exit 1`"
mkdir "$TMP" || exit 1

cleanup()
{
    echo "Cleaning up temporary directory $TMP"
    rm -r "$TMP"
}

trap cleanup EXIT

cp "$SCRIPT" "$TMP/index.js" || exit 1
mkdir "$TMP/res" || exit 1
cp -r "$SOURCE/"* "$TMP/res/" || exit 1
CURDIR="`pwd`"
cd "$TMP" || exit 1
tar c . > "$CURDIR/wss-build.tar" || exit 1
cd "$CURDIR" || exit 1

echo "[+] Built wss-build.tar"
