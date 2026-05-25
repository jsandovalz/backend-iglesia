module.exports = {
  async afterCreate(event) {
    const { result } = event;
    const { publicar_facebook, publicar_tiktok, publicar_instagram, publicar_whatsapp } = result;

    // Ejemplo: publicar en Facebook si está marcado
    if (publicar_facebook) {
      await strapi.service('api::event.event').publicarFacebook(result);
    }

    if (publicar_instagram) {
      await strapi.service('api::event.event').publicarInstagram(result);
    }
    if (publicar_whatsapp) {
      await strapi.service('api::event.event').publicarWhatsapp(result);
    }
    if (publicar_tiktok) {
      await strapi.service('api::event.event').publicarTiktok(result);
    }
  },
};