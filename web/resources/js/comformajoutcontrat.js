/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$(document).ready(function () {
    $('.selectrayon').SumoSelect({
         placeholder: 'Choississez un ou plusieurs rayons',
         csvDispCount: 5
         //selectAll: true //fait apparaitre la case select all pour selectionner tous les rayons
    });
    
    $('.selectregion').SumoSelect({
         placeholder: 'Choississez une ou plusieurs region',
         csvDispCount: 5
    });
   
});

$(function () {
    $('#datetimedebut').datepicker({
        format: 'd-m-yyyy'
    });
    $('#datetimefin').datepicker({
        format: 'd-m-yyyy'
    });
    $('#datetimereception').datepicker({
        format: 'd-m-yyyy'
    });
    $('#datetimevalidation').datepicker({
        format: 'd-m-yyyy'
    });
});

//peut aussi etre utilisé pr le type string
 function isInteger(x) {
        return Math.round(x) === x;
    }

function validateComFormulaireAjoutContrat() {
    var currentDate = new Date();
    var day = currentDate.getDate();
    var month = currentDate.getMonth() + 1;
    var year = currentDate.getFullYear();
    var date = year+"-"+month+"-"+day;
    
    var x1 = document.forms["ComFormulaireAjoutContrat"]["titre"].value;
    var x2 = document.forms["ComFormulaireAjoutContrat"]["frequence"].value;
    var x3 = document.forms["ComFormulaireAjoutContrat"]["rayon"].value;
    var x4 = document.forms["ComFormulaireAjoutContrat"]["datedebut"].value;
    var x5 = document.forms["ComFormulaireAjoutContrat"]["datefin"].value;
    var x6 = document.forms["ComFormulaireAjoutContrat"]["datereception"].value;
    var x7 = document.forms["ComFormulaireAjoutContrat"]["datevalidation"].value;
    var x8 = document.forms["ComFormulaireAjoutContrat"]["fichier"].value;
    var x9 = document.forms["ComFormulaireAjoutContrat"]["statut"].value;
    var x10 = document.forms["ComFormulaireAjoutContrat"]["region"].value;
    var x11 = document.forms["ComFormulaireAjoutContrat"]["tarif"].value;
    var x12 = document.forms["ComFormulaireAjoutContrat"]["duree"].value;
    
    if (x1 === null || x1 === "") {
        $('p.erreur-form').html("Vous devez fournir un titre");
        return false;
    }
    
    if (x2 === null || x2 === "") {
        $('p.erreur-form').html("Vous devez fournir une fréquence");
        return false;
    }
    if (isNaN(x2)) {
        $('p.erreur-form').html("La fréquence doit être un chiffe ou un nombre");
        return false;
    }
    if (isInteger(x2) === false) {
        $('p.erreur-form').html("La fréquence doit être un entier");
        return false;
    }
    
    if (x12 === null || x12 === "") {
        $('p.erreur-form').html("Vous devez fournir une durée");
        return false;
    }
    if (isNaN(x12)) {
        $('p.erreur-form').html("La durée doit être un chiffe ou un nombre");
        return false;
    }
    
    if (x3 === null || x3 === "") {
        $('p.erreur-form').html("Vous devez choisir un rayon");
        return false;
    }
    
    if (x4 === null || x4 === "") {
        $('p.erreur-form').html("Vous devez choisir une date de debut");
        return false;
    }
    if (x4<date) {
        $('p.erreur-form').html("La date de debut doit être supérieur à la date du jour");
        return false;
    }
    
    if (x5 === null || x5 === "") {
        $('p.erreur-form').html("Vous devez choisir une date de fin");
        return false;
    }
    if (x5<x4) {
        $('p.erreur-form').html("La date de fin doit être supérieure à la date de debut");
        return false;
    }
    
    if (x6 === null || x6 === "") {
        $('p.erreur-form').html("Vous devez choisir une date de reception");
        return false;
    }
    
    if (x7 === null || x7 === "") {
        $('p.erreur-form').html("Vous devez choisir une date de validation");
        return false;
    }
    
    if (x8 === null || x8 === "") {
        $('p.erreur-form').html("Vous devez choisir un fichier");
        return false;
    }
    
    if (x9 === null || x9 === "") {
        $('p.erreur-form').html("Vous devez choisir un statut");
        return false;
    }
    
    if (x10 === null || x10 === "") {
        $('p.erreur-form').html("Vous devez choisir une ou plusieurs regions");
        return false;
    }
    
    if (x11 === null || x11 === "") {
        $('p.erreur-form').html("Vous devez fournir un tarif");
        return false;
    }
    if (isNaN(x11)) {
        $('p.erreur-form').html("Le tarif doit être un chiffe ou un nombre");
        return false;
    }
     
    
}