<%-- 
    Document   : navClient
    Created on : 17 nov. 2015, 12:04:18
    Author     : Mesmerus
--%>

<c:if test="${UserConnected==null}">
    <c:redirect url="accueil"/>
</c:if>

<nav id="mainNav" class="navbar navbar-default navbar-fixed-top">

            <div class="container-fluid">
                <!-- Brand and toggle get grouped for better mobile display -->
                <div class="navbar-header">
                    <button type="button" class="navbar-toggle collapsed" data-toggle="collapse" data-target="#bs-example-navbar-collapse-1">
                        <span class="sr-only">RegubClient</span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                        <span class="icon-bar"></span>
                    </button>
                    <a class="navbar-brand page-scroll" href="#page-top">REGUBClient</a>
                </div>

                <!-- Collect the nav links, forms, and other content for toggling -->
                <div class="collapse navbar-collapse" id="bs-example-navbar-collapse-1">
                    <ul class="nav navbar-nav navbar-right">
                        <li>
                            <a class="page-scroll" href="#applimobile">Application Mobile</a>
                        </li>
                        <li>
                            <a class="page-scroll" href="#contact">Contact</a>
                        </li>
                        <li>
                            <a href="#" class="btn btn-primary" data-toggle="modal" data-target="#myModal" >Paramètres</a>
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
