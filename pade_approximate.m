close all
clear
clc

T=0.001;  % fsw=1/T=1000 Hz;
w=linspace(0,2*pi/T,10000);  % f:0-->fsw; 
f=w./(2*pi);
f1=exp(-1i*w*T);  %-sT,s=jw
amp_f1=abs(f1); phase_f1=angle(f1)*180/pi;  % rad*180/pi-->degree

x=-1i*w*T; s=1i*w;
f2_2=(x.^2+6*x+12)./(x.^2-6*x+12);  % pade(2,2)
real_f2_2=real(f2_2);imag_f2_2=imag(f2_2);
amp_f2_2=abs(f2_2); phase_f2_2=angle(f2_2)*180/pi;

A1=12/(pi^2);
Q=2/pi; w2=pi/T;   % pade_JL
f3=(A1*x.^2+6*x+12)./(A1*x.^2-6*x+12);
% f3=1-(s.*T)./(1+s./(Q*w2)+(s.^2)./(w2.^2));
real_f3=real(f3);imag_f3=imag(f3);
amp_f3=abs(f3); phase_f3=angle(f3)*180/pi;

B1=48/pi^2;
f_my=(A1*x.^2+B1*x+12)./(A1*x.^2-B1*x+12);  % pade_my
real_f_my=real(f_my);imag_f_my=imag(f_my);
amp_f_my=abs(f_my); phase_f_my=angle(f_my)*180/pi;

% mannitude vs. freq
% initial exp(-sT)
plot(f,20*log10(abs(f1)))
xlabel('f/Hz'); ylabel('|A(jw)|/db');
ylim([-1 1])
hold on
% pade_my
plot(f,20*log10(abs(f_my)),'m')

% pade(2,2)
plot(f,20*log10(abs(f2_2)),'r')
% padeJL
plot(f,20*log10(abs(f3)),'g')

legend('exp(-sT)(f=1kHz)','pade my','pade(2,2)','padeJL')
title('magnitude vs. freq')

% phase vs. freq
figure(2)
plot(f,phase_f1)
xlabel('f/Hz'); ylabel('angle(A(jw))/degree');
hold on
% pade_my
plot(f,phase_f_my,'m')

% pade(2,2)
plot(f,phase_f2_2,'r')
% padeJL
plot(f,phase_f3,'g')
legend('exp(-sT)(f=1kHz)','pade my','pade(2,2)','padeJL')
title('phase vs. freq')

%--------------error-------------------------
error_f3=f3-f1;
error_f2=f2_2-f1;
error_f_my=f_my-f1;
figure(3)
subplot(2,1,1)
plot(f,abs(real(error_f3)),'b')
hold on
plot(f,abs(real(error_f2)),'g')
hold on
plot(f,abs(real(error_f_my)),'r')
legend('error LJ','error pade(2,2)','error pade my')
title('error real part')

subplot(2,1,2)
plot(f,abs(imag(error_f3)),'b')
hold on
plot(f,abs(imag(error_f2)),'g')
hold on
plot(f,abs(imag(error_f_my)),'r')
legend('error LJ','error pade(2,2)','error pade my')
title('error imag part')

figure(4)
plot(f,abs(amp_f1-amp_f3),'b')
hold on
plot(f,abs(amp_f1-amp_f2_2),'g')
hold on
plot(f,abs(amp_f1-amp_f_my),'r')
ylim([-0.01,0.01])
legend('error LJ','error pade(2,2)','error pade my')
title('error magnitude part')

figure(5)
plot(f,abs(phase_f1-phase_f3),'b')
hold on
% tmp=[length(w)/2-1, length(w)/2, length(w)/2+1];
% plot(tmp,abs(phase_f1(tmp)-phase_f2_2(tmp)),'o')
plot(f,abs(phase_f1-phase_f2_2),'g')
hold on
plot(f,abs(phase_f1-phase_f_my),'r')
legend('error LJ','error pade(2,2)','error pade my')
title('error phase part')



