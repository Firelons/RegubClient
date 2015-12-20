$(document).ready(function () {
    $('#modifClient').on('submit', function (e) {
        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var mdp = $('#newpassword').val();
        var confirmmdp = $('#password_confirmation').val();
        var oldmdp = $('#oldpassword').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'modifierclient', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { // response est le type de données de retour. ici la methode du controller retourne un string
                if (mdp.length < 8) {
                    $('#errormod').html("le mot de passe a au moins 8 caractères");
                    $('#infomod').html("");
                } else if (mdp !== confirmmdp) {
                    $('#errormod').html("confirmation different du nouveau");
                    $('#infomod').html("");
                } else { //test si  response est correct
                    if (response === "success") {
                        $('#infomod').html("Enregistrement reussi");
                        $('#errormod').html("");
                        window.location.replace('client'); //redirection
                    } else if (response === "erroroldmdp") {
                        $('#infomod').html("");
                        $('#errormod').html("ancien mot de passe incorrect");
                    } else {
                        $('#errormod').html("Echec de l'enregistrement");
                        $('#infomod').html("");
                    }
                }
            },
            error: function (e) {
                alert("Erreur accès au reseau");
            }
        });
    });
});