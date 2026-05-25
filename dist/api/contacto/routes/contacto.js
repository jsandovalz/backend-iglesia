"use strict";
/**
 * contacto router
 */
Object.defineProperty(exports, "__esModule", { value: true });
// export default factories.createCoreRouter('api::contacto.contacto');
exports.default = {
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
