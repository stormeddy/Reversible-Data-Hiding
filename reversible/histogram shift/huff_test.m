symbols = 1:6; % Distinct symbols that data source can produce
p = [.5 .125 .125 .125 .0625 .0625]; % Probability distribution
[dict,avglen] = huffmandict(symbols,p); % Create dictionary.
actualsig = randsrc(100,1,[symbols; p]); % Create data using p.
comp = huffmanenco(actualsig,dict); % Encode the data.

dsig = huffmandeco(comp,dict);
isequal(actualsig,dsig)


binarySig = de2bi(actualsig);
seqLen = numel(binarySig);
binaryComp = de2bi(comp);
encodedLen = numel(binaryComp);