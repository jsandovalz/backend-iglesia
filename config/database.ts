import type { Core } from '@strapi/strapi';

const config = ({ env }: Core.Config.Shared.ConfigParams): Core.Config.Database => {
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

export default config;
