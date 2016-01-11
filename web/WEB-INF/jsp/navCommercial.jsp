<%-- 
    Document   : navCommercial
    Created on : 18 nov. 2015, 10:08:01
    Author     : loïc
--%>

<%@page import="entities.Compte"%>
<% Compte tcpt = (Compte) session.getAttribute("compteConnected");
    if (tcpt == null) { %>
<c:redirect url="/regub"/>
<% }%>

<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">

            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">Regub</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand page-scroll" href="/RegubClient/regub/commercial">ACCUEIL</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <%--${UserConnected.getSociete()}--%>
                        </li>
                        <li>
                            <a href="#" class="page-scroll" data-toggle="modal" data-target="#myModalParametre">Parametres</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="/RegubClient/logout">Deconnexion</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
        <!-- Modal Paramètre -->
        <div class="modal fade" id="myModalParametre" tabindex="-1" role="dialog" aria-labelledby="myModalLabel">
            <div class="modal-dialog" role="document">
                <div class="modal-content">
                    <div class="modal-header">
                        <button type="button" class="close" data-dismiss="modal" aria-label="Close"><span aria-hidden="true">&times;</span></button>
                        <h4 class="modal-title" id="myModalLabel">Paramètre</h4>
                    </div>
                    <div class="modal-body">
                        <form id="paramCommercial" role="form" method="post">
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Nom*</label>
                                        <input type="text" name="nom" id="nom" class="form-control input-sm" placeholder="nom" value="${CommercialConnected.getNom()} "required>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <label>Prenom*</label>
                                    <div class="form-group">
                                        <input type="text" name="prenom" id="prenom" class="form-control input-sm" placeholder="prenom"value="${CommercialConnected.getPrenom()}" required>
                                    </div>
                                </div>
                            </div>
                            <div class="form-group">
                                <label>Login*</label>
                                <input type="login" name="login" id="login" class="form-control input-sm" placeholder="login" value="${CommercialConnected.getLogin()}" required>
                            </div>
                            <div class="row">
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Ancien mot de passe</label>
                                        <input type="password" name="oldpassword" id="oldpassword" class="form-control input-sm" placeholder="Ancien mot de passe" required Autofocus>
                                    </div>
                                </div>
                                <div class="col-xs-6 col-sm-6 col-md-6">
                                    <div class="form-group">
                                        <label>Mot de passe*</label>
                                        <input type="password" name="password" id="newpassword" class="form-control input-sm" placeholder="Nouveau mot de passe" required Autofocus>
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
