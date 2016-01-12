/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $('#paramAdministrateur').on('submit', function (e) {
        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var mdp = $('#newpassword').val();
        var confirmmdp = $('#password_confirmation').val();
        var oldmdp = $('#oldpassword').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'RegubClient/admin/paramAdminitrateur/', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { // response est le type de données de retour. ici la methode du controller retourne un string
                if (mdp !== confirmmdp) {
                    $('#errormod').html("confirmation different du nouveau");
                    $('#infomod').html("");
                } else { //test si  response est correct
                    if (response === "success") {
                        $('#infomod').html("Enregistrement reussi");
                        $('#errormod').html("");
                        window.location.reload();
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
    
    $('#entreprise').on('submit', function (e) {
       
        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'entrepriseenregistrer', //url qui est liÃ©e avec l'action de controller
            data: $this.serialize(), //donnÃ©es 
            type: 'POST', //methode d'envoie de donnÃ©es
            success: function (response) {
                    alert("Enregistrement effectué");
                     window.location.reload(); //redirection
            },
            error: function (e) {
                alert("Erreur accés au reseau");
            }
        });
    });
});
