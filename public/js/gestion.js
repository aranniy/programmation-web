function supprimerCommande(idCommande) {
    $.ajax({
      type: 'DELETE',
      url: '/commande/' + idCommande,
      success: function() {
        window.location.reload();
      },
      error: function() {
        alert('Erreur lors de la suppression de la commande');
      }
    });
  }
 
$(document).ready(function() {

    // Pour supprimer une commande
    $('.table').on('click', '.btn-danger', function() {
     const id = $(this).data('id');
     supprimerCommande(id);
    });

});
  