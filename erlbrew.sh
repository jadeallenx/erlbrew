set -e
set -u 
set -x

CMD=$1
RELEASE=$2
WORK="$HOME/erlang"
BUILD="$WORK/.build"
INSTALL="$WORK/$RELEASE"
DOWNLOAD_FILE="otp_src_$RELEASE.tar.gz"
DOWNLOAD_URL="http://www.erlang.org/download/$DOWNLOAD_FILE"
# http://www.erlang.org/download/otp_src_R14B04.tar.gz
DOWNLOAD_TOOL="curl -o"
DOWNLOAD_CMD="$DOWNLOAD_TOOL $BUILD/$DOWNLOAD_FILE $DOWNLOAD_URL"
UNTAR_CMD="tar -zxvf"

download() {
  mkdir -p $BUILD
  $DOWNLOAD_CMD
}

build() {
  cd $BUILD
  $UNTAR_CMD $DOWNLOAD_FILE
  cd "otp_src_$RELEASE"
  ./configure --prefix="$INSTALL" --enable-darwin-64bit --without-javac
  make
}

install() {
  mkdir -p $INSTALL
  make install
}



