module.exports = ({ env }) => {
  const { URL } = require('url');
  const dbUrl = env('DATABASE_URL', '');
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