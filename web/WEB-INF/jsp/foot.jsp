<%-- 
    Document   : foot
    Created on : 17 nov. 2015, 11:59:12
    Author     : Mesmerus
--%>
<%@page import="entities.Entreprise"%>
<%@page import="model.dao.EntrepriseDAO"%>
<%
    Entreprise ent = EntrepriseDAO.getEnt(1);
   // System.out.println(ent.getNom());
%>
<aside id="applimobile" class="bg-dark">
            <div class="container text-center">
                <div class="call-to-action">
                    <h2>Telechargez l'application mobile ${ent}</h2>
                    <a href="#" class="btn btn-default btn-xl wow tada">Download Now!</a>
                </div>
            </div>
        </aside>
        <section id="contact">
            <div class="container">
                <div class="row">
                    <div class="col-lg-8 col-lg-offset-2 text-center">
                        <h2 class="section-heading">Nous Contacter</h2>
                        <hr class="primary">
                    </div>
                    <div class="col-lg-4 col-lg-offset-2 text-center">
                       <i class="fa fa-4x fa-newspaper-o wow bounceIn text-primary" data-wow-delay=".2s"></i>
                        <p><strong><%=ent.getNom() %></strong></p>
                        <p><%=ent.getTelephone() %></p>
                        <p><%=ent.getAdresse() %> <%=ent.getVille() %> <%=ent.getCode() %></p>
                        <p><%=ent.getMail() %></p>
                    </div>
                    <div class="col-lg-4 text-center">
                        <i class="fa fa-envelope-o fa-3x wow bounceIn" data-wow-delay=".1s"></i>
                        <p><a href="mailto:<%=ent.getMail() %>"><%=ent.getMail() %></a></p>
                    </div>
                </div>
            </div>
        </section>
