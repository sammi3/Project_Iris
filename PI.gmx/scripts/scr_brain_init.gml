//Creating the brain from the genome
//Setting the counter to 57 which is where we left it in the body init script
var counter = 57;
var eNeurons,iNeurons;
//This will be the counter for the number of Neurons the agent has
numNeurons = 0;

//Here we create a variable nGroup which will store the amount of neurons in a group of neurons
//This helps us specify the connections in the brain of an agent with less computational
//load compared to specifying the brain on a per neuron basis.
var nGroup;
nGroup[neuronGroups-1,1]  = 0;
for(var j = 0; j < 2; j++)
{
    for(var i = 0; i < neuronGroups; i++)
    {
        nGroup[i,j] = 1 + round((real(base_convert(string_copy(geneStr,counter,8),2,10))/255)*2);
        numNeurons += nGroup[i,j]
        counter += 8;
    }
}

//We move the counter a proportionate ammount in order to account 'gaps' in the genome
//Since the genome specifies all the genes possible, it is possible and common
//for an agent not to use the whole length of the genome. This can lead to genes
//that can pop up into use down generations due to mutations
counter += ((numNeuronGroups-neuronGroups)*2)*8;

//We create a ds_grid that will be used to store the activation of a neuron at the end
//of a timestep
hidden[numNeurons-1] = 0;
hidden_0[numNeurons-1] = 0;
//We then create an array that will store the weights for the connections between the
//inputs and the hidden nodes
synapse_in[numNeurons-1,numInputs-1] = 0;
//Here we set a variable k in order to store the values of the weights. We move along k
//across the length of the array. We do not reset it in between the two groups of 
//nested for loops to account for having two types of neurons (excitatory and inhibitory)
var k = 0;
for(var j = 0; j < numInputs; j++)
{
    k = 0;
    for(var i = 0; i<neuronGroups; i++;)
    {
        repeat(nGroup[i,0])
        {
            synapse_in[k,j] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
            k++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups-neuronGroups)*numInputs)*8;

//We have enough information to know how many excitatory and inhibitory neurons there are
//We will need this for later when determing the sign of the weights at the axons
eNeurons = k;
iNeurons = numNeurons-eNeurons;
for(var j = 0; j < numInputs; j++)
{
    k = eNeurons;
    for(var i = 0; i<neuronGroups; i++;)
    {
        repeat(nGroup[i,1])
        {
            synapse_in[k,j] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
            k++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups-neuronGroups)*numInputs)*8;

//Hidden nodes to hidden nodes
//excitatory to excitatory
synapse_nn = ds_grid_create(numNeurons,numNeurons);
for(var j = 0; j < neuronGroups; j++)
{
    for(var i = 0; i < neuronGroups; i++)
    {
        var n = 0;
        repeat(nGroup[j,0])
        {
            var k = 0;
            repeat(nGroup[i,0])
            {
                synapse_nn[#k,n] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
                k++;
            }
            n++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups*numNeuronGroups)-(neuronGroups*neuronGroups))*8;

//excitatory to inhibitory
for(var j = 0; j < neuronGroups; j++)
{
    for(var i = 0; i < neuronGroups; i++)
    {
        var n = eNeurons;
        repeat(nGroup[j,1])
        {
            var k = 0;
            repeat(nGroup[i,0])
            {
                synapse_nn[#k,n] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
                k++;
            }
            n++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups*numNeuronGroups)-(neuronGroups*neuronGroups))*8;

//inhibitory to excitatory
for(var j = 0; j < neuronGroups; j++)
{
    for(var i = 0; i < neuronGroups; i++)
    {
        var n = 0;
        repeat(nGroup[j,0])
        {
            var k = eNeurons;
            repeat(nGroup[i,1])
            {
                synapse_nn[#k,n] = -(real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
                k++;
            }
            n++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups*numNeuronGroups)-(neuronGroups*neuronGroups))*8;

//inhibitory to inhibitory
for(var j = 0; j < neuronGroups; j++)
{
    for(var i = 0; i < neuronGroups; i++)
    {
        var n = eNeurons;
        repeat(nGroup[j,1])
        {
            var k = eNeurons;
            repeat(nGroup[i,1])
            {
                synapse_nn[#k,n] = -(real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
                k++;
            }
            n++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups*numNeuronGroups)-(neuronGroups*neuronGroups))*8;

//Now we specify the hidden nodes weight to the output nodes
//We begin by creating the array that will store the weights of the outputs
synapse_on[numNeurons-1,numOutputs-1] = 0;
var k = 0;
for(var j = 0; j < numOutputs; j++)
{
    k = 0;
    for(var i = 0; i<neuronGroups; i++;)
    {
        repeat(nGroup[i,0])
        {
            synapse_on[k,j] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
            k++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups-neuronGroups)*numOutputs)*8;

for(var j = 0; j < numOutputs; j++)
{
    k = eNeurons;
    for(var i = 0; i<neuronGroups; i++;)
    {
        repeat(nGroup[i,1])
        {
            synapse_on[k,j] = -(real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
            k++;
        }
        counter +=8;
    }
}

counter += ((numNeuronGroups-neuronGroups)*numOutputs)*8;

//Time to create the biases
bias_hidden[numNeurons-1] = 0;

k = 0;
for(var i = 0; i < neuronGroups; i++)
{
    repeat(nGroup[i,0])
    {
        bias_hidden[k] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255);
        k++;
    }
    counter += 8; 
}

counter += (numNeuronGroups-neuronGroups)*8;
k = eNeurons;
for(var i = 0; i < neuronGroups; i++)
{
    repeat(nGroup[i,0])
    {
        bias_hidden[k] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255);
        k++;
    }
    counter += 8; 
}

counter += (numNeuronGroups-neuronGroups)*8;

bias_output[numOutputs-1] = 0;

for(var i = 0; i < numOutputs; i++)
{
    bias_output[i] = (real(base_convert(string_copy(geneStr,counter,8),2,10))/255); 
    counter += 8;
}

//show_debug_message(counter);
