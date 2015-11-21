<%-- 
    Document   : inscripClient
    Created on : 18 nov. 2015, 09:58:19
    Author     : Mesmerus
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

        <title>Bienvenue [Client] | Regub</title>

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
        <jsp:include page="navAccueil.jsp" />
        <section class="bg-primary">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading">Votre compte  ${cli.getSociete()} a bien été crée !</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <section id="services">
            <div class="container">
                <div class="row">
                    <div class="col-lg-6  text-center">
                        <div class="service-box">
                            <i class="fa fa-4x fa-paper-plane wow bounceIn text-primary" data-wow-delay=".1s"></i>
                            <h3>Un mail a été envoyé à votre adresse</h3>
                            <hr class="primary">
                            <p class="text-muted">Veuillez confirmer votre compte en allant dans votre adresse mail : <a href="#">${cli.getEmail()}</a> </p>
                        </div>
                    </div>
                    <div class="col-md-6 text-center">
                        <div class="service-box">
                            <i class="fa fa-4x fa-newspaper-o wow bounceIn text-primary" data-wow-delay=".2s"></i>
                            <h3>Les informations suivantes ont été enrégistrées</h3>
                            <hr class="primary">
                            <h3 class="text-muted">
                                Société :   <b> ${cli.getSociete()}</b><br/> 
                                Telephone:  <b>  ${cli.getTelephone()}</b><br/> 
                                Email:  <b>  ${cli.getEmail()}</b><br/>
                                Adresse:    <b>    ${cli.getAddrLigne1()} ${cli.getAddrLigne2()}</b><br/> 
                                Ville:  <b>  ${cli.getVille()}</b><br/>
                                Code Postal:    <b>    ${cli.getCodePostal()}</b><br/>
                            </h3>
                        </div>
                    </div>
                </div>
            </div>
        </section>             

        <p></p>
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

    </body>

</html>
