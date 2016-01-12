package entities;


import java.util.HashSet;
import java.util.Set;

/**
 * Magasin generated by hbm2java
 */
public class Magasin  implements java.io.Serializable {


     private Integer idMagasin;
     private Region region;
     private String nom;
     private String addrLigne1;
     private String addrLigne2;
     private String codePostal;
     private String ville;
     private Set diffusionses = new HashSet(0);
     private Set typerayons = new HashSet(0);

    public Magasin() {
    }

	
    public Magasin(Region region, String nom, String addrLigne1, String addrLigne2, String codePostal, String ville) {
        this.region = region;
        this.nom = nom;
         this.addrLigne1 = addrLigne1;
       this.addrLigne2 = addrLigne2;
        this.codePostal = codePostal;
        this.ville = ville;
    }
    public Magasin(Region region, String nom, String addrLigne1, String addrLigne2, String codePostal, String ville, Set diffusionses, Set typerayons) {
       this.region = region;
       this.nom = nom;
       this.addrLigne1 = addrLigne1;
       this.addrLigne2 = addrLigne2;
       this.codePostal = codePostal;
       this.ville = ville;
       this.diffusionses = diffusionses;
       this.typerayons = typerayons;
    }
   
    public Integer getIdMagasin() {
        return this.idMagasin;
    }
    
    public void setIdMagasin(Integer idMagasin) {
        this.idMagasin = idMagasin;
    }
    public Region getRegion() {
        return this.region;
    }
    
    public void setRegion(Region region) {
        this.region = region;
    }
    public String getNom() {
        return this.nom;
    }
    
    public void setNom(String nom) {
        this.nom = nom;
    }
    public String getAddrLigne1() {
        return this.addrLigne1;
    }
    
    public void setAddrLigne1(String addrLigne1) {
        this.addrLigne1 = addrLigne1;
    }
    public String getAddrLigne2() {
        return this.addrLigne2;
    }
    
    public void setAddrLigne2(String addrLigne2) {
        this.addrLigne2 = addrLigne2;
    }
    public String getCodePostal() {
        return this.codePostal;
    }
    
    public void setCodePostal(String codePostal) {
        this.codePostal = codePostal;
    }
    public String getVille() {
        return this.ville;
    }
    
    public void setVille(String ville) {
        this.ville = ville;
    }
    public Set getDiffusionses() {
        return this.diffusionses;
    }
    
    public void setDiffusionses(Set diffusionses) {
        this.diffusionses = diffusionses;
    }
    public Set getTyperayons() {
        return this.typerayons;
    }
    
    public void setTyperayons(Set typerayons) {
        this.typerayons = typerayons;
    }




}


