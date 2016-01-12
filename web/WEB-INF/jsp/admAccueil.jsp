<%-- 
    Document   : admAccueil
    Created on : 18 nov. 2015, 10:05:14
    Author     : batchanou
--%>

<%@page import="entities.Compte"%>
<%@page import="entities.Typecompte"%>
<%@page import="entities.Entreprise"%>
<%@page import="model.dao.EntrepriseDAO"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Compte tcpt = (Compte) session.getAttribute("compteConnected");
    if (tcpt == null) { %>
<c:redirect url="/regub"/>
<% } else if (tcpt.getTypecompte().getIdTypeCompte() != 1) { %>
<c:redirect url="/regub"/>
}%>

<% }%>

<%
    Entreprise ent = EntrepriseDAO.getEnt(1);
    // System.out.println(ent.getNom());
%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Accueil</title>
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
    <body>
        <jsp:include page="navAdministrateur.jsp"/>

        <header>
            <div class="header-content">
                <div class="header-content-inner">
                    <h1>REGUB Accueil</h1><br/>

                    <a href="user" class="btn btn-lg btn-primary car "><strong>Gestion des Comptes</strong></a><br/><br/>

                    <a href="region" class="btn btn-lg btn-primary  car"><strong>Gestion de Régions</strong></a><br/><br/>

                    <a href="magasin" class="btn btn-lg btn-primary car"><strong>Gestion de Magasins</strong></a><br/><br/>

                    <a href="rayon" class="btn btn-lg btn-primary car"><strong>Gestion de Type Rayons</strong></a><br/><br/>

                    <a href="#" class="btn btn-lg btn-primary car" data-toggle="modal" data-target="#myModalEntreprise"><strong>Entreprises</strong></a>


                </div>
            </div>
        </header>
        <!-- Modal Enregistrer entreprise -->
        <div class="modal fade" id="myModalEntreprise" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Entrerprise</h4>
                    </div>
                    <div class="modal-body" >
                        <form id="entreprise" role="form">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="nom" id="nom" class="form-control input-sm" placeholder="nom" value="<%= ent.getNom()%>"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Adresse*</label>
                                        <input type="text" name="adresse" id="adresse" class="form-control input-sm" placeholder="adresse" value="<%= ent.getAdresse()%>"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Code*</label>
                                        <input type="text" name="code" id="codepostal" class="form-control input-sm" placeholder="code postale" value="<%= ent.getCode()%>"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ville*</label>
                                        <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="<%= ent.getVille()%>"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Telephone*</label>
                                        <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone" value="<%= ent.getTelephone()%>"required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>E-mail*</label>
                                        <input type="email" name="mail" id="mail" class="form-control input-sm" placeholder="mail" value="<%= ent.getMail()%>" required>
                                    </div>
                                </div>

                            </div>
                            <p id ="infomod" class="text-success"></p>
                            <p id ="errormod" class="text-danger"></p>
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

        <!--App JavaScript-->
        <script src="<c:url value="/resources/app/administrateur.js"/>"></script>
    </body>
</html>
