<%-- 
    Document   : admRegionUtilisateur
    Created on : 6 janv. 2016, 11:45:02
    Author     : Regub
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
        <title>Liste des Regions</title>

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
                        <h2 class="section-heading">Administrateur<%--${UserConnected.getSociete()}--%></h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h2 class="section-heading"> Liste des Regions</h2>
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
                                <th>Nom</th>
                            </tr>
                        </thead>
                        <tbody>
                        <c:forEach var="reg" items="${region}">
                            <tr>
                                <td>
                                    <c:out value="${reg.getLibelle() }"></c:out>
                                    </td>

                                    <td><a href="modifierregion-${reg.getIdRegion()}" class="btn btn-primary"x>
                                        <c:out value=""></c:out>Modifier</a>

                                    </td>
                                    <td><a href="supprimerregion-${reg.getIdRegion()}" class="btn btn-primary"x>
                                        <c:out value=""></c:out>Supprimer</a>

                                    </td>
                                </tr>
                        </c:forEach>
                    </tbody>
                </table>
            </div>
        </div>
    </section>
    <jsp:include page="foot.jsp" />

    <!-- Modal Ajouter -->
    <div class="modal fade" id="myModalAjouter" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
        <div class="modal-dialog" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">Ajouter</h4>
                </div>
                <div class="modal-body" >
                    <form id="azerti" role="form" method="post" action="ajoutregion">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                <div class="form-group">
                                    <label>Nom*</label>
                                    <input type="text" name="reg" id="nom" class="form-control input-sm" placeholder="nom" value=""required>
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
    <script src="<c:url value="/resources/app/commercial.js"/>"></script>

</body>
</html>
