% Membuka file data
load data3.txt

% Memilih kolom data Linear Acceleration X
acc_x3 = data3(:,2)

% Low Pass Filter
d = designfilt('lowpassfir', 'PassbandFrequency',0.25, 'StopbandFrequency',0.35,'PassbandRipple',0.5,'StopbandAttenuation',65,'DesignMethod','kaiserwin')
y3 = filtfilt(d, acc_x3)

% Mencari peaks y3 dengan threshold 0.06
ismax = islocalmax(y3, 'MinProminence',0.06)

% Menampilkan hasil peaks
clf
plot(y3,'Color',[109 185 226]/255,'DisplayName','Input data')
hold on

% Menampilkan plot dan peaks y3
plot(find(ismax),y3(ismax),'^','Color',[217 83 25]/255,'MarkerFaceColor',[217 83 25]/255,'DisplayName','Peaks')
title(['Data 3 Peaks'])
hold off
legend
xlabel('miliseconds')
ylabel('milivolts')

xlim([4000 4300])
ylim([-0.1 0.1])

% Menghitung nilai bpm
maxIndices = find(ismax)
msPerBeat = mean(diff(maxIndices))
heartRateY3 = 60*(1000/msPerBeat)
bpm = (heartRateY3 / 1000) * 60
fprintf('data 3 bpm = ')
disp(bpm)
