<%-- 
    Document   : modifierUtil
    Created on : 5 janv. 2016, 14:12:02
    Author     : projet
--%>

<%@page import="entities.Compte"%>
<%@page import="entities.Typecompte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<% Compte tcpt = (Compte) session.getAttribute("compteConnected");
    if (tcpt == null ) { %>
<c:redirect url="/regub"/>
<% }%>

<html lang="fr" >
    <head>
        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">
        <title>Modifier Client</title>
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
        <!--App JavaScript-->
        <script src="<c:url value="/resources/app/commercial.js"/>"></script>

    </head>

    <body  id="page-top">
        <jsp:include page="navCommercial.jsp" />
        <section class="bg-primary">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading"> ${CommercialConnected.getNom()}</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Modifier</h4>
                </div>
                <div class="modal-body">  
                    <form action="/RegubClient/regub/commercial/commodifcli" method="POST" role="form">
                        <input type="hidden" name="idClient" value="${cli.getIdClient()}">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>Nom</label>
                                    <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom" value="${cli.getSociete()}"required>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <label>Telephone</label>
                                <div class="form-group">
                                    <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone" value="${cli.getTelephone()}" required>
                                </div>
                            </div>
                        </div>

                        <div class="form-group">
                            <label>Email</label>
                            <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email" value="${cli.getEmail()}" required>
                        </div>
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>rue</label>
                                    <input type="text" name="addrLigne1" id="ligne1" class="form-control input-sm" placeholder="rue" value="${cli.getAddrLigne1() }" required>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>compléments</label>
                                    <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="compléments" value="${cli.getAddrLigne2()}">
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>code postal</label>
                                    <input type="text" name="codePostal" id="codepostal" class="form-control input-sm" placeholder="code postal" value="${cli.getCodePostal()}" required>
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>Ville</label>
                                    <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="${cli.getVille()}" required>
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
        <jsp:include page="foot.jsp" />
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
        <script src="<c:url value="/resources/app/commercial.js"/>"></script>

    </body>
</html>
