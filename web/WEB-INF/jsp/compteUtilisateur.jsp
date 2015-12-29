<%-- 
    Document   : compteUtilisateur
    Created on : 24 nov. 2015, 22:31:59
    Author     : batchanou
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
        <title>Création des Comptes</title>

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
                    <h1 class="section-heading"> Compte Uilisateurs</h1>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                 
                <a class="btn btn-info" href="Ajoutuser"><strong>Ajouter</a></button>
                <form action="user" method="post">
                    <!-- 1ere facon de faire le tableau -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th><th>Prénom</th><th>Type de Compte</th><th>Login</th><th>Modifier</th><th>Supprimer</th>
                            </tr>
                        </thead>
                        <tbody>
                            <%
                                ArrayList<Compte> list = new ArrayList<Compte>();

                                list = (ArrayList<Compte>) request.getAttribute("compte");
                                int j = 0;
                                for (j = 0; j < list.size(); j++) {
                            %>
                            <tr>
                                <td><%=list.get(j).getNom()%></td>
                                <td><%=list.get(j).getPrenom()%></td>
                                <td><%=list.get(j).getTypecompte().getLibelle()%></td>
                                <td><%=list.get(j).getLogin()%></td>
                                <td><a href="#" class="btn btn-primary">Voir</a></td>
                                <td><a href="#" class="btn btn-primary">Suppr</a></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                </form>
            </div>
        </div>  
    
    <footer>
        <jsp:include page="foot.jsp" />   
    </footer>
    </body>
</html>
