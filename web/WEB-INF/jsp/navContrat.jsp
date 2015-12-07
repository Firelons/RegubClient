<%-- 
    Document   : navContrat
    Created on : 4 déc. 2015, 18:16:59
    Author     : TOUANI Serge
--%>

<nav id="mainNav" class="navbar-fixed-top">
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
                            <a class="page-scroll" href="logout">Deconnexion</a>
                        </li>
                    </ul>
                </div>
                <!-- /.navbar-collapse -->
            </div>
            <!-- /.container-fluid -->
        </nav>
