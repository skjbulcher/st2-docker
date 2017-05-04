#!/bin/bash

# Create env files in the specified directory

CONF_DIR=${1:-conf}

function randpwd()
{
  echo $(openssl rand -base64 $1 | tr '/' 'A')
}

mkdir -p ${CONF_DIR}

if [ ! -f ${CONF_DIR}/mongo.env ]; then
  touch ${CONF_DIR}/mongo.env
fi
if [ ! -f ${CONF_DIR}/postgres.env ]; then
  echo "POSTGRES_USER=${POSTGRES_USER:-mistral-user}" > ${CONF_DIR}/postgres.env
  echo "POSTGRES_PASSWORD=${POSTGRES_PASS:-$(randpwd 18)}" >> ${CONF_DIR}/postgres.env
  echo "POSTGRES_HOST=${POSTGRES_HOST:-postgres}" >> ${CONF_DIR}/postgres.env
  echo "POSTGRES_DB=${POSTGRES_DB:-mistral}" >> ${CONF_DIR}/postgres.env
fi
if [ ! -f ${CONF_DIR}/rabbitmq.env ]; then
  echo "RABBITMQ_DEFAULT_USER=${RABBITMQ_DEFAULT_USER:-admin}" > ${CONF_DIR}/rabbitmq.env
  echo "RABBITMQ_DEFAULT_PASS=${RABBITMQ_DEFAULT_PASS:-$(randpwd 18)}" >> ${CONF_DIR}/rabbitmq.env
  echo "RABBITMQ_HOST=${RABBITMQ_HOST:-rabbitmq}" >> ${CONF_DIR}/rabbitmq.env
fi
if [ ! -f ${CONF_DIR}/redis.env ]; then
  echo "REDIS_PASSWORD=${REDIS_PASSWORD:-$(randpwd 18)}" > ${CONF_DIR}/redis.env
  echo "REDIS_HOST=${REDIS_HOST:-redis}" >> ${CONF_DIR}/redis.env
fi
if [ ! -f ${CONF_DIR}/stackstorm.env ]; then
  echo "ST2_USER=${ST2_USER:-st2admin}" > ${CONF_DIR}/stackstorm.env
  echo "ST2_PASSWORD=${ST2_PASSWORD:-$(randpwd 6)}" >> ${CONF_DIR}/stackstorm.env
fi
