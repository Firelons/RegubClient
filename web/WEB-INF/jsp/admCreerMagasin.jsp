<%-- 
    Document   : admCreerMagasin
    Created on : 6 janv. 2016, 12:45:04
    Author     : batchanou
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Création de Magasin</title>
        
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
                    <h2 class="section-heading"> Ajouter un Magasin</h2>
                    <hr class="primary">
                </div>
            </div>
        </div>
       <div class="modal-dialog col-md-12" role="document">
            <div class="modal-content">
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel"> AJOUT</h4>
                </div>
                <div class="modal-body">  
                    <form id="modifierClient" role="form">
                        <div class="row">
                            <div class="col-xs-6 col-sm-6 col-md-9">
                                <div class="form-group">
                                    <label>Nom*:</label>
                                    <input type="text" name="societe" id="nom" class="form-control input-sm" placeholder="nom" value=""required>
                                </div>
                            </div>
                        </div>
                        <div class="row">            
                            <div class="col-xs-6 col-sm-6 col-md-9">
                                <label>Rue*:</label>
                                <div class="form-group">
                                    <input type="text" name="telephone" id="telephone" class="form-control input-sm" placeholder="telephone" value="" required>
                                </div>
                            </div>
                        </div>
                        <div class="row">            
                            <div class="col-xs-6 col-sm-6 col-md-9">
                                <label>Complément:</label>
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
