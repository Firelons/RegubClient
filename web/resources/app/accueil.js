$(document).ready(function () {
    $('#connectClient').on('submit', function (e) {

        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var inputEmail = $('#inputEmail').val();
        var inputPassword = $('#inputPassword').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'connection', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { // response est le type de données de retour. ici la methode du controller retourne un string
                if (response === "client") { //test si  response est client.jsp
                    $('#info').html("Authentification reussie");
                    $('#error').html("");
                    window.location.replace('' + response.toString()); //redirection
                } else if (response === "accueil") {//test si response est accueil.jsp
                    $('#error').html("Erreur email / mot de passe");
                    $('#info').html("");
                }
            },
            error: function (e) {
                alert("Erreur accès au reseau");
            }
        });
    });
});

$(document).ready(function () {
    $('#inscripClient').on('submit', function (e) {
        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var mdp = $('#password').val();
        var confirm = $('#password_confirmation').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'inscription', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { // response est le type de données de retour. ici la methode du controller retourne un string
                if (mdp.length < 8) {
                    $('#errorins').html("le mot de passe a au moins 8 caractères");
                    $('#infoins').html("");
                } else if (mdp !== confirm) {
                    $('#errorins').html("confirmation different de mot de passe");
                    $('#infoins').html("");
                } else { //test si  response est correct
                    $('#infoins').html("Enregistrement reussi");
                    $('#errorins').html("");
                    window.location.replace('inscription'); //redirection
                }
            },
            error: function (e) {
                alert("Erreur acces au reseau");
            }
        });
    });
});