% Input data
nama=input('Masukkan 4 angka terakhir Nim: ');
namastr = int2str(nama);
nama2 = double(namastr);
ascii = nama2.*ones(1,4);
asciibin = dec2bin(ascii,8);
abc = str2num(asciibin);
%abcd = abc.*ones(1,32);
b=asciibin';
c=str2num(b(:));

%Jadi deret biner dapat ditulis sebagai :
bit_stream = c;

% Enter the two Phase shifts - in Radians
% Phase for 0 bit
P1 = 0; 
% Phase for 1 bit
P2 = pi;
% frekuensi modulasi
f = 3;
%frekuensi sampling data
fs = 100;
% waktu untuk satu bit
t = 0: 1/fs : 1;
%variabel waktu untuk ploting nanti 
time = [];
PSK_signal = [];
Digital_signal = [];


for ii = 1: 1: length(bit_stream)
    
    % The FSK Signal
    PSK_signal = [PSK_signal (bit_stream(ii)==0)*sin(2*pi*f*t + P1)+...
        (bit_stream(ii)==1)*sin(2*pi*f*t + P2)];
    
    % The Original Digital Signal
    Digital_signal = [Digital_signal (bit_stream(ii)==0)*...
        -(ones(1,length(t))) + (bit_stream(ii)==1)*ones(1,length(t))];
    
    %sinyal carrier
    sc = sin(2*pi*f*t);

    time = [time t];
    t =  t + 1;
   
end

ac = 1;
fc = 3;
fs = 10*fc;
ts = 1/fs;

t = 0: 1/fs : 32;
sc = ac*cos(2*pi*fc*t);

% Plot the PSK Signal
subplot(3,1,1);
plot(t,sc,'LineWidth',2);
xlabel('waktu (perioda bit)');
ylabel('Amplitude');
title('carrier signal');
axis([0 time(end) -1.5 1.5]);
grid  on;

% Plot the Original Digital Signal
subplot(3,1,2);
plot(time,Digital_signal,'r','LineWidth',2);
xlabel('waktu (perioda bit)');
ylabel('Amplitude');
title('Digital Signal polar');
axis([0 time(end) -1.5 1.5]);
grid on;

% Plot the PSK Signal
subplot(3,1,3);
plot(time,PSK_signal,'LineWidth',2);
xlabel('waktu (perioda bit)');
ylabel('Amplitude');
title('PSK Signal dengan dua Phase Shifts');
axis([0 time(end) -1.5 1.5]);
grid  on;