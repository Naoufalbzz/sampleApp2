#!/bin/bash
set -euo pipefail
directory='tempdirrrr'
mkdir $directory
mkdir $directory/templates
mkdir $directory/static

cp sample_app.py $directory/.
cp -r templates/* $directory/templates/.
cp -r static/* $directory/static/.

cat > $directory/Dockerfile << _EOF_
FROM python
RUN pip install flask
COPY  ./static /home/myapp/static/
COPY  ./templates /home/myapp/templates/
COPY  sample_app.py /home/myapp/
EXPOSE 5050
CMD python /home/myapp/sample_app.py
_EOF_

cd $directory || exit
docker build -t sampleapp .
docker run -t -d -p 5050:5050 --name samplerunning sampleapp
docker ps -a 
