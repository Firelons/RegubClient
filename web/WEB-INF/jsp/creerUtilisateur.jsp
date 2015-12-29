<%-- 
    Document   : creerUtilisateur
    Created on : 28 nov. 2015, 21:29:18
    Author     : batchanou
--%>

<%@page import="entities.Typecompte"%>
<%@page import="java.util.ArrayList"%>
<%@page import="entities.Compte"%>
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
                    <h1 class="section-heading">Ajouter un compte d'utilisateur</h1>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                <br><br><br>
                <form action="CreationUser" method="post">
                    <label>Nom :
                    <input type="text" name="Nom" value=""/>
                    </label><br><br><br>
                    <label>Prenom :
                    <input type="text" name="Prenom" value=""/>
                    </label><br><br><br>
                    <label>Login :
                    <input type="text" name="Login" value=""/>
                    </label><br><br><br>
                    <label>Mot de passe :
                    <input type="password" name="Motdepasse" value=""/>
                    </label><br><br><br>
                   
                    <label>Type de Compte :</label>
                    <select name="Compte">
                        <option value=" "> </option>
                        <% %>
                    <option value= "1">Administrateur </option>
                    <option value= "2">Commercial </option>
                    <option value= "3">Gestionnaire</option>
                   
                    </select><br><br><br>

                    <input type="submit" name="valider" value="Valider" />
                    
                </form>
                <!--<form action="AnnuleCreationUser" method="post">
                    <input type="submit" name="Annuler" value="Annuler"/>
                </form>-->
                
                 
            </div>
        </div>  
    </body>
</html>
