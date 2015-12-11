<%-- 
    Document   : creerUtilisateur
    Created on : 28 nov. 2015, 21:29:18
    Author     : batchanou
--%>

<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Création Compte</title>
        
        
    </head>
     <body> 
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1 class="section-heading">Création utilisateur</h1>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                 
                <form action="user" method="post">
                    <!-- 1ere facon de faire le tableau -->
                    <table class="table">
                        <thead>
                            <tr>
                                <th>Nom</th><th>Prénom</th><th>Type de Compte</th><th>Login</th><th>Modifier</th><th>Supprimer</th>
                            </tr>
                        </thead>
                        <tbody>
                           
                        </tbody>
                    </table>
                </form>
            </div>
        </div>  
    </body>
</html>
