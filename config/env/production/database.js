module.exports = ({ env }) => ({
  connection: {
    client: 'postgres',
    connection: env('DATABASE_URL', ''),
    ssl: { rejectUnauthorized: false },
    pool: { min: 2, max: 10 },
  },
});