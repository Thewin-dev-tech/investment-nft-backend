export class UtilityHelper{
    static stringReplaceAll(fullStr,target,replaceBy){
        let str = "";
        for(let c  of fullStr ){
            str += (c==target)? replaceBy : c ;
          }
        return str;
    }
}