$(document).ready(function () {
    $('#modifbutton').on('submit', function (e) {
        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var $this = $(this);
        alert($this.serialize);
        //je precise a ajax les params 
        $.ajax({
            url: 'regub/commercial/modifierclient/48', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'GET', //methode d'envoie de données
            success: function (response) {
            },
            error: function (e) {
                alert("Erreur accès au reseau");
            }
        });
    });
});