BASE="$(dirname $0)"
mkdir -p $BASE/repos
docker run -p 8080:80 -v $PWD/$BASE/repos:/var/lib/git cirocosta/gitserver-http:formatting
