
Ntransient=3;
fs=500000;
num_H=5; 
wid=1; 
osr=1;
Nsample=8192;
En_plot=1;
% data=CIC.signals.values(1:256);
% yout_1=double(yout);
data=out.simout;
%data=csvread("1106.csv");
% vout(Ntransient+1:Ntransient+Nsample);
%data=out.vout4(Ntransient+1:Ntransient+Nsample);
% data=Scop1eData6.signals.values;
fh=Nsample/osr/2;%自然数带宽
% *********************************************
% GET DATA (These need to be set)
% ******************************
% choose the data_type which should be processed
% window or not
fundpnts=3;                %   selection of fundation power
windpnts=3;
s_point=eps;

% CALCULATE VALUES FOR FFT
% ***********************************
fres=fs/Nsample;           % Desired frequency resolution of FFT [Hz], fres=fclk/2^N=fin/M
Ts=1/fs;                   % Calculate period
Nsamples=round(fs/fres);   % Determine number of samples required for desired FFT
                           % frequency resolution
frescalc=fs/Nsamples;      % Calculated freq resolution based on calculated number of samples


% ************************************
% SELECT WINDOW OF DATA FROM DATA SET
% ************************************
y=data(1:Nsample);
f=(0:1:Nsamples-1)*fres;

% WINDOW DATA
% ***********************************
yw=y';
if wid==1
y=yw';
yw=y.*window(@rectwin,Nsample);

end

% ************************************
% PERFORM FFT
% ************************************
fftout = abs(fft(yw))/(Nsamples/2);            % multiply x2 to normalize because 
                                               % fft of 1*sin(x) = 0.5[d(w-wo)+d(w+wo)]
fftoutdB = 20*log10(fftout+s_point);           % change to [dB], add 1e-20 to avoid log 0
[Fin_dB,Fin_ind]=max(fftout(4:Nsample/2));    % find frequence of input
[Fin1_dB,Fin1_ind]=max(fftoutdB(4:Nsample/2)); 
fin=(Fin_ind+2)*fres;

% ************************************
% ************************************

% DETERMINE HARMONIC FREQUENCIES
% ***********************************
% Finds the harmoic frequencies as they fold into the baseband
%   as well as the vector index of those harmonics
for i=1:1:(num_H+1)   % harmonic number
    done=0;
    k=1;     % frequency band number, 1 = 0 to Fs Hz
    while done==0
        if i*fin < (k-1/2)*fs
            harm(i)=i*fin-(k-1)*fs;
            done=1;    
        elseif i*fin < k*fs
            harm(i)=k*fs-i*fin;
            done=1;
        else
            k=k+1;
        end
    end
end
harm_ind=harm/fres+ones(1,length(harm)); % determine vector index of harmonics
                                         % add 1 because DC = index 1
harm_ind=harm_ind';
win_ind_min=harm_ind(2:num_H+1)-windpnts;    % Points to include in harm
win_ind_max=harm_ind(2:num_H+1)+windpnts;
HD=zeros(num_H,1);

for i=1:1:num_H
    HD(i)=sum(fftout(win_ind_min(i):1:win_ind_max(i)).^2);
end
% CALCULATE MEAN AND STDDEV OF DATA
% *************************************
ave_data=mean(data);
stddev_data=std(data);


% CALCULATE SNDR, SNR, SFDR, THD
% *************************************

    % Calculate SNR/SNDR/SFDR/THD normally
    fftout_n=fftout;                                % Save FFT data, use copy for manipulations
    P_DC=sum(fftout_n(1:3).^2);
    fund_ind=(harm_ind(1)-fundpnts):1:(harm_ind(1)+fundpnts);             % Points to include in fundemental
       
    P_S=sum(fftout_n(fund_ind).^2);                 % Power of fundemental
    P_ND=sum(fftout_n(1:fh).^2)-P_S-P_DC;        % Power of Noise and Distortion (exclude DC)
    P_D=sum(HD(2:num_H)); % Power of harmonics
    
    for i=[1 fund_ind]
        fftout_n(i)=1e-20;                            % Remove DC and fundamental from spectrum for SFDR
    end
    for i=1:1:3
        fftout_n(i)=1e-20;
    end
    [M_H,H_ind]=max(HD(2:num_H));        % Magnitude and index of dominant harmonic
    P_H=M_H;                             % Power of dominant harmonic
