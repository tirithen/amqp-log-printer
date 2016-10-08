const AMQP = require('amqp10');

const AMQP_URL = process.env.AMQP_URL || 'amqp://localhost';

this.client = new AMQP.Client(AMQP.Policy.ActiveMQ);
this.client.connect(AMQP_URL).then(() => {
  this.client.createReceiver('topic://logs').then((receiver) => {
    console.info('Listening on the logs queue');
    receiver.on('message', (message) => {
      const level = message.body.level === 'warning' ? 'warn' : message.body.level;

      if (console[level] instanceof Function) {
        if (message.body.package) {
          console[level](
            (new Date(message.body.date).toISOString()),
            message.body.package.name,
            message.body.package.version,
            message.body.level,
            message.body.data
          );
        } else {
          console[level](
            (new Date(message.body.date).toISOString()),
            message.body.level,
            message.body.data
          );
        }
      }

      receiver.release(message);
    });
  });
});

this.client.on(AMQP.Client.ErrorReceived, error => console.error(error));
