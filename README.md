# amqp-logging-printer - A service that prints log messages sent via an ActiveMQ with amqp

This docker image can found on https://hub.docker.com/r/tirithen/amqp-logging-printer/.

Whenever writing a Node.js docker container service for an ActiveMQ system together with amqp-logging-printer, use this package https://www.npmjs.com/package/amqp-logging to send the logs to ActiveMQ that in turn will be picked up by this service.

## docker-compose.yml - And usage with docker

The docker-compose.yml file is an example of a docker container system setup with amqp-logging-printer (that prints logs sent by this package) and a ActiveMQ instance that handles all the amqp messages.

To try this out run docker-compose.yml with:

    $ docker-compose up
