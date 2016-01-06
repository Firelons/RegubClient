<%-- 
    Document   : admCreerUtilisateur
    Created on : 28 nov. 2015, 21:29:18
    Author     : batchanou
--%>

<%@page import="entities.Typecompte"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Compte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html lang="fr">
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Création de Compte</title>

        <!-- Bootstrap Core CSS -->

        <link rel="stylesheet" href="<c:url value="/resources/css/bootstrap.min.css"/>" type="text/css">

        <!-- Custom Fonts -->
        <link href='http://fonts.googleapis.com/css?family=Open+Sans:300italic,400italic,600italic,700italic,800italic,400,300,600,700,800' rel='stylesheet' type='text/css'>
        <link href='http://fonts.googleapis.com/css?family=Merriweather:400,300,300italic,400italic,700,700italic,900,900italic' rel='stylesheet' type='text/css'>
        <link rel="stylesheet" href="<c:url value="/resources/font-awesome/css/font-awesome.min.css"/>" type="text/css">

        <!-- Plugin CSS -->
        <link rel="stylesheet" href="<c:url value= "/resources/css/animate.min.css"/>" type="text/css">

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
                        <h2 class="section-heading">Adminitrateur ${compteConnected.getNom()}</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading">Ajouter un compte d'utilisateur</h2>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                <br><br><br>
                <form action="CreationUser" method="post">
                    <label>Nom :
                    <input type="text" name="Nom" value=""/>
                    </label><br><br>
                    <label>Prenom :
                    <input type="text" name="Prenom" value=""/>
                    </label><br><br>
                    <label>Login :
                    <input type="text" name="Login" value=""/>
                    </label><br><br>
                    <label>Mot de passe :
                    <input type="password" name="Motdepasse" value=""/>
                    </label><br><br>
                   
                    <label>Type de Compte :</label>
                    <select name="Compte">
                        <option value=" "> </option>
                        <% %>
                    <option value= "1">Administrateur </option>
                    <option value= "2">Commercial </option>
                    <option value= "3">Gestionnaire</option>
                   
                    </select><br><br><br>

                    <input type="submit" name="valider" value="Valider" class="btn btn-primary"/>
                    <a href="/RegubClient/AnnuleCreationUser" class="btn btn-primary">Annuler</a>
                </form> <br><br>    
            </div>
        </div>  
        <footer>
            <jsp:include page="foot.jsp" />   
        </footer>
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
        <script src="<c:url value="/resources/app/client.js"/>"></script>
    </body>
</html>
