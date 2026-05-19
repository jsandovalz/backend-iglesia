/**
 * contacto controller
 */

import { factories } from '@strapi/strapi';

//export default factories.createCoreController('api::contacto.contacto');
export default factories.createCoreController('api::contacto.contacto', ({ strapi }) => ({
  async send(ctx) {
    const { nombre, email, consulta } = ctx.request.body;

    await strapi.plugins['email'].services.email.send({
      to: 'jsandovalz@gmail.com',
      subject: 'Nueva consulta desde la web',
      text: `Nombre: ${nombre}\nEmail: ${email}\nConsulta: ${consulta}`,
    });

    ctx.send({ ok: true });
  },
}));
