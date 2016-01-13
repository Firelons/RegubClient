/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */


function validateComFormulaireAjoutContrat() {
    var currentDate = new Date();
    var day = currentDate.getDate();
    var month = currentDate.getMonth()+1;
    var year = currentDate.getFullYear();
    var date = day+"-"+month+"-"+year;
    
    var titre = document.FormulaireAjout.titre.value;
    var freq = document.FormulaireAjout.frequence.value;
    var dure = document.FormulaireAjout.duree.value;
    var datedebut = document.FormulaireAjout.datedebut.value;
    var datefin = document.FormulaireAjout.datefin.value;
    var fichier = document.getElementById("fichier");
   
    
    var rayon = document.FormulaireAjout.rayon.value;
    var region = document.FormulaireAjout.region.value;
    
    //verif sur le titre
    if (titre === null || titre === "") {
        $('p.erreur-form').html("Vous devez fournir un titre");
        return false;
    }
    if (titre !== null || titre !== "") {
        var alphanum = /^[0-9A-Za-z]+$/;
        if(!titre.match(alphanum)){
            $('p.erreur-form').html("Le titre ne peut contenir que des lettres et des chiffres");
            return false;
        }
    }
    
    //verif sur la frequence
    if (freq === null || freq === "") {
        $('p.erreur-form').html("Vous devez fournir une fréquence");
        return false;
    }
    if (isNaN(freq)) {
        $('p.erreur-form').html("La fréquence doit être un chiffe ou un nombre");
        return false;
    }
    
    //verif si fichier présent
    if (fichier.value === "") {
        $('p.erreur-form').html("Vous devez choisir une vidéo");
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
    
    //verif sur la date de debut
    if (datedebut === null || datedebut === "") {
        $('p.erreur-form').html("Vous devez choisir une date de debut");
        return false;
    }
    if (datedebut<date || datedebut !== date) {
        $('p.erreur-form').html("La date de debut doit être supérieur ou égale à la date du jour");
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
