///base_convert(number,oldbase,newbase)
{
    var number,oldbase,newbase,out,len,tab,i,num,divide,newlen;
    number = string_upper(argument0);
    oldbase = argument1;
    newbase = argument2;
    out = "";
    len = string_length(number);
    tab = "0123456789ABCDEFGHIJKLMNOPQRSTUVWXYZ";
    for (i=0; i<len; i+=1) {
        num[i] = string_pos(string_char_at(number,i+1),tab)-1;
    }
    do {
        divide = 0;
        newlen = 0;
        for (i=0; i<len; i+=1) {
            divide = divide * oldbase + num[i];
            if (divide >= newbase) {
                num[newlen] = divide div newbase;
                newlen += 1;
                divide = divide mod newbase;
            }else if (newlen  > 0) {
                num[newlen] = 0;
                newlen += 1;
            }
        }
        len = newlen;
        out = string_char_at(tab,divide+1) + out;
    } until (len == 0);
    return out;
}
