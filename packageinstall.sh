CHAPTER="$1"
PACKAGE="$2"

cat packages.csv | grep -i "^$PACKAGE" | grep -iv "\.patch;" | while read line; do
    export VERSION="`echo $line | cut -d\; -f2`"
    URL="`echo $line | cut -d\; -f3 | sed "s/@/$VERSION/g"`"
    CACHEFILE="$(basename "$URL")"
    DIRNAME="$(echo "$CACHEFILE" | sed 's/\(.*\)\.tar\..*/\1/')"

    mkdir -pv "$DIRNAME"

    echo "Extracting $CACHEFILE"
    tar -xf "$CACHEFILE" -C "$DIRNAME"

    pushd "$DIRNAME"

        if [ "$(ls -1A | wc -l)" == "1" ]; then
            mv $(ls -1A)/* ./
        fi

        echo "Compiling $PACKAGE"
        sleep 5

        mkdir -pv "../log/ch$CHAPTER"
        if ! source "../ch$CHAPTER/$PACKAGE.sh" 2>&1 | tee "../log/ch$CHAPTER/$PACKAGE.log"; then
            echo "Error compiling $PACKAGE"
            popd
            exit 1
        fi

        echo "Done compiling $PACKAGE"

    popd

done