function [ output ] = SpectralFlatness( input,size)
%Spectral flatness is the ratio between the geometric and arithmetirc means
%of the magnitude of the fourier transform
prod = 1;
  for n = 1:size-1
      prod = prod*input(n)^(1/size);
%     temp = input(n)*input(n+1);
%     final = temp*final;
  end
  sumSF = sum(input);

  output = (prod)/((1/size)*sumSF);
end

