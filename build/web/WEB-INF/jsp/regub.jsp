<%-- 
    Document   : regubGest
    Created on : 9 nov. 2015, 13:50:37
    Author     : Mesmerus
--%>

<%@page import="entities.Typecompte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<%
    Typecompte tcpt = (Typecompte)session.getAttribute("compteConnected");
    if(tcpt!=null){
    if (tcpt.getIdTypeCompte()== 1 ) { %>
    <c:redirect url="/admin"/>
    <% }%>
<%
    if (tcpt.getIdTypeCompte()== 2 ) { %>
<c:redirect url="/regub/commercial/"/>

<% }}%>

<!DOCTYPE html>
<html lang="fr">

    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Regub</title>

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

        <jsp:include page="navRegub.jsp" />

        <header>
            <div class="header-content ">
                <div class="header-content-inner">
                    <h1>REGUB</h1>
                    <hr>
                    <p>Bienvenue sur Regub</p>
                    <button type="button" class="btn btn-primary  btn-xl wow tada" data-toggle="modal" data-target="#myModal1">
                        Se connecter
                    </button>
                    <br>
                    <div>
                        <c:if test="${Err=='Erreur'}">
                            <div class="alert alert-danger">
                                <strong>${Err}</strong> login / mot de passe incorrect.
                            </div>
                        </c:if>
                    </div>
                </div>
        </header>
        <jsp:include page="foot.jsp" />
        <!-- Modal -->
        <div class="modal fade" id="myModal1" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Connectez vous à votre compte</h4>
                    </div>
                    <div class="modal-body">
                        <div class="modal-body">

                            <form class="form-signin"action="admconnect" method="POST">
                                <label>Login*</label>
                                <input type="login" id="login" name="login" class="form-control" placeholder="login" required autofocus>
                                <br>
                                <label>Mot de passe*</label>
                                <input type="password" id="inputPassword" name="password" class="form-control" placeholder="Mot de passe" required>
                                <br><a href="#">Mot de passe oublié ?</a><br>
                                <button class="btn btn-lg btn-block" type="submit">Se connecter</button>
                            </form>

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
