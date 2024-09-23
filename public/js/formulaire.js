$(document).ready(function() {

  $("#submit").attr("disabled", true);

  $("#civil, #nom, #prenom").on("keyup change", function() {
    var civil = $("#civil").val();
    var nom = $("#nom").val();
    var prenom = $("#prenom").val();
    $("#complet").val(civil + " " + prenom + " " + nom);
  });

  $("#birthdate").attr({
      "min" : "1923-05-15" ,
      "max" : "2023-05-15"
   });

  // permet de gérer les champs vide -> doit empêcher de valider le formulaire
  $(".form-control").on("keyup change", function() {
      let allFilled = true;
      $(".form-control").each(function() {

        /* si un élement est vide */
        if (!$(this).val()) {
          allFilled = false;
          $(this).prev("label").css("color", "red");
        } else {
          $(this).prev("label").css("color", "black");
        }

      });

      if (allFilled) {
        $("#submit").prop("disabled", false);
      }

    }); 

});
