$(document).ready(function () {

    const article = $(".article");

    article.on({
        mouseover: function () {
            const id = $(this).attr('id');
            const prix = $(`#${id} .prix`);
            prix.show();
        },
        mouseout: function () {
            const id = $(this).attr('id');
            const prix = $(`#${id} .prix`);
            prix.hide();
        }
    });

    const connexion = $("#connexion");
    let i = true;

    // gère la visibilité de la page du gérant
    $("#gerant").on({
        click: function () {
            if (i) {
                connexion.show();
                i = false;
            } else {
                connexion.hide();
                i = true;
            }
        }
    });

    $("#close").on({
        click: function () {
            connexion.hide();
            i = true;
        }
    });

    // gère l'affichage de l'onglet filtre
    const filtre = $("#filtre");
    let j = true;
    $("#button_filter").on({
        click: function () {
            if (j) {
                filtre.show().animate({ right: "0" }, 500);
                j = false;
            } else {
                filtre.animate({
                    right: "-500px"
                }, 500, function () {
                    filtre.hide();
                });
                j = true;
            }
        }
    });

    $('input[name="prix"]').on('input', function () {
        var valeur = $(this).val();
        $('#valeur').text(valeur + '€');
    });
});
