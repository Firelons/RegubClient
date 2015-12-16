package entities;


import java.util.Date;

/**
 * Diffusions generated by hbm2java
 */
public class Diffusions  implements java.io.Serializable {


     private Integer idDiffusion;
     private Magasin magasin;
     private Typerayon typerayon;
     private Video video;
     private Date dateDiffusion;

    public Diffusions() {
    }

    public Diffusions(Magasin magasin, Typerayon typerayon, Video video, Date dateDiffusion) {
       this.magasin = magasin;
       this.typerayon = typerayon;
       this.video = video;
       this.dateDiffusion = dateDiffusion;
    }
   
    public Integer getIdDiffusion() {
        return this.idDiffusion;
    }
    
    public void setIdDiffusion(Integer idDiffusion) {
        this.idDiffusion = idDiffusion;
    }
    public Magasin getMagasin() {
        return this.magasin;
    }
    
    public void setMagasin(Magasin magasin) {
        this.magasin = magasin;
    }
    public Typerayon getTyperayon() {
        return this.typerayon;
    }
    
    public void setTyperayon(Typerayon typerayon) {
        this.typerayon = typerayon;
    }
    public Video getVideo() {
        return this.video;
    }
    
    public void setVideo(Video video) {
        this.video = video;
    }
    public Date getDateDiffusion() {
        return this.dateDiffusion;
    }
    
    public void setDateDiffusion(Date dateDiffusion) {
        this.dateDiffusion = dateDiffusion;
    }




}


