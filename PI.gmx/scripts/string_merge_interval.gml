///string_merge_interval(string_1, string_2, num_intervals)
var str = 0,
    num_ints = argument[2];

var new_str = "",
    c1 = 0, // Current interval
    index = 1, // Current point in strings
    len = 0,
    curr_str = choose(0, 1);

str[0] = argument[0];
str[1] = argument[1];

len = string_length(str[0]);

repeat (num_ints)
{
    var rand = len,
        val = "";
        
    if (c1 != num_ints - 1)
    {
        rand = irandom_range(index, len - (num_ints - c1) - 1);
    }
        
    val = string_copy(str[curr_str], index, rand - index + 1);
    
    /*show_message(index);
    show_message(rand);
    show_message(val);*/
    
    index = rand + 1;
    new_str += val;
    curr_str = abs(curr_str - 1); // Just a trick to toggle this back and forth between 1 and 0
    c1++;
}
return (new_str);
