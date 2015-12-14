$(document).ready(function () {
    $('#modifbutton').on('submit', function (e) {

        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'modifierclient', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) {
                window.location.reload();
            },
            error: function (e) {
                alert("Erreur accès au reseau");
            }
        });
       $(window).bind("load", function () {
    $('#myModalModifier').modal('show');
}); 
    });
});



