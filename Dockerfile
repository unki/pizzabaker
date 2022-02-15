#
# build
#
FROM python:3.9-alpine AS build

RUN pip3 --no-cache-dir install virtualenv
RUN python3 -m venv /app/venv && \
    chown -R nobody /app

USER nobody
WORKDIR /app

COPY * ./
RUN /app/venv/bin/pip3 --no-cache-dir install -r requirements.txt

#
# final
#
FROM python:3.9-alpine

EXPOSE 5000
ENV FLASK_APP=app
ENV FLASK_RUN_HOST=0.0.0.0
ENV PORT=5000

WORKDIR /app
CMD venv/bin/flask run --port=$PORT

COPY --from=build /app/ .
