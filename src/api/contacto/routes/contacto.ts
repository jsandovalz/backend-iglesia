/**
 * contacto router
 */

import { factories } from '@strapi/strapi';

// export default factories.createCoreRouter('api::contacto.contacto');
export default {
  routes: [
    {
      method: 'POST',
      path: '/contacto/send',
      handler: 'contacto.send',
      config: {
        policies: [],
        auth: false, // o true si quieres protegerlo
      },
    },
  ],
};
