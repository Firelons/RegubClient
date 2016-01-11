<%-- 
    Document   : client
    Created on : 9 nov. 2015, 13:50:37
    Author     : Mesmerus
--%>

<%@page import="entities.ClientConnecte"%>
<%@page import="entities.Client"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<c:if test="${UserConnected==null}">
    <c:redirect url="accueil"/>
</c:if>

<!DOCTYPE html>
<html lang="fr">
    <head>

        <meta charset="utf-8">
        <meta http-equiv="X-UA-Compatible" content="IE=edge">
        <meta name="viewport" content="width=device-width, initial-scale=1">
        <meta name="description" content="">
        <meta name="author" content="">

        <title>Bienvenue ${UserConnected.getSociete()} | RegubClient</title>

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
        <jsp:include page="navClient.jsp" />
        <section class="bg-primary">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading">Bienvenue ${UserConnected.getSociete()}</h2>
                        <hr class="light">
                    </div>
                </div>
            </div>
        </section>

        <section>
            <div class="container">
                <div class="row">
                    <div class="col-lg-12 text-center">
                        <h2 class="section-heading"> Liste des Contrats</h2>
                        <hr class="primary">
                    </div>
                </div>
            </div>
            <div class="container">
                <div class="table-responsive">  
                    <a href="ajoutercontrat" class="btn btn-info"  >Ajouter</a>             
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Statut(Contrat)</th><th>Titre de la vidéo</th><th>Durée</th><th>Date de debut</th><th>Date de fin</th><th>Devis</th><th>Facture</th><th>Modifier</th>
                            </tr>
                        </thead>
                        <tbody>
                            <c:forEach var="vid" items="${video}">
                                <tr>
                                    <td>
                                        <c:if test="${vid.getStatut()==1}">
                                            <c:out value="Validé">
                                            </c:out>
                                        </c:if>
                                        <c:if test="${vid.getStatut()==2}">
                                            <c:out value="En preparation">
                                            </c:out>
                                        </c:if>
                                        <c:if test="${vid.getStatut()==3}">
                                            <c:out value="Annulé">
                                            </c:out>
                                        </c:if>
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
                                            <form method="post" action="devis">
                                                    <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                 <button type="submit" <c:if test="${ vid.getTarif()==0}">disabled</c:if> class="btn btn-info">Voir</button>
                                                </form>
                                           
                                        </td>
                                        <td>
                                            <form method="post" action="facture">
                                                    <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                <button type="submit"  <c:if test="${now lt vid.getDateFin()}">disabled</c:if> class="btn btn-primary">Voir</button>
                                                </form>                                          
                                            
                                        </td>
                                        
                                        <td>
                                                <form method="post" action="modifiercontrat">
                                                    <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                <button type="submit"  class="btn btn-info">Modifier</button>
                                                </form>                                          

                                        </td>
                                        <td>
                                            <form method="post" action="annuler">
                                                    <input type="hidden" id="id" name="idvideo" value="${vid.getIdVideo()}" class="form-control"/>
                                                <button type="submit"  class="btn btn-primary" <c:if test="${now gt vid.getDateFin()}">disabled</c:if>>Annuler</button>
                                                </form> 
                                        
                                    </td>
                                    </tr>
                            </c:forEach>
                        </tbody>
                    </table>
                </div>
            </div>
        </section>
        <jsp:include page="foot.jsp" />
        <!-- Modal -->
        <div class="modal fade" id="myModal" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Paramètres</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form" id="modifClient">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom" value="${UserConnected.getSociete()} "required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Telephone*</label>
                                    <div class="form-group">
                                        <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone"value="${UserConnected.getTelephone()}" required>
                                    </div>
                                </div>
                            </div>

                            <div class="form-group">
                                <label>E-mail*</label>
                                <input type="email" name="email" id="email" class="form-control input-sm" placeholder="email" value="${UserConnected.getEmail()}" required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ligne1*</label>
                                        <input type="text" name="addrLigne1" id="ligne1" class="form-control input-sm" placeholder="rue"value="${UserConnected.getAddrLigne1()}" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>ligne2 (facultatif)</label>
                                        <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="compléments" value="${UserConnected.getAddrLigne2()}">
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>code postal*</label>
                                        <input type="text" name="codePostal" id="codepostal" class="form-control input-sm" placeholder="code postal" value="${UserConnected.getCodePostal()}" required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ville*</label>
                                        <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="${UserConnected.getVille()}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ancien mot de passe</label>
                                        <input type="password" name="oldpassword" id="oldpassword" class="form-control input-sm" placeholder="Ancien mot de passe" value="***********" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Mot de passe*(8 caractères min)</label>
                                        <input type="password" name="motDePasse" id="newpassword" class="form-control input-sm" placeholder="Nouveau mot de passe" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Confirmation*</label>
                                        <input type="password" name="password_confirmation" id="password_confirmation" class="form-control input-sm" placeholder="confirmation" required Autofocus>
                                    </div>
                                    <p id ="infomod" class="text-success"></p>
                                    <p id ="errormod" class="text-danger"></p>
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
        <div class="modal fade" id="myModalAjouter" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Ajouter un Contrat</h4>
                    </div>
                    <div class="modal-body">
                        <form role="form">

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
        <script src="<c:url value="/resources/app/client.js"/>"></script>

    </body>

</html>
