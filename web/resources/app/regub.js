$(document).ready(function () {
    $('#comptelogin').on('submit', function (e) {

        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var inputlogin = $('#login').val();
        var inputPassword = $('#inputPassword').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'admconnect', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { // response est le type de données de retour. ici la methode du controller retourne un string
                if (response === "admin") { //test si  response est client.jsp
                    $('#info').html("Authentification reussie");
                    $('#error').html("");
                    window.location.replace('admin'); //redirection
                } else if (response === "commercial") { //test si  response est client.jsp
                    $('#info').html("Authentification reussie");
                    $('#error').html("");
                    window.location.replace('regub/commercial/'); //redirection
                }else if (response === "gestionnaire") { //test si  response est client.jsp
                    $('#info').html("Authentification reussie");
                    $('#error').html("");
                    window.location.replace('regub'); //redirection
                }
                else{
                    $('#info').html("");
                    $('#error').html("Authentification échouée");
                }
            },
            error: function (e) {
                alert("Erreur accès au reseau");
            }
        });
    });
});
