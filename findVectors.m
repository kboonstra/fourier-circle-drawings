function arrows = findVectors(z_hat, n, t)
%sorry, not arrows, but lines p much at a given t

positiveFreq = [];
for j = 0:n
    c = z_hat(j+1)*exp(2*pi*j*1i*t); %positive frequency terms
    positiveFreq = [positiveFreq,c];
end

%so the reason it's like this is because our z_hat is not in a really great
%order... it does like 0 1 2 3 4 5 ... up until "n" which is the maximum
%index number, and then it goes down after reaching the halfway point so
%like all of a sudden it goes from 50 to -50 then -49 -48 and so on until
%-2 -1; so here I'm just changing the order so it's nicer for us to think
%about for plotting and more like what 3Blue1brown was saying in their
%video
negativeFreq = [];
for j = 1:n
    k = length(z_hat)+1-j; %negative frequency terms, important first
    c = z_hat(k)*exp(2*pi*(-j)*1i*t);
    negativeFreq = [negativeFreq,c];
end

%ayoooooo logical indexing check Graham must be proud
frequencies = zeros(1, 2*n+1);
frequencies(1:2:2*n+1) = positiveFreq;
frequencies(2:2:2*n) = negativeFreq;

arrows = frequencies;