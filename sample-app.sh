#!/bin/bash
set -euo pipefail

mkdir tempdirrr
mkdir tempdirrr/templates
mkdir tempdirrr/static

cp sample_app.py tempdirrr/.
cp -r templates/* tempdirrr/templates/.
cp -r static/* tempdirrr/static/.

cat > tempdirrr/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirrr || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
