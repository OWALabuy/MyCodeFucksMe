package tech.owalabuy.util;

public class ChangeString{
    public static String iso2gbk(String str){
        if(str != null){
            try{
                str = new String(str.getBytes());
            } catch(Exception e){
                e.printStackTrace();
            }
        }
        return str;
    }
    
    public static String gbk2iso(String str){
        if(str != null){
            try{
                str = new String(str.getBytes());
            } catch(Exception e){
                e.printStackTrace();
            }
        }
        return str;
    }
}
