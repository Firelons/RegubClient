<%-- 
    Document   : testajout
    Created on : 5 déc. 2015, 12:50:51
    Author     : TOUANI Serge
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>

<html lang="fr">
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Test| Regub</title>
        
         <!-- Bootstrap Core CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>" type="text/css">

        <!-- Custom Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="<c:url value="/resources/font-awesome/css/font-awesome.min.css"/>" type="text/css">

        <!-- Plugin CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/animate.min.css"/>" type="text/css">

        <!-- Custom CSS -->
        <link rel="stylesheet" href="<c:url value="/resources/css/creative.css"/>" type="text/css">
        <link rel="stylesheet" href="<c:url value="/resources/css/form.css"/>" type="text/css">
        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap-datepicker-css.css"/>" type="text/css">

    </head>
    <body id="page-top">
        <jsp:include page="navContrat.jsp" />
        
        <section>
            <div class="container">
                <div class="panel panel-default container">
                    <div class="panel-heading">
                        <strong class="">Ajouter Contrat</strong>
                    </div>
                    <div class="panel-body">
                            <form id="FormulaireAjout" method="post" action="" role="form" class="form-horizontal">
                            <div class="form-group">
                                <p class="erreur-form"/>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <fieldset disabled="true" class="col-xs-6">
                                        <div>
                                           <label class="control-label" >Client</label> 
                                           <input type="text" class="form-control" name="client" value="${ajout}">
                                        </div> 
                                    </fieldset>
                                    <div class="col-xs-6">
                                        <label class="control-label" >Titre</label>
                                        <input type="text" class="form-control" id="titre" name="titre" placeholder="Titre">
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label class="control-label" >Frequence(par jour)</label>
                                        <input type="text" class="form-control" id="frequence" name="frequence" placeholder="frequence">
                                    </div>
                                    <div class="col-xs-6">
                                        <label class="control-label" >Durée(en secondes)</label>
                                        <input type="text" class="form-control" id="duree" name="duree" placeholder="duree">
                                    </div>
                                </div>
                            </div>            
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label class="control-label" >Date De Debut</label>
                                        <div class="input-group date" id="datetimedebut">
                                            <input type="text" class="form-control" id="" name="datedebut" placeholder="datedebut">
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <label class="control-label" >Date De Fin</label>
                                        <div class="input-group date" id="datetimefin">
                                            <input type="text" class="form-control" id="" name="datefin" placeholder="datefin">
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label class="control-label" >Date De Reception</label>
                                        <div class="input-group date" id="datetimereception">
                                            <input type="text" class="form-control" id="datereception" name="datereception" placeholder="datereception">
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                            </span>
                                        </div>
                                    </div>
                                    <div class="col-xs-6">
                                        <label class="control-label" >Date De Validation</label>
                                        <div class="input-group date" id="datetimevalidation">
                                            <input type="text" class="form-control" id="datevalidation" name="datevalidation" placeholder="datevalidation">
                                            <span class="input-group-addon">
                                                <i class="glyphicon glyphicon-calendar"></i>
                                            </span>
                                        </div>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-4">
                                        <label class="control-label" >Fichier(Mp4) :</label>
                                        <!-- filestyle -->
                                        <input type="file" class="filestyle" id="fichier" name="" data-placeholder="Choississez un fichier video" data-buttonText="Browse" data-buttonName="btn-primary" data-icon="false">
                                        <!--<span class="input-group-btn">
                                            <span class="btn btn-info btn-file">
                                                Browse&hellip; <input type="file" multiple>
                                            </span>
                                        </span>
                                        <input type="text" class="form-control" readonly> -->
                                        <!--<input id="lefile" type="file" style="display:none">
                                        <div class="input-group date">
                                            <input id="photoCover" class="form-control filestyle" type="text">
                                            <!--<a class="btn" onclick="$('input[id=lefile]').click();">Browse</a>
                                            <span class="input-group-addon" onclick="$('input[id=lefile]').click();">
                                                <i class="glyphicon glyphicon glyphicon-folder-open"></i>
                                            </span>
                                        </div> -->
                                    </div>
                                    <div class="col-xs-4">
                                        <label class="control-label" >Tarif</label>
                                        <input type="text" class="form-control" id="tarif" name="tarif" placeholder="tarif">
                                    </div>
                                    <div class="col-xs-4">
                                        <label class="control-label ">Statut : </label>
                                        <div>
                                            <!-- "rating" valeur d'attribut name du statut choisi -->
                                            <label class="radio radio-inline">
                                                <input type="radio" name="rating" value="valide" /> Validé
                                            </label>
                                            <label class="radio radio-inline">
                                                <input type="radio" name="rating" value="preparation" /> Préparation
                                            </label>
                                            <label class="radio radio-inline">
                                                <input type="radio" name="rating" value="annule" /> Annulé
                                            </label>
                                        </div>
                                    </div>
                                </div>
                            </div>    
                            <div class="form-group">
                                <div class="row">
                                    <div class="col-xs-6">
                                        <label class="control-label">Type De Rayon :</label>
                                        <select multiple class = "form-control">
                                            <c:forEach var="reg" items="${rayon}">
                                                <option>
                                                    <c:out value="${reg.getLibelle()}"></c:out>
                                                </option> 
                                            </c:forEach>
                                        </select> 
                                    </div>
                                    <div class="col-xs-6">
                                        <label class="control-label">Regions :</label>
                                        <select multiple class = "form-control">
                                            <option>1</option>
                                            <option>2</option>
                                            <option>3</option>
                                            <option>4</option>
                                            <option>5</option>
                                        </select>
                                    </div>
                                </div>
                            </div>
                            
                            <div class="form-group">
                                <button type="submit" class="btn btn-info col-xs-6">Ajouter</button>
                                <a href="/RegubClient/regub/commercial/contrats/${cleclient}" class="btn btn-info col-xs-6" data-toggle="modal"> 
                                    <c:out value=""></c:out>Annuler</a>
                            </div>
                        </form>    
                    </div>        
                </div>
            </div>
        </section>
        
        <!-- <jsp:include page="foot.jsp" /> -->
        
        <!-- Modal Paramètre -->
        <div class="modal fade" id="myModalParametre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Paramètre</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="nom" id="nom" class="form-control input-sm" placeholder="nom" value="${UserConnected.getSociete()} "required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Prenom*</label>
                                    <div class="form-group">
                                        <input type="text" name="prenom" id="prenom" class="form-control input-sm" placeholder="prenom"value="${UserConnected.getTelephone()}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>E-mail*</label>
                                <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email" value="${UserConnected.getEmail()}" required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                         <label>Ancien mot de passe</label>
                                        <input type="oldpassword" name="oldpassword" id="oldpassword" class="form-control input-sm" placeholder="Ancien mot de passe" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                         <label>Mot de passe*(8 caractères min)</label>
                                        <input type="newpassword" name="motDePasse" id="newpassword" class="form-control input-sm" placeholder="Nouveau mot de passe" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Confirmation*</label>
                                        <input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-sm" placeholder="confirmation" required Autofocus>
                                    </div>
                                </div>
                            </div>
                            <input type="submit" value="Enregistrer" class="btn btn-info btn-block">

                        </form>

                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                    </div>
                </div>
            </div>
        </div>
        
        <!-- jQuery -->
        <script src="<c:url value="/resources/js/jquery.js"/>"></script>

        <!-- Bootstrap Core JavaScript -->
        <script src="<c:url value="/resources/js/bootstrap.min.js"/>"></script>

        <!-- Plugin JavaScript -->
        <script src="<c:url value="/resources/js/jquery.easing.min.js"/>"></script>
        <script src="<c:url value="/resources/js/jquery.fittext.js"/>"></script>
        <script src="<c:url value="/resources/js/wow.min.js"/>"></script>

        <!-- Custom Theme JavaScript -->
        <script src="<c:url value="/resources/js/creative.js"/>"></script>
        
        <script src="<c:url value="/resources/js/bootstrap-datepicker.js"/>"></script>
        <script src="<c:url value="/resources/js/bootstrap-filestyle.min.js"/>"></script> 
        
        <script src="<c:url value="/resources/js/formajout.js"/>"></script> 
        
    </body>
</html>


