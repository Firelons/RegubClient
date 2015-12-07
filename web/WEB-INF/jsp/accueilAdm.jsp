<%-- 
    Document   : accueil
    Created on : 18 nov. 2015, 10:05:14
    Author     : batchanou
--%>

<%@page import="entities.Typecompte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Typecompte tcpt = (Typecompte)session.getAttribute("compteConnected");
    if(tcpt==null){ %>
    <c:redirect url="/regub"/>
    <% }else if(tcpt.getIdTypeCompte()!=1){ %>
    <c:redirect url="/regub"/>
    }%>

<% }%>
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
        
                    <form class="form" action="user" method="get">    
                        <a><button class="btn btn-lg btn-primary car " type="submit"><strong>Gestion des comptes</strong></button><br/><br/></a>
                    </form>
                    <form class="form-signin" action="region" method="get">
                        <button class="btn btn-lg btn-primary  car" type="submit"><strong>Gestion des régions</strong></button><br/><br/>
                    </form>
                    <form class="form-signin" action="magasin" method="get">
                        <button class="btn btn-lg btn-primary car" type="submit"><strong>Gestion des magasins</strong></button><br/><br/>
                    </form>
                    <form class="form-signin" action="" method="get">
                        <button class="btn btn-lg btn-primary car" type="submit"><strong>Gestion des types de rayons</strong></button>
                    </form>
                </div>
            </div>
         </header>
    </body>
</html>
