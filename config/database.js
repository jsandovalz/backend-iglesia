module.exports = ({ env }) => {
  const client = env('DATABASE_CLIENT', 'sqlite');

  if (client === 'sqlite') {
    return {
      connection: {
        client: 'sqlite',
        connection: { filename: '.tmp/build.db' },
        useNullAsDefault: true,
      },
    };
  }

  return {
    connection: {
      client: 'postgres',
      connection: env('DATABASE_URL', ''),
      ssl: { rejectUnauthorized: false },
      pool: { min: 2, max: 10 },
    },
  };
};