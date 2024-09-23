function supprimerProduitPanier(idProduit) {
  $.ajax({
    type: 'DELETE',
    url: '/produit/' + idProduit,
    success: function() {
      window.location.reload();
    },
    error: function() {
      alert('Erreur lors de la suppression du produit');
    }
  });
}

function VerifNbrArticlesPanier() {
  $.getJSON('/panier/nbrArticles', function(data) {
    const count = data;
    if (!count) {
      $('button.btn-block').prop('disabled', true);
    } else {
      $('button.btn-block').prop('disabled', false);
    }
  });
}

  $(document).ready(function() {

    // Désactiver le bouton si aucun article dans le panier
    VerifNbrArticlesPanier();

    // Pour supprimer un article du panier 
    $('.table').on('click', '.btn-danger', function() {
      const id = $(this).data('id');
      supprimerProduitPanier(id);
    });
  
    $('button.btn-block').click(function() {
      window.location.href = '/form';
    });

  });
