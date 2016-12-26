///scr_gene_init_random();
//Here we randomly generate the organisms genome based on the number of genes an organism has
var n,i;
n = 0

randomize();

i = (numBodyGenes) + (numInputs*numNeuronGroups*2) + (numOutputs*numNeuronGroups*2) +  (numNeuronGroups*2) +(numNeuronGroups*2) + (numOutputs) +(numNeuronGroups*numNeuronGroups*4);
geneStr = "";

for(n = 0; n< i*8; n++)
{
geneStr = string_insert(choose('1','0'),geneStr,n)
}

//show_debug_message(i*8);
