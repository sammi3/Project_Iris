//Initialize the body genes
col_red = real(base_convert(string_copy(geneStr,1,8),2,10));
col_green = real(base_convert(string_copy(geneStr,9,8),2,10));
col_blue = real(base_convert(string_copy(geneStr,17,8),2,10));
sides = round(3 + ((real(base_convert(string_copy(geneStr,25,8),2,10))/255)*5));
size = .5 + ((real(base_convert(string_copy(geneStr,33,8),2,10))/255)*1.5);
maxSpeed = .25 + ((real(base_convert(string_copy(geneStr,41,8),2,10))/255)*.75);
neuronGroups = 2 + round((real(base_convert(string_copy(geneStr,49,8),2,10))/255)*2);

//Creating the arrays that store the inputs and outputs
inputs[numInputs-1] = 0;
outputs[numOutputs-1] = 0;

//setting the scale of the agent
image_xscale = size;
image_yscale = size;
