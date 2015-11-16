package entities;
// Generated 15 nov. 2015 13:36:36 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Typecompte generated by hbm2java
 */
public class Typecompte  implements java.io.Serializable {


     private Integer idTypeCompte;
     private String libelle;
     private String dblogin;
     private String dbpassword;
     private Set comptes = new HashSet(0);

    public Typecompte() {
    }

	
    public Typecompte(String libelle, String dblogin, String dbpassword) {
        this.libelle = libelle;
        this.dblogin = dblogin;
        this.dbpassword = dbpassword;
    }
    public Typecompte(String libelle, String dblogin, String dbpassword, Set comptes) {
       this.libelle = libelle;
       this.dblogin = dblogin;
       this.dbpassword = dbpassword;
       this.comptes = comptes;
    }
   
    public Integer getIdTypeCompte() {
        return this.idTypeCompte;
    }
    
    public void setIdTypeCompte(Integer idTypeCompte) {
        this.idTypeCompte = idTypeCompte;
    }
    public String getLibelle() {
        return this.libelle;
    }
    
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
    public String getDblogin() {
        return this.dblogin;
    }
    
    public void setDblogin(String dblogin) {
        this.dblogin = dblogin;
    }
    public String getDbpassword() {
        return this.dbpassword;
    }
    
    public void setDbpassword(String dbpassword) {
        this.dbpassword = dbpassword;
    }
    public Set getComptes() {
        return this.comptes;
    }
    
    public void setComptes(Set comptes) {
        this.comptes = comptes;
    }




}


