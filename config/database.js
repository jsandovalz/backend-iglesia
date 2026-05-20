const { URL } = require('url');
module.exports = ({ env }) => {
const url = new URL(env('DATABASE_URL'));

  return {
    connection: {
      client: 'postgres',
      connection: {
        host: url.hostname,
        port: Number(url.port),
        database: url.pathname.replace('/', ''),
        user: url.username,
        password: url.password,
        ssl: false,
      },
      pool: {
        min: 2,
        max: 10,
      },
    },
  };
};