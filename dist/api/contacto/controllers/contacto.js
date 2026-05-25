"use strict";
/**
 * contacto controller
 */
Object.defineProperty(exports, "__esModule", { value: true });
const strapi_1 = require("@strapi/strapi");
//export default factories.createCoreController('api::contacto.contacto');
exports.default = strapi_1.factories.createCoreController('api::contacto.contacto', ({ strapi }) => ({
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
