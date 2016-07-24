/**
 *
 * BELOW IS FOR COLLECTING SERVICE CODE DATA 
 *  
 */
public void printCodes()
{

  for (int i = 0; i < xmlEntry.length; i ++)
  {
    XML desc = xmlEntry[i].getChild("content/dcst:ServiceRequest/dcst:servicecodedescription");
    XML rep = xmlEntry[i].getChild("content/dcst:ServiceRequest/dcst:servicecode");
    String description = desc.getContent(); 
    String reportCode = rep.getContent();

    if (!reportCode.equals("S0003")
      &&!reportCode.equals("S0000")
      &&!reportCode.equals("S0011")
      &&!reportCode.equals("S0016")
      &&!reportCode.equals("S05AL")
      &&!reportCode.equals("S0021")
      &&!reportCode.equals("S0031")
      &&!reportCode.equals("CFSAMISS")
      &&!reportCode.equals("CONTREMO")
      &&!reportCode.equals("S0081")
      &&!reportCode.equals("DDOTCITA")
      &&!reportCode.equals("DHS09")
      &&!reportCode.equals("11")
      &&!reportCode.equals("DMVADJSU")
      &&!reportCode.equals("DMV40")
      &&!reportCode.equals("DMV66")
      &&!reportCode.equals("DMV01")
      &&!reportCode.equals("DMV08")
      &&!reportCode.equals("DMV43")
      &&!reportCode.equals("DMV37")
      &&!reportCode.equals("ITISSUES")
      &&!reportCode.equals("DMPRCEMA")
      &&!reportCode.equals("DMV51")
      &&!reportCode.equals("DMV63")
      &&!reportCode.equals("DMV71")
      &&!reportCode.equals("DMV19")
      &&!reportCode.equals("DMV31")
      &&!reportCode.equals("FESPEDNU")
      &&!reportCode.equals("FESAADNU")
      &&!reportCode.equals("GRAFF")
      &&!reportCode.equals("HMDCP")
      &&!reportCode.equals("S0181")
      &&!reportCode.equals("INSECTS")
      &&!reportCode.equals("MARKINST")
      &&!reportCode.equals("MARKMODI")
      &&!reportCode.equals("S0336")
      &&!reportCode.equals("S0261")
      &&!reportCode.equals("S0276")
      &&!reportCode.equals("PVDNUSIT")
      &&!reportCode.equals("S0301")
      &&!reportCode.equals("S0311")
      &&!reportCode.equals("S0316")
      &&!reportCode.equals("S0321")
      &&!reportCode.equals("RPP")
      &&!reportCode.equals("S0346")
      &&!reportCode.equals("S0361")
      &&!reportCode.equals("SIGNMISS")
      &&!reportCode.equals("S0376")
      &&!reportCode.equals("S0287")
      &&!reportCode.equals("S0286")
      &&!reportCode.equals("S0391")
      &&!reportCode.equals("S0406")
      &&!reportCode.equals("S05SL")
      &&!reportCode.equals("S0423")
      &&!reportCode.equals("S0422")
      &&!reportCode.equals("SPSTDAMA")
      &&!reportCode.equals("SIGTRAMA")
      &&!reportCode.equals("S0451")
      &&!reportCode.equals("TRACO001")
      &&!reportCode.equals("S0441")
      &&!reportCode.equals("S0457")
      &&!reportCode.equals("S04TP")
      &&!reportCode.equals("PRUNING")
      &&!reportCode.equals("S0459")
      &&!reportCode.equals("TRUREPOR")
      &&!reportCode.equals("S0466")
      &&!reportCode.equals("S0471")
      &&!reportCode.equals("S0476")
      &&!reportCode.equals("PEDSAFPR")
      &&!reportCode.equals("DPWCORTR")
      &&!reportCode.equals("S0196")
      &&!reportCode.equals("DMV48")
      &&!reportCode.equals("SWMCOLBU")
      &&!reportCode.equals("S0031")
      &&!reportCode.equals("SRC01")
      &&!reportCode.equals("S0460")
      &&!reportCode.equals("S0421")
      &&!reportCode.equals("DMVOFFSE")
      &&!reportCode.equals("RECCONRE"))
    {
      println(i + " " + description);
      println("    " + reportCode);
      println("");
    }
  }
}
