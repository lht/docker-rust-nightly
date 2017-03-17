
SITE="https://static.rust-lang.org/dist"

if [ -z "$DATE" ]; then
  DATE=`date +%Y-%m-%d`
fi

TAG="nightly-${DATE}"

LINK="${SITE}/${DATE}/index.html"
echo $LINK

# test if there is a nightly build
if `curl --fail -I ${LINK} >/dev/null 2>&1`; then
    docker build --build-arg BUILD_DATE=${DATE} -t rust:${TAG} .
else
    echo "No nightly build on ${DATE}"
fi
