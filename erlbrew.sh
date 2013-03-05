set -e
set -u 
set -x

CMD=$1
RELEASE=$2
WORK="$HOME/erlang"
BUILD="$WORK/.build"
INSTALL="$WORK/$RELEASE"
FILENAME="otp_src_$RELEASE"
DOWNLOAD_FILE="$FILENAME.tar.gz"
TARBALL_PATH="$BUILD/tarballs"
TMP_PATH="$BUILD/work.$$"
DOWNLOAD_PATH="$BUILD/tarballs/$DOWNLOAD_FILE"
DOWNLOAD_URL="http://www.erlang.org/download/$DOWNLOAD_FILE"
DOWNLOAD_TOOL=$(which curl)
DOWNLOAD_TOOL_FLAGS="--fail --progress-bar --show-error"
DOWNLOAD_CMD="$DOWNLOAD_TOOL $DOWNLOAD_TOOL_FLAGS --output $DOWNLOAD_PATH $DOWNLOAD_URL"
UNTAR_CMD=$(which tar)
UNTAR_FLAGS="-zxvf"

download() {
  if [ ! -d "$TARBALL_PATH" ]; then
    mkdir -p "$TARBALL_PATH"
  fi

  if [ ! -e "$DOWNLOAD_PATH" ]; then
    $DOWNLOAD_CMD
  else
    echo "You appear to have Erlang $RELEASE downloaded."
  fi
}

build() {
  mkdir -p "$TMP_PATH"
  cp -a "$DOWNLOAD_PATH" "$TMP_PATH"
  cd "$TMP_PATH"
  $UNTAR_CMD $UNTAR_FLAGS $DOWNLOAD_FILE
  cd "$FILENAME"
  ./configure --prefix="$INSTALL" --enable-darwin-64bit --without-javac
  make
}

install() {
  if [ ! -d "$INSTALL" ]; then
    mkdir -p $INSTALL
  fi

  make install
}

case "$CMD" in
    download)
        download
        ;;
    build)
        download
        build
        ;;
    install)
        download
        build
        install
        ;;
    use)
        echo "Not implemented yet"
        exit 1
        ;;
    *)
        echo "Usage: $0 {download|build|install|use} {release-spec}"
        exit 1

esac


