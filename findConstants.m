function z_hat = findConstants(f)

% applies the Fourier fast transform to the points to yield constants
z_hat = fft(f);