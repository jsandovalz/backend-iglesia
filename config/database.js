const { URL } = require('url');

module.exports = ({ env }) => {
  const dbUrl = env('DATABASE_URL');
  const url = new URL(dbUrl);

  return {
    connection: {
      client: 'postgres',
      connection: {
        host: url.hostname,
        port: Number(url.port),
        database: url.pathname.replace('/', ''),
        user: url.username,
        password: url.password,
        ssl: {
          rejectUnauthorized: false,
        },
      },
      pool: {
        min: 2,
        max: 10,
      },
    },
  };
};