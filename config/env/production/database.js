module.exports = ({ env }) => {
  const dbUrl = env('DATABASE_URL', '');

  if (!dbUrl) {
    return {
      connection: {
        client: 'sqlite',
        connection: { filename: '.tmp/build.db' },
        useNullAsDefault: true,
      },
    };
  }

  const { URL } = require('url');
  const url = new URL(dbUrl);

  return {
    connection: {
      client: 'postgres',
      connection: {
        host: url.hostname,
        port: Number(url.port),
        database: url.pathname.slice(1),
        user: url.username,
        password: url.password,
        ssl: { rejectUnauthorized: false },
      },
      pool: { min: 2, max: 10 },
    },
  };
};