<%-- 
    Document   : compteUtilisateur
    Created on : 24 nov. 2015, 22:31:59
    Author     : batchanou
--%>

<%@page import="java.util.ArrayList"%>
<%@page import="entities.Compte"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<!DOCTYPE html>
<html>
    <head>
        <meta http-equiv="Content-Type" content="text/html; charset=UTF-8">
        <title>Création des Comptes</title>
    </head>
        
        <div class="container">
            <div class="row">
                <div class="col-lg-12 text-center">
                    <h1 class="section-heading"> Compte Uilisateurs</h1>
                    <hr class="primary">
                </div>
            </div>
        </div>
        <div class="container">
            <div class="table-responsive">    
                <form action="user" method="post">
                    <table class="table" border="1">
                        <tr>
                            <th>Nom</th>
                            <th>Prénom</th>
                            <th>Type de Compte</th>
                            <th>Login</th>
                            <th>Modifier</th>
                            <th>Supprimer</th>
                        </tr>
                        <% ArrayList<Compte> liste =new ArrayList<Compte>();
                        
                           liste=(ArrayList<Compte>)request.getAttribute("compte") ;
                                int i =0;
                         for(i=0;i<liste.size(); i++){
                             %>
                           <tr>
                               <td><%=liste.get(i).getNom() %></td>
                               <td><%=liste.get(i).getPrenom() %></td>
                               <td><%=liste.get(i).getTypecompte().getLibelle() %></td>
                               <td><%=liste.get(i).getLogin() %></td>
                               <td>voir</td>
                               <td> voir </td>
                            </tr>   
                         <%    
                         }
                        %>
                        <form class="" action="retour" method="get">
                            <button class="btn  btn-default " type="submit"><strong>Accueil</strong></button>
                        </form>
                    </table>
                </form>
                <form class="" action="creer" method="get">
                    <button class="btn  btn-default " type="submit"><strong>Ajouter</strong></button>
                </form>
                <form class="" action="update" method="post">
                    <button class="btn btn-primary car" type="submit"><strong>Modifier</strong></button>
                </form> 
                <form class="" action="delete" method="post">
                    <button class="btn btn-primary car" type="submit"><strong>Supprimer</strong></button>
                </form>
            </div>
        </div>    
    </body>
</html>
