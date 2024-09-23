$(document).ready(function () {
    let images = $(".image");
    images.hide();
    images.eq(0).show();
    let i = 0;


    $('#gauche').on({
        click: function () {
            images.eq(i).hide();
            i = (i-1)% images.length;
            images.eq(i).show();
        }
    });

    $('#droite').on({
        click: function () {
            images.eq(i).hide();
            i = (i+1)% images.length;
            images.eq(i).show();
        }
    });

    $('#select_taille').on({
        change: function () {
            $('#ajout_panier').prop('disabled', !$(this).val());
        }
    });
});