<%-- 
    Document   : compteUtilisateur
    Created on : 24 nov. 2015, 22:31:59
    Author     : raghda
--%>



<%@page import="java.util.ArrayList"%>
<%@page import="entities.Compte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Liste des Comptes</title>

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
           <section class="bg-primary">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading">Adminitrateur<%--${UserConnected.getSociete()}--%></h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1 class="section-heading"> Type des Rayons</h1>
                    <hr class="primary">
                </div>
            </div>
        </div>
         <div class="container" >
                <div class="row">
                    <div class="col-lg-12">
                        <td><a href="#" class="btn btn-primary" data-toggle="modal" data-target="#myModalAjouter">
                                <c:out value=""></c:out>Ajouter</a>
                            </td>
                        </div>
                    </div>
                </div>
              <div class="container">
              <div class="table-responsive">                
              <table class="table">
                            <thead>
                                <tr>
                                    <th>Nom du rayon</th><th>Modifier</th><th>Supprimer</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="R" items="${rayon}">
                                <tr>
                                    <td>
                                        <c:out value="${R.getLibelle()}"></c:out>
                                        </td>
                                        <td>
                                            <form id="modifbutton" role="form" >
                                                <input type="hidden" id="id" name="id" value="${cli.getIdClient()}" class="form-control"/>
                                                <button class="btn btn-info" type="submit">modifier</button>
                                            </form>
                                        </td>
                                        <td><a href="/RegubClient/regub/commercial/${cli.getIdClient()}" class="btn btn-primary">
                                            <c:out value=""></c:out>Supprimer</a>
                                        </td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>
            </div>
        </div>  
    
   
        <jsp:include page="foot.jsp" />   
        <!-- Modal Ajouter -->
        <div class="modal fade" id="myModalAjouter" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Ajouter type rayon</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">
                            <form id="connectClient" role="form" class="form-signin" method="post" action="/regub/administrateur/ajoutrayon">
                                <label>Nom type rayon</label>
                                <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom type rayon" value=""required>
                                <br>
                                
                                <button class="btn btn-lg btn-primary btn-block" type="submit">Ajouter</button>
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
        
        
    </body>
</html>
