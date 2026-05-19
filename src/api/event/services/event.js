const fetch = require("node-fetch");

module.exports = {
  async publicarFacebook(evento) {
    try {
      const pageId = process.env.FACEBOOK_PAGE_ID;
      const token = process.env.FACEBOOK_PAGE_TOKEN;

      const mensaje = `📅 Nuevo evento: ${evento.titulo}\n\n${evento.descripcion}\n\nFecha: ${evento.fecha_inicio}`;

      const response = await fetch(`https://graph.facebook.com/${pageId}/feed`, {
        cache: "no-store",
        method: "POST",
        headers: { "Content-Type": "application/json" },
        body: JSON.stringify({
          message: mensaje,
          access_token: token,
        }),
      });

      const data = await response.json();
      if (data.error) {
        strapi.log.error("Error publicando en Facebook:", data.error);
      } else {
        strapi.log.info("Evento publicado en Facebook con ID:", data.id);
      }
    } catch (err) {
      strapi.log.error("Error en publicarFacebook:", err);
    }
  },
};