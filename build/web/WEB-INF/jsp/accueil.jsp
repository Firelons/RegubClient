<%-- 
    Document   : acceuil
    Created on : 9 nov. 2015, 13:50:37
    Author     : Mesmerus
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<c:if test="${UserConnected!=null}">
    <c:redirect url="client"/>
</c:if>
<html lang="fr">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>RegubClient</title>

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

        <!-- HTML5 Shim and Respond.js IE8 support of HTML5 elements and media queries -->
        <!-- WARNING: Respond.js doesn't work if you view the page via file:// -->
        <!--[if lt IE 9]>
            <script src="https://oss.maxcdn.com/libs/html5shiv/3.7.0/html5shiv.js"></script>
            <script src="https://oss.maxcdn.com/libs/respond.js/1.4.2/respond.min.js"></script>
        <![endif]-->

    </head>

    <body id="page-top">

        <jsp:include page="navAccueil.jsp"/>
        <header>
            <div class="header-content">
                <div class="header-content-inner">
                    <h1>REGUBClient</h1>
                    <hr>
                    <p>Bienvenue sur la plateforme Regub dédiée a ses clients</p>
                    <button type="button" class="btn btn-primary btn-xl wow tada" data-toggle="modal" data-target="#myModal">
                        S'inscrire
                    </button>
                    <button type="button" class="btn btn-default btn-xl wow tada" data-toggle="modal" data-target="#myModal1">
                        Se connecter
                    </button>
                    <br>
                    <div>

                        <c:if test="${Err=='Erreur inscription'}">
                            <div class="alert alert-danger">
                                <strong>${Err}</strong> Erreur d'enregistrement
                            </div>
                        </c:if>
                        <c:if test="${Err=='Erreur confirmation'}">
                            <div class="alert alert-danger">
                                <strong>${Err}</strong> Mot de passe different de la confirmation
                            </div>
                        </c:if>
                    </div>
                </div>
        </header>
        <jsp:include page="foot.jsp"/>
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Inscription</h4>
                    </div>
                    <div class="modal-body">
                        <form id="inscripClient" role="form" class="form-signin">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Telephone*</label>
                                    <div class="form-group">
                                        <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone"required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>E-mail*</label>
                                <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email"required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ligne1*</label>
                                        <input type="text" name="addrLigne1" id="ligne1" class="form-control input-sm" placeholder="rue"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>ligne2 (facultatif)</label>
                                        <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="compléments">
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>code postal*</label>
                                        <input type="text" name="codePostal" id="codepostal" class="form-control input-sm" placeholder="code postal"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ville*</label>
                                        <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville"required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Mot de passe*(8 caractères min)</label>
                                        <input type="password" name="motDePasse" id="password" class="form-control input-sm" placeholder="mot de passe" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Confirmation*</label>
                                        <input type="password" name="confirmation" id="password_confirmation" class="form-control input-sm" placeholder="confirmation" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <input type="checkbox" id="human" name="human" required>
                                        <label for="human">j'accepte<a href="#"> les conditions</a>...</label>
                                    </div>
                                </div>
                            </div>
                            <button class="btn btn-lg btn-primary btn-block" type="submit">S'inscrire</button>
                            <p id ="infoins" class="text-success"></p>
                            <p id ="errorins" class="text-danger"></p>
                        </form>
                    </div>
                    <div class="modal-footer">
                        <button type="button" class="btn btn-default" data-dismiss="modal">Annuler</button>
                    </div>
                </div>
            </div>
        </div>
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Connectez vous à votre compte</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">
                            <form id="connectClient" role="form" class="form-signin">
                                <label>Email*</label>
                                <input type="email" id="inputEmail" name="inputEmail" class="form-control" placeholder="E-mail" required autofocus>
                                <br>
                                <label>Mot de passe*</label>
                                <input type="password" id="inputPassword" name="inputPassword" class="form-control" placeholder="Mot de passe" required>
                                <br><a href="#">Mot de passe oublié ?</a><br>
                                <button class="btn btn-lg btn-primary btn-block" type="submit">Se connecter</button>
                            </form>
                            <br>
                            <p id ="info" class="text-success"></p>
                            <p id ="error" class="text-danger"></p>
                            <br><br>
                        </div>
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

        <!--App JavaScript-->
        <script src="<c:url value="/resources/app/accueil.js"/>"></script>

    </body>

</html>
