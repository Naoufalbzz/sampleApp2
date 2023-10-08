#!/bin/bash
set -euo pipefail

mkdir tempdirrrr
mkdir tempdirrrr/templates
mkdir tempdirrrr/static

cp sample_app.py tempdirrrr/.
cp -r templates/* tempdirrrr/templates/.
cp -r static/* tempdirrrr/static/.

cat > tempdirrrr/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd tempdirrrr || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
