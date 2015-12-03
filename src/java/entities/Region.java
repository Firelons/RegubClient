package entities;
// Generated 3 d�c. 2015 16:18:03 by Hibernate Tools 4.3.1


import java.util.HashSet;
import java.util.Set;

/**
 * Region generated by hbm2java
 */
public class Region  implements java.io.Serializable {


     private Integer idRegion;
     private String libelle;
     private Set magasins = new HashSet(0);
     private Set videos = new HashSet(0);

    public Region() {
    }

	
    public Region(String libelle) {
        this.libelle = libelle;
    }
    public Region(String libelle, Set magasins, Set videos) {
       this.libelle = libelle;
       this.magasins = magasins;
       this.videos = videos;
    }
   
    public Integer getIdRegion() {
        return this.idRegion;
    }
    
    public void setIdRegion(Integer idRegion) {
        this.idRegion = idRegion;
    }
    public String getLibelle() {
        return this.libelle;
    }
    
    public void setLibelle(String libelle) {
        this.libelle = libelle;
    }
    public Set getMagasins() {
        return this.magasins;
    }
    
    public void setMagasins(Set magasins) {
        this.magasins = magasins;
    }
    public Set getVideos() {
        return this.videos;
    }
    
    public void setVideos(Set videos) {
        this.videos = videos;
    }




}


