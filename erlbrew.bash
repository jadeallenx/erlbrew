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
CHECKSUM_PATH="$BUILD/MD5"
TMP_PATH="$BUILD/work.$$"
DOWNLOAD_PATH="$BUILD/tarballs/$DOWNLOAD_FILE"
DOWNLOAD_URL="http://www.erlang.org/download/$DOWNLOAD_FILE"
DOWNLOAD_TOOL=$(which curl)
DOWNLOAD_TOOL_FLAGS="--fail --progress-bar --show-error"
DOWNLOAD_OTP_CMD="$DOWNLOAD_TOOL $DOWNLOAD_TOOL_FLAGS --output $DOWNLOAD_PATH $DOWNLOAD_URL"
DOWNLOAD_CHECKSUM_CMD="$DOWNLOAD_TOOL --insecure $DOWNLOAD_TOOL_FLAGS --output $CHECKSUM_PATH https://www.erlang.org/download/MD5"
UNTAR_CMD=$(which tar)
UNTAR_FLAGS="-zxvf"

download() {
  if [ ! -d "$TARBALL_PATH" ]; then
    mkdir -p "$TARBALL_PATH"
  fi

  if [ ! -e "$DOWNLOAD_PATH" ]; then
    $DOWNLOAD_OTP_CMD
  else
    echo "You appear to have Erlang $RELEASE downloaded."
  fi

  if [ ! -e "$CHECKSUM_PATH" ]; then
      $DOWNLOAD_CHECKSUM_CMD
  fi

  CHECKSUM_FILE_VALUE=$(grep $DOWNLOAD_FILE $CHECKSUM_PATH | cut -d" " -f2)
  COMPUTED_CHECKSUM=$(md5 -q $DOWNLOAD_PATH)
  if [ "$CHECKSUM_FILE_VALUE" != "$COMPUTED_CHECKSUM" ]; then
    echo "The file $DOWNLOAD_PATH has MD5"
    echo "$COMPUTED_CHECKSUM and it should have"
    echo "$CHECKSUM_FILE_VALUE"
    exit 1
  fi

  echo "Tarball has correct MD5 checksum"
    
}

build() {
  mkdir -p "$TMP_PATH"
  cp -a "$DOWNLOAD_PATH" "$TMP_PATH"
  cd "$TMP_PATH"
  $UNTAR_CMD $UNTAR_FLAGS $DOWNLOAD_FILE
  cd "$FILENAME"
  ./configure --prefix="$INSTALL" --enable-darwin-64bit --without-javac --disable-hipe
  touch lib/wx/SKIP
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


