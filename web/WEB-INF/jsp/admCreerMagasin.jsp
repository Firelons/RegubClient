<%-- 
    Document   : admCreerMagasin
    Created on : 6 janv. 2016, 12:45:04
    Author     : batchanou
--%>

<%@page import="entities.Compte"%>
<%@page import="entities.Typerayon"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Region"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>

<%@taglib uri="http://www.springframework.org/tags/form" prefix="form" %>
<%@taglib prefix="c" uri="http://java.sun.com/jsp/jstl/core"%>
<%
    Compte tcpt = (Compte)session.getAttribute("compteConnected");
    if(tcpt==null){ %>
    <c:redirect url="/regub"/>
    <% }else if(tcpt.getTypecompte().getIdTypeCompte()!=1){ %>
    <c:redirect url="/regub"/>
    }%>

<% }%>
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
        </div> <!-- Modal ajout -->
        <div class="modal-dialog" role="document">
            <div class="modal-content" >
                <div class="modal-header">
                    <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                    <h4 class="modal-title" id="myModalLabel">AJOUT</h4>
                </div>
                <div class="panel-body col-lg-12">  
                    <form action="CreationMagasin" method="POST" role="form">
                        <div class="">
                        <div class="col-xs-6 col-sm-6 col-md-6">
                            <div class="form-group ">
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                        <div class="form-group">
                                            <label>Nom*:</label>
                                            <input type="text" name="nom" id="nom" class="form-control input-sm" placeholder="nom" value=""required>
                                        </div>
                                    </div>
                                </div>
                                <div class="row">            
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                        <label>Rue*:</label>
                                        <div class="form-group">
                                            <input type="text" name="addrLigne1" id="telephone" class="form-control input-sm" placeholder="rue" value="" required>
                                        </div>
                                    </div>
                                </div>

                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                        <div class="form-group">
                                            <label>Complément:</label>
                                            <input type="text" name="addrLigne2" id="ligne2" class="form-control input-sm" placeholder="facultatif" value="" required>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-6 col-md-6">
                                        <div class="form-group">
                                            <label>code postal*:</label>
                                            <input type="text" name="codepostal" id="codepostal" class="form-control input-sm" placeholder="code postal" value="" required>
                                        </div>
                                    </div>
                                    <div class="col-xs-6 col-sm-6 col-md-6">
                                        <div class="form-group">
                                            <label>Ville*:</label>
                                            <input type="text" name="ville" id="ville" class="form-control input-sm" placeholder="ville" value="" required>
                                        </div>
                                    </div>

                                </div>
                                <div class="row">
                                    <div class="col-xs-12 col-sm-12 col-md-12">
                                        <div class="form-group">
                                            <label>Région*:</label>
                                            <select id="region" class="form-control input-sm" name="Region" placeholder="region" value="" required>
                                                <option value="" hidden selected>--------------</option>
                                                <%
                                                    ArrayList<Region> list = new ArrayList();
                                                    list = (ArrayList<Region>) request.getAttribute("regionlist");  
                                                    for(int i=0; i<list.size();i++){
                                                %>

                                                <option value="<%=list.get(i).getIdRegion() %>"><%= list.get(i).getLibelle() %></option>
                                                <% } %>
                                            </select> <br>
                                        </div>
                                    </div>
                                </div>
                                
                                </div>
                            </div>
                            <div class="col-xs-6 col-sm-6 col-md-6">
                                        <div class="form-group">
                                            <label>Type Rayon</label>
                                            <select id="typereyon" class="form-control input-sm" name="typerayon" size="18" multiple required  >
                                                
                                                <%
                                                    ArrayList<Typerayon> rayon = new ArrayList<Typerayon>();
                                                    rayon = (ArrayList<Typerayon>) request.getAttribute("trayonlist");  
                                                    for(int i=0; i<rayon.size();i++){
                                                %>

                                                <option value="<%=rayon.get(i).getLibelle() %>"><%= rayon.get(i).getLibelle() %></option>
                                                <% } %>
                                            </select>
                                            
                                        </div>
                            </div> 
                            </div> <br>
                                <div class=" col-xs-12 col-sm-12 col-md-12  text-center">
                                    <input type="submit" value="Enregistrer" class="btn btn-info btn-primary col-md-8" >
                                </div>
                    </form>
                
                </div>
                <div class="modal-footer">
                    <a  href="AnnuleMagasin" class="btn btn-default" data-dismiss="modal">Annuler</a>
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
