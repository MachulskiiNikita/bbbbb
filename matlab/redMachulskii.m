close all
clear variables
spectra = importdata('spectra.csv');
lambdaStart = importdata('lambda_start.csv');
lambdaDelta = importdata('lambda_delta.csv');
starNames = importdata("star_names.csv");
lambdaPr = 656.28; %нм
speedOfLight = 299792.458; %км/с
nObs = size(spectra, 1);
lambdaEnd = lambdaStart + (nObs - 1) * lambdaDelta;
lambda = (lambdaStart : lambdaDelta : lambdaEnd)';
[sHa, idx] = min(spectra);
lambdaHa = lambda(idx);
z = (lambdaHa / lambdaPr) - 1;
speed = z * speedOfLight;
movaway = starNames(speed > 0);
fg1 = figure;
grid on
hold on
title('Спектры звезд')
quantityOfStars = size(starNames,1);
for i = 1 : quantityOfStars
    s = spectra(:,i);
    starName = starNames(i,1);
    if z(i) < 0
        plot(lambda, s, '--', "LineWidth", 1)
    else
        plot(lambda, s, "LineWidth", 3)
    end
    xlabel('длина волны')
    ylabel(['интенсивность, эрг/см^2/с/',char(197)])
    legend(starNames)
end
text(632,2.5*10^(-13),'Мачульский Никита Б04-007')
set(fg1, 'Visible', 'on')
hold off
saveas(fg1, 'stars_spectres.png')
