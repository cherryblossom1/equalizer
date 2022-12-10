% this function plots the woofer, squawker and twteer frequencies separately 
% and the time domain waveform for the set duration in the main code. The
% frequencies are differentiated based on the filterbank and the tone is
% shown based on a dictionary given in GtunePP.
function plotG(I,~,y,T,Fs,filterbank,fn)
    Csample = get(I,'CurrentSample');
    % take limited end samples at every T interval
    samples = sum(y(Csample:Csample + T*Fs,:),2);
    G=5;
    M = size(filterbank,2);
     
     % filter the data samples using filterbank
     P=zeros(M,1);
     for(k1=1:M)
          y = filter(filterbank(:,k1),1,samples);
          P(k1) = sum(y.^2)/(T*Fs);
     end
     Pb = P(fn<500); Psq = P(fn>500 & fn<2000); Pt=P(fn>2000);                            % separate out base, squawker and treble power
     Pb = Pb/max(Pb); Psq = Psq/max(Psq); Pt = Pt/max(Pt);                                          % normalize the power for plotting
     noteB = GtunePP(fn(Pb==1)); noteS = GtunePP(fn(Psq==1)); noteT = GtunePP(fn(Pt==1));                % find corrosponding note from the dictionary
     
     %% plots 
     subplot(2,3,1:3);
     plot(0:1/Fs:T,samples); grid on;
     axis([0 T -G G]);
     title('waveform');
     
     subplot(2,3,4);
     plot(fn(fn<500),Pb,'b'); grid on;
     ylim([0 1]);
     title(['woofer: ',noteB]);
     
     subplot(2,3,5);
     plot(fn(fn>500 & fn<2000),Psq,'g'); grid on;
     ylim([0 1]);
     title(['squawker :', noteS]);
     
     subplot(2,3,6);
     plot(fn(fn>2000),Pt,'r'); grid on;
     ylim([0 1]);
     title(['tweeter :', noteT]);
     %     axis([0 0.08*G 0 Fs/2]);
     drawnow;
end
