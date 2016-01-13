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
    /*$("select").multipleSelect({
        multipleWidth: 55,
        width: '100%'
    });
    */
   
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
    
    var freq = document.FormulaireModif.frequence.value;
    var dure = document.FormulaireModif.duree.value;
    var datedebut = document.FormulaireModif.datedebut.value;
    
    var datefin = document.FormulaireModif.datefin.value;
    
    var tarif = document.FormulaireModif.tarif.value;
    var statut = document.FormulaireModif.statut.value;
    var rayon = document.FormulaireModif.rayon.value;
    var region = document.FormulaireModif.region.value;
    
    //verif sur la frequence
    if (freq === null || freq === "") {
        $('p.erreur-form').html("Vous devez fournir une fréquence");
        return false;
    }
    if (isNaN(freq)) {
        $('p.erreur-form').html("La fréquence doit être un chiffe ou un nombre");
        return false;
    }
    
    //Verif sur la durée
    if (dure === null || dure === "") {
        $('p.erreur-form').html("Vous devez fournir une durée");
        return false;
    }
    if (isNaN(dure)) {
        $('p.erreur-form').html("La durée doit être un chiffe ou un nombre");
        return false;
    }
    
    //verif sur la date de fin
    if (datefin === null || datefin === "") {
        $('p.erreur-form').html("Vous devez choisir une date de fin");
        return false;
    }
    if (datefin<datedebut) {
        $('p.erreur-form').html("La date de fin doit être supérieure à la date de debut");
        return false;
    }
    
    //verif sur le tarif
    if (tarif === null || tarif === "") {
        $('p.erreur-form').html("Vous devez entrer un tarif");
        return false;
    }
    if (isNaN(tarif)) {
        $('p.erreur-form').html("Le tarif doit être un chiffe ou un nombre");
        return false;
    }
    
    //verif sur le statut
    if (statut === null || statut === "") {
        $('p.erreur-form').html("Vous devez choisir un statut");
        return false;
    }
    
    //verif sur le rayon
    if (rayon === null || rayon === "") {
        $('p.erreur-form').html("Vous devez choisir un ou plusieurs rayon(s)");
        return false;
    }
    
    //verif sur la region
    if (region === null || region === "") {
        $('p.erreur-form').html("Vous devez choisir une ou plusieurs regions(s)");
        return false;
    }
    
} 
