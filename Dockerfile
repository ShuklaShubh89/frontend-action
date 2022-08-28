FROM python:3.8-alpine

LABEL "com.github.actions.name"="Frontend Github Actions"
LABEL "com.github.actions.description"="Sync directory to an AWS S3 repository and invalidate cloudfront cache"
LABEL "com.github.actions.icon"="refresh-cw"
LABEL "com.github.actions.color"="green"

LABEL version="0.1.0"
LABEL repository="https://github.com/ShuklaShubh89/frontendaction"
LABEL homepage="https://info.shubhamshukla-resume.com/"
LABEL maintainer="Shubham Shukla <shubham.cored@gmail.com>"

# https://github.com/aws/aws-cli/blob/master/CHANGELOG.rst
ENV AWSCLI_VERSION='1.18.14'

RUN pip install --quiet --no-cache-dir awscli==${AWSCLI_VERSION}

ADD entrypoint.sh /entrypoint.sh
ENTRYPOINT ["/entrypoint.sh"]