%     P_D=eps;    

    SNDRo=10*log10(P_S/P_ND);                       % SNDR [dB]
    THDo=-10*log10(P_S/P_D);                        % THD [dB]
    SNRo=10*log10(P_S/(P_ND-P_D));
    SFDRo=10*log10(P_S/P_H);
    %SFDRo=10*log10(P_S/P_H);                        % SFDR [dB]
    ENOBo=(SNDRo-1.72)/6.02;                        % ENOB [Bit]
    FLOOR_NOISEo=-SNRo-10*(log10(Nsamples/2))+fftoutdB(harm_ind(1));      % FLOOR_NOISE [dB]
    HDo=10*log10(HD(1:length(HD))/P_S);             % HD   [dB]
    SNR=SNRo;
    SFDR=SFDRo;
    SNDR=SNDRo;
    THD=THDo;
    HD=HDo;
    FLOOR_NOISE=FLOOR_NOISEo;
    ENOB=ENOBo;
 %plot(fftout)  
 
% PLOT DATA, HISTOGRAM, FFT
% *********************************************
%plot FFT
%subplot(3,1,3)
if(En_plot==1)
figure 
hold on
plot(f(1:Nsamples/2)/1e3,fftoutdB(1:Nsamples/2)-Fin1_dB,'black'); % Choose FFT with frequency or index
%plot(fftoutdB(1:Nsamples/2));
F(1:Nsamples/2)=f(1:Nsamples/2);
FFTOUTDB(1:Nsamples/2)=fftoutdB(1:Nsamples/2)-Fin1_dB;
for i=1:1:length(harm)     % Mark all the harmonics
    plot(harm(i)/1e3,fftoutdB(harm_ind(i))-Fin1_dB,'r')
    text(harm(i)/1e3,fftoutdB(harm_ind(i))-Fin1_dB+3,num2str(i),'color','m','FontSize',8);
    %plot(harm_ind(i)/1e6,fftoutdB(harm_ind(i)),'r*')
end
ylabel('Full-Scale Normalized Magnitude[dB]')
xlabel('Frequency [kHz]')
%title(sprintf('FFT (%g points)\nFs = %g MSps, Fin = %g MHz (%1.2g dBfs)\n%gx Decimated', ...
%     Nsamples,fs_predec/1e6,fin/1e6,fftoutdB(harm_ind(1)),decimate));
title(sprintf('FFT (%g points)\nFs = %g MSps, Fin = %g MHz (%1.2g dBfs)', ...
      Nsamples,fs/1e6,fin/1e6,fftoutdB(harm_ind(1))));
grid;
box on;
ylim([-250 10]);
xlim([0 f(Nsamples/2)/1e3]);
set(gca,'xgrid', 'off');
set(gca,'xscale','log');
set(gca, 'GridLineStyle' ,'-');
set(gca,'yTick',[-150:10:10]);

s1=sprintf('SFDR = %4.1fdB\n',SFDRo);
s2=sprintf('THD = %4.1fdB\n',THDo);
s3=sprintf('SNR   = %4.1fdB\n',SNRo);
s4=sprintf('SNDR = %4.1fdB\n',SNDRo);
s5=sprintf('ENOB = %4.2fbit\n',ENOBo);
if harm(1)/1e3 < f(Nsamples/2)/1e3/4
    xstation= f(Nsamples/2)/1e3/2;
elseif harm(1)/1e3 > (f(Nsamples/2)*3)/1e3/4
    xstation= f(Nsamples/2)/1e3/4;
else
    xstation= f(Nsamples/2)/1e3/32;
end
text(xstation/8,-10,s1);
text(xstation/8,-20,s2);
text(xstation/8,-30,s3);
text(xstation/8,-40,s4);
text(xstation/8,-50,s5);
hold off;  
end
