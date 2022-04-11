clear all, close all, clc, pkg load image;

img = double(imread("teste.tif"));
figure, subplot(2,2,1), imshow(uint8(img)), title('Imagem de entrada');

[nL, nC] = size(img);

histInput = zeros(nL, nC);

for i=1:nL
  for j=1:nC
    histInput(img(i,j) + 1) = histInput(img(i,j) + 1) + 1;
  endfor
endfor
subplot(2,2,2), plot(histInput), title("Histograma da imagem de entrada");

# Probabilidade de ocorrencia da intensidade
probability = (1 / (nL*nC)) * histInput;

# Soma cumulativa
cumulative = zeros(nL, nC);
cumulative(1) = probability(1);
for i=2:nL
  cumulative(i) = cumulative(i-1) + probability(i);
endfor

# 2^8 = 256 bits; 0-255
cumulative = round(255*cumulative);

ep = zeros(nL, nC);
for i=1:nL
  for j=1:nC
    t=img(i,j) + 1;
    ep(i,j)=cumulative(t);
  endfor
endfor

histEq = zeros(nL, nC);
for i=1:nL
  for j=1:nC
    histEq(ep(i,j) + 1) = histEq(ep(i,j) + 1) + 1;
  endfor
endfor

ep = uint8(rescale(ep,0,255));
subplot(2,2,3), imshow(ep), title("Imagem com equalização de histograma");
subplot(2,2,4), plot(histEq), title("histograma da imagem filtrada");

