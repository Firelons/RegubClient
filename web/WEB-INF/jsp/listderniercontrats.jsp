<%-- 
    Document   : listderniercontrats
    Created on : 12 janv. 2016, 16:43:31
    Author     : projet
--%>

<%@page import="entities.Compte"%>
<%@page import="entities.Client"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>

<!DOCTYPE html>
<% Compte tcpt = (Compte) session.getAttribute("compteConnected");
    if (tcpt == null) { %>
<c:redirect url="/regub"/>
<% }%>
<html lang="fr">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Bienvenue ${CommercialConnected.getNom()} | Regub</title>

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
        <jsp:include page="navCommercial.jsp" />
        <section class="bg-primary">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading">Bienvenue ${CommercialConnected.getNom()}</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2 class="section-heading"> Liste des Contrats terminé </h2>
                        <hr class="primary">
                    </div>
                </div>
            </div>

            <div class="container">
                <div class="table-responsive">          
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Clients</th><th>Titre de la vidéo</th><th>Durée</th><th>Date de debut</th><th>Date de fin</th><th>Tarif</th><th>Devis</th><th>Facture</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vid" items="${derniercontrats}">

                                <tr>
                                    <td>
                                        <c:out value="${vid.getClient().getSociete()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${vid.getTitre()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${vid.getDuree()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${vid.getDateDebut()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${vid.getDateFin()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${vid.getTarif()}"></c:out>
                                        </td>
                                        <td>
                                            <form method="post" action="deviscom">
                                                <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                <input type="hidden" id="id" name="clicom" value="${vid.getClient()}" class="form-control"/>
                                                <button type="submit"  class="btn btn-info">Voir</button>
                                            </form>

                                        </td>
                                        <td>
                                            <form method="post" action="facturecom">
                                                <input type="hidden" id="id" name="clicom" value="${vid.getClient()}" class="form-control"/>
                                                <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                <button type="submit"   class="btn btn-primary">Voir</button>
                                            </form>                                          

                                        </td>
                                    <td>

                                    </td>

                                </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>

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
