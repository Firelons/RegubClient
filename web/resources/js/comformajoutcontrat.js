/* 
 * To change this license header, choose License Headers in Project Properties.
 * To change this template file, choose Tools | Templates
 * and open the template in the editor.
 */

$('#titre').blur(function(){
    if(this.value.trim() ===""){
        //this.estValide = false;color: red
        //$('p.erreur-form').css('color: red');
        $('p.erreur-form').html("Vous devez fournir un titre");
        //$(this).addClass('invalide');
    }
    else {
    }
   //alert(this.prop3il); 
});

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

$('#rayon').blur(function(){
    if(this.value !==null){
        alert(this.value);
    }
});

$(function () {
    $('#datetimedebut').datepicker({
        format: 'yyyy-mm-dd'
    });
    $('#datetimefin').datepicker({
        format: 'yyyy-mm-dd'
    });
    $('#datetimereception').datepicker({
        format: 'yyyy-mm-dd'
    });
    $('#datetimevalidation').datepicker({
        format: 'yyyy-mm-dd'
    });
});

/* $(document).ready(function() {
    $('#FormulaireAjout').formValidation({
        //framework: 'bootstrap',
        icon: {
            valid: 'glyphicon glyphicon-ok',
            invalid: 'glyphicon glyphicon-remove',
            validating: 'glyphicon glyphicon-refresh'
        },
        fields: {
            client: {
                row: '.col-xs-6',
                validators: {
                    notEmpty: {
                      
                    }
                }
            },
            //pr le titre
            titre: {
                row: '.col-xs-6',
                validators: {
                    notEmpty: {
                        message: 'Un titre est requis svp'
                    },
                    stringLength: {
                        max: 2,
                        message: 'Le nombre de caractères maximum est de 200 pr le titre'
                    }
                }
            },
            genre: {
                row: '.col-xs-4',
                validators: {
                    notEmpty: {
                        message: 'The genre is required'
                    }
                }
            },
            director: {
                row: '.col-xs-4',
                validators: {
                    notEmpty: {
                        message: 'The director name is required'
                    },
                    stringLength: {
                        max: 80,
                        message: 'The director name must be less than 80 characters long'
                    }
                }
            },
            writer: {
                row: '.col-xs-4',
                validators: {
                    notEmpty: {
                        message: 'The writer name is required'
                    },
                    stringLength: {
                        max: 80,
                        message: 'The writer name must be less than 80 characters long'
                    }
                }
            },
            producer: {
                row: '.col-xs-4',
                validators: {
                    notEmpty: {
                        message: 'The producer name is required'
                    },
                    stringLength: {
                        max: 80,
                        message: 'The producer name must be less than 80 characters long'
                    }
                }
            },
            website: {
                row: '.col-xs-6',
                validators: {
                    notEmpty: {
                        message: 'The website address is required'
                    },
                    uri: {
                        message: 'The website address is not valid'
                    }
                }
            },
            trailer: {
                row: '.col-xs-6',
                validators: {
                    notEmpty: {
                        message: 'The trailer link is required'
                    },
                    uri: {
                        message: 'The trailer link is not valid'
                    }
                }
            },
            review: {
                // The group will be set as default (.form-group)
                validators: {
                    stringLength: {
                        max: 500,
                        message: 'The review must be less than 500 characters long'
                    }
                }
            },
            rating: {
                // The group will be set as default (.form-group)
                validators: {
                    notEmpty: {
                        message: 'The rating is required'
                    }
                }
            }
        }
    });
});
*/