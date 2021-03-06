<%-- 
    Document   : admCompteUtilisateur
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
                        <h2 class="section-heading">Adminitrateur ${compteConnected.getNom()}</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading"> Compte Uilisateurs</h2>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                 
                <a href="ajoutCompte" class="btn btn-info"><strong>Ajouter</a>
                
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
                                <td><a href="ModifCompte<%=list.get(j).getIdCompte()%>" class="btn btn-primary" >Modifier</a></td>
                                <td><a  href="/RegubClient/SuppCompte<%=list.get(j).getIdCompte()%>" class="btn btn-primary" >Supprimer</a></td>
                            </tr>
                            <%
                                }
                            %>
                        </tbody>
                    </table>
                <br><br><br><br>
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
        <script src="<c:url value="/resources/app/client.js"/>"></script>
    </body>
</html>
