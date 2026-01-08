<script setup>
import { onMounted } from 'vue'

onMounted(() => {
  document.title = 'Mentions Légales - 4L des Dômes'
  window.scrollTo(0, 0)
})
</script>

<template>
  <div class="legal-notice">
    <div class="container">
      <h1 class="page-title">📢 Mentions Légales</h1>
      
      <section class="legal-section">
        <h2>1. Identité de l'Éditeur</h2>
        <div class="info-grid">
          <div class="info-item">
            <strong>Nom de l'association :</strong>
            <p>Association La 4L des Dômes</p>
          </div>
          <div class="info-item">
            <strong>Forme juridique :</strong>
            <p>Association Loi 1901</p>
          </div>
          <div class="info-item">
            <strong>Adresse du siège social :</strong>
            <p>4 rue de la Charme<br>63910 Vertaizon</p>
          </div>
          <div class="info-item">
            <strong>Responsables de publication :</strong>
            <p>Bastien Jacquelin et Antoine Imbert</p>
          </div>
          <div class="info-item">
            <strong>Contact téléphonique :</strong>
            <p><a href="tel:+33652423311">06 52 42 33 11</a></p>
          </div>
          <div class="info-item">
            <strong>Contact e-mail :</strong>
            <p><a href="mailto:la4ldesdomes@gmail.com">la4ldesdomes@gmail.com</a></p>
          </div>
        </div>
      </section>

      <section class="legal-section">
        <h2>2. Hébergement et Nom de Domaine</h2>
        <div class="info-grid">
          <div class="info-item">
            <strong>Nom du registraire (Nom de domaine) :</strong>
            <p>OVH SAS<br>
            2 rue Kellermann<br>
            59100 Roubaix, France<br>
            Tél. : 1007 (depuis la France)</p>
          </div>
          <div class="info-item">
            <strong>Hébergeur du site :</strong>
            <p>Le site est hébergé sur un serveur personnel par l'association La 4L des Dômes<br>
            4 rue de la Charme<br>
            63910 Vertaizon</p>
          </div>
          <div class="info-item">
            <strong>Fournisseur d'accès internet (FAI) :</strong>
            <p>Free<br>
            SAS Free<br>
            75008 Paris, France</p>
          </div>
        </div>
      </section>

      <section class="legal-section">
        <h2>3. Informations Commerciales - Conditions Générales de Vente</h2>
        
        <div class="subsection">
          <h3>3.1. Objet des ventes</h3>
          <p>T-shirts et pulls personnalisés pour le soutien du projet 4L Trophy 2026 (Association La 4L des Dômes).</p>
        </div>

        <div class="subsection">
          <h3>3.2. Prix</h3>
          <div class="price-table">
            <div class="price-row">
              <span class="product-name">T-shirt</span>
              <span class="product-price">20 € TTC</span>
            </div>
            <div class="price-row">
              <span class="product-name">Pull (Sweat-shirt)</span>
              <span class="product-price">35 € TTC</span>
            </div>
            <div class="price-row highlight">
              <span class="product-name">Frais de livraison</span>
              <span class="product-price">GRATUITS</span>
            </div>
          </div>
        </div>

        <div class="subsection">
          <h3>3.3. Modalités de livraison</h3>
          <p>Livraison personnelle par les membres de l'association (remise en main propre dans la région du Puy-de-Dôme) ou par envoi postal.</p>
        </div>

        <div class="subsection">
          <h3>3.4. Modèle de commande</h3>
          <p>La vente se fait par précommande sur une durée déterminée. Le délai de livraison prendra effet après la clôture de la boutique, en tenant compte du temps de fabrication (2 à 4 semaines).</p>
        </div>

        <div class="subsection">
          <h3>3.5. Paiement</h3>
          <p>Le paiement s'effectue via la plateforme HelloAsso. Aucune donnée bancaire n'est collectée ou stockée par l'association La 4L des Dômes.</p>
        </div>

        <div class="subsection">
          <h3>3.6. Droit de rétractation</h3>
          <p>Conformément à l'article L221-28 du Code de la consommation, le droit de rétractation ne peut être exercé pour les contrats de fourniture de biens confectionnés selon les spécifications du consommateur ou nettement personnalisés. Les produits vendus étant personnalisés avec le logo de l'association, aucun droit de rétractation ne peut être exercé sauf en cas de produit défectueux.</p>
        </div>
      </section>

      <section class="legal-section">
        <h2>4. Protection des Données Personnelles (RGPD)</h2>
        
        <div class="subsection">
          <h3>4.1. Responsable du traitement</h3>
          <p>Association La 4L des Dômes<br>
          4 rue de la Charme, 63910 Vertaizon<br>
          Contact : <a href="mailto:la4ldesdomes@gmail.com">la4ldesdomes@gmail.com</a></p>
        </div>

        <div class="subsection">
          <h3>4.2. Finalité de la collecte</h3>
          <p>Les données personnelles collectées sont utilisées pour :</p>
          <ul>
            <li>La gestion et l'expédition des commandes (merchandising)</li>
            <li>Le suivi des dons</li>
            <li>La communication relative au projet (avec consentement préalable)</li>
          </ul>
        </div>

        <div class="subsection">
          <h3>4.3. Données collectées</h3>
          <p>Les données collectées peuvent inclure :</p>
          <ul>
            <li>Nom et prénom</li>
            <li>Adresse e-mail</li>
            <li>Numéro de téléphone</li>
            <li>Adresse postale (pour la livraison)</li>
          </ul>
        </div>

        <div class="subsection">
          <h3>4.4. Droits des utilisateurs</h3>
          <p>Conformément au Règlement Général sur la Protection des Données (RGPD), vous disposez des droits suivants :</p>
          <ul>
            <li><strong>Droit d'accès :</strong> obtenir la confirmation que vos données sont traitées et accéder à ces données</li>
            <li><strong>Droit de rectification :</strong> corriger vos données inexactes ou incomplètes</li>
            <li><strong>Droit à l'effacement (droit à l'oubli) :</strong> demander la suppression de vos données</li>
            <li><strong>Droit d'opposition :</strong> vous opposer au traitement de vos données</li>
            <li><strong>Droit à la portabilité :</strong> recevoir vos données dans un format structuré</li>
            <li><strong>Droit à la limitation du traitement :</strong> demander la limitation du traitement de vos données</li>
          </ul>
          <p class="contact-info">Pour exercer ces droits, contactez-nous à : <a href="mailto:la4ldesdomes@gmail.com">la4ldesdomes@gmail.com</a></p>
        </div>

        <div class="subsection">
          <h3>4.5. Durée de conservation</h3>
          <p>Vos données personnelles sont conservées pendant la durée nécessaire à la réalisation des finalités mentionnées ci-dessus, et conformément aux obligations légales en vigueur.</p>
        </div>

        <div class="subsection">
          <h3>4.6. Cookies</h3>
          <p>Le site utilise des cookies techniques nécessaires au bon fonctionnement du site (panier d'achat, préférences). Aucun cookie de tracking ou publicitaire n'est utilisé.</p>
          <p>Vous pouvez paramétrer votre navigateur pour refuser les cookies, mais cela peut affecter certaines fonctionnalités du site.</p>
        </div>

        <div class="subsection">
          <h3>4.7. Sécurité des données</h3>
          <p>L'association La 4L des Dômes met en œuvre toutes les mesures techniques et organisationnelles appropriées pour garantir la sécurité de vos données personnelles et empêcher qu'elles soient déformées, endommagées ou communiquées à des tiers non autorisés.</p>
        </div>
      </section>

      <section class="legal-section">
        <h2>5. Propriété Intellectuelle</h2>
        <p>L'ensemble du contenu de ce site (textes, images, logos, vidéos) est la propriété exclusive de l'association La 4L des Dômes, sauf mention contraire.</p>
        <p>Toute reproduction, distribution, modification, adaptation, retransmission ou publication de ces différents éléments est strictement interdite sans l'accord écrit préalable de l'association.</p>
      </section>

      <section class="legal-section">
        <h2>6. Limitation de Responsabilité</h2>
        <p>L'association La 4L des Dômes s'efforce de fournir sur ce site des informations aussi précises que possible. Toutefois, elle ne pourra être tenue responsable des omissions, des inexactitudes et des carences dans la mise à jour, qu'elles soient de son fait ou du fait des tiers partenaires qui lui fournissent ces informations.</p>
      </section>

      <section class="legal-section">
        <h2>7. Droit Applicable et Juridiction Compétente</h2>
        <p>Les présentes mentions légales sont régies par le droit français.</p>
        <p>En cas de litige et à défaut d'accord amiable, le litige sera porté devant les tribunaux français conformément aux règles de compétence en vigueur.</p>
      </section>

      <div class="footer-legal">
        <p><em>Dernière mise à jour : Novembre 2025</em></p>
        <router-link to="/" class="btn btn-primary">Retour à l'accueil</router-link>
      </div>
    </div>
  </div>
</template>

<style scoped>
.legal-notice {
  min-height: 100vh;
  background: white;
  padding: 120px 20px 60px;
}

.page-title {
  font-size: 48px;
  text-align: center;
  margin-bottom: 60px;
  background: linear-gradient(135deg, var(--primary-color), var(--secondary-color));
  -webkit-background-clip: text;
  -webkit-text-fill-color: transparent;
  background-clip: text;
}

.legal-section {
  background: #f8f9fa;
  border-radius: 20px;
  padding: 40px;
  margin-bottom: 30px;
  box-shadow: 0 5px 20px rgba(0, 0, 0, 0.05);
}

.legal-section h2 {
  font-size: 28px;
  color: var(--dark-color);
  margin-bottom: 25px;
  padding-bottom: 15px;
  border-bottom: 3px solid var(--primary-color);
}

.subsection {
  margin-bottom: 30px;
}

.subsection:last-child {
  margin-bottom: 0;
}

.subsection h3 {
  font-size: 20px;
  color: var(--primary-color);
  margin-bottom: 15px;
}

.subsection p,
.subsection ul {
  font-size: 16px;
  line-height: 1.8;
  color: #555;
}

.subsection ul {
  margin-left: 20px;
  margin-top: 10px;
}

.subsection li {
  margin-bottom: 8px;
}

.info-grid {
  display: grid;
  grid-template-columns: repeat(auto-fit, minmax(300px, 1fr));
  gap: 25px;
}

.info-item {
  background: white;
  padding: 20px;
  border-radius: 12px;
  border-left: 4px solid var(--primary-color);
}

.info-item strong {
  display: block;
  color: var(--dark-color);
  margin-bottom: 8px;
  font-size: 15px;
}

.info-item p {
  color: #555;
  line-height: 1.6;
  margin: 0;
}

.info-item a {
  color: var(--primary-color);
  text-decoration: none;
  transition: color 0.3s ease;
}

.info-item a:hover {
  color: var(--secondary-color);
  text-decoration: underline;
}

.price-table {
  background: white;
  border-radius: 12px;
  overflow: hidden;
  margin-top: 15px;
}

.price-row {
  display: flex;
  justify-content: space-between;
  align-items: center;
  padding: 20px 25px;
  border-bottom: 1px solid #f0f0f0;
}

.price-row:last-child {
  border-bottom: none;
}

.price-row.highlight {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
}

.product-name {
  font-weight: 600;
  color: var(--dark-color);
}

.product-price {
  font-size: 18px;
  font-weight: 700;
  color: var(--primary-color);
}

.contact-info {
  background: linear-gradient(135deg, rgba(102, 126, 234, 0.1), rgba(118, 75, 162, 0.1));
  padding: 15px 20px;
  border-radius: 10px;
  margin-top: 15px;
  font-weight: 600;
}

.contact-info a {
  color: var(--primary-color);
  text-decoration: none;
}

.contact-info a:hover {
  text-decoration: underline;
}

.footer-legal {
  text-align: center;
  margin-top: 60px;
  padding-top: 40px;
  border-top: 2px solid #e0e0e0;
}

.footer-legal em {
  display: block;
  color: #888;
  margin-bottom: 20px;
  font-size: 14px;
}

@media (max-width: 968px) {
  .legal-notice {
    padding: 100px 15px 40px;
  }

  .page-title {
    font-size: 36px;
    margin-bottom: 40px;
  }

  .legal-section {
    padding: 30px 25px;
  }

  .legal-section h2 {
    font-size: 24px;
  }

  .subsection h3 {
    font-size: 18px;
  }

  .info-grid {
    grid-template-columns: 1fr;
  }

  .price-row {
    padding: 15px 20px;
  }
}

@media (max-width: 480px) {
  .legal-notice {
    padding: 90px 10px 30px;
  }

  .page-title {
    font-size: 28px;
  }

  .legal-section {
    padding: 25px 20px;
  }

  .legal-section h2 {
    font-size: 22px;
  }

  .subsection h3 {
    font-size: 17px;
  }

  .subsection p,
  .subsection ul {
    font-size: 15px;
  }

  .info-item {
    padding: 15px;
  }

  .price-row {
    flex-direction: column;
    align-items: flex-start;
    gap: 8px;
    padding: 15px;
  }
}
</style>
