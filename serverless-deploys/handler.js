const { generate } = require('unique-names-generator');

exports.handler = (event, context, callback) => {
  const response = {
    statusCode: 200,
    body: JSON.stringify({
      name: generate(),
    }),
  };
  callback(null, response);
};

