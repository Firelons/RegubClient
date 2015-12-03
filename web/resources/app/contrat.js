/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

//Pour la partie des contrats 
$(document).ready(function () {
    $('#ModalModifier').on('submit', function (e) {

        // j'annule le submit par defaut du navigateur
        e.preventDefault();
        //je recupere les deux champs du formulaire
        //var inputEmail = $('#inputEmail').val();
        //var inputPassword = $('#inputPassword').val();
        var $this = $(this);
        //je precise a ajax les params 
        $.ajax({
            url: 'regub/commercial/contrats/modifiercontrat/{id}', //url qui est liée avec l'action de controller
            data: $this.serialize(), //données 
            type: 'POST', //methode d'envoie de données
            success: function (response) { 
            },
            error: function (e) {
                //alert("Erreur accès au reseau");
            }
        });
    });
});
