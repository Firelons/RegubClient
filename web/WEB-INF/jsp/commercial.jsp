<%-- 
    Document   : newjsp
    Created on : 20 nov. 2015, 15:54:42
    Author     : loïc
--%>

<%@page import="entities.Compte"%>
<%@page import="entities.Typecompte"%>
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
        <!--App JavaScript-->
        <script src="<c:url value="/resources/app/commercial.js"/>"></script>


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
                        <h2 class="section-heading"> Liste des Clients</h2>
                        <hr class="primary">
                    </div>
                </div>
            </div>
            <div class="container" >
                <div class="row">
                    <div class="col-lg-12">
                        <td><a href="#" class="btn btn-primary" data-toggle="modal" data-target="#myModalAjouter">
                                <c:out value=""></c:out>Ajouter</a>
                                <button onclick="test()" id="modifbuton" class="btn btn-primary">
                                <c:out value=""></c:out>Json</button>
                            </td>
                        </div>
                    </div>
                </div>
                <div class="container">
                    <div class="table-responsive">          
                        <table class="table">
                            <thead>
                                <tr>
                                    <th>Nom</th><th>Adresse</th>
                                </tr>
                            </thead>
                            <tbody>
                            <c:forEach var="cli" items="${client}">
                                <tr>
                                    <td>
                                        <c:out value="${cli.getSociete()}"></c:out>
                                        </td>
                                        <td>
                                        <c:out value="${cli.getAddrLigne1()}"></c:out>
                                        </td>
                                        <td><a href="/RegubClient/regub/commercial/contrats/${cli.getIdClient()}" class="btn btn-info"x>
                                            <c:out value=""></c:out>Contrats</a>
                                        </td> 
                                        <td>
                                            <form id="modifbutton" role="form" >
                                                <input type="hidden" id="id" name="id" value="${cli.getIdClient()}" class="form-control"/>
                                            <button class="btn btn-primary" type="submit">modifier</button>
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
                        <form id="azert" role="form" method="post" action="/RegubClient/regub/commercial/ajoutclient">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom" value=""required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Telephone*</label>
                                    <div class="form-group">
                                        <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone" value="" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>E-mail*</label>
                                <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email" value="" required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ligne1*</label>
                                        <input type="text" name="addrLigne1" id="ligne1" class="form-control input-sm" placeholder="rue" value="" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>ligne2 (facultatif)</label>
                                        <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="compléments" value="">
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>code postal*</label>
                                        <input type="text" name="codePostal" id="codepostal" class="form-control input-sm" placeholder="code postal" value="" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ville*</label>
                                        <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="" required>
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
        
        <!-- Modal Modifier -->
        <div class="modal fade" id="myModalModifier" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Modifier</h4>
                    </div>
                    <div class="modal-body">  
                        <form id="modifierClient" role="form">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom" value=""required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Telephone*</label>
                                    <div class="form-group">
                                        <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone" value="" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>E-mail*</label>
                                <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email" value="" required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ligne1*</label>
                                        <input type="text" name="addrLigne1" id="ligne1" class="form-control input-sm" placeholder="rue" value="" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>ligne2 (facultatif)</label>
                                        <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="compléments" value="">
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>code postal*</label>
                                        <input type="text" name="codePostal" id="codepostal" class="form-control input-sm" placeholder="code postal" value="" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ville*</label>
                                        <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="" required>
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
