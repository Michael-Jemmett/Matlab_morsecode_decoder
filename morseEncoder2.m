%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title  : Pulse Morse Encoder
% Author : Ian van der Linde
% Date   : 15-10-13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

clear all;close all;clc;

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Define Program Constants
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

SAMPLE_RATE   = 8000;

TIME_UNIT     = 0.2;
DIT_DURATION  = TIME_UNIT*2;
DAH_DURATION  = TIME_UNIT*4;
ILI_DURATION1 = TIME_UNIT*1; % intra-Letter interval
ILI_DURATION2 = TIME_UNIT*2; % inter-Letter interval
IWI_DURATION  = TIME_UNIT*4; % inter-Word interval

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Create Pulse Components for Stitching Together
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

dit  = ones (1, SAMPLE_RATE*DIT_DURATION);
dah  = ones (1, SAMPLE_RATE*DAH_DURATION);
ili1 = zeros(1, SAMPLE_RATE*ILI_DURATION1);
ili2 = zeros(1, SAMPLE_RATE*ILI_DURATION2);
iwi  = zeros(1, SAMPLE_RATE*IWI_DURATION);

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Ask User for Message 
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

textToEncode    = input('Enter Text to Encode: ', 's'); % Get User Input

textToEncode    = upper(textToEncode); % Make UPPER CASE

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Main Loop: Encode Message (Build Pulse Wave)
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

outputPulse     = [];
messageDuration = 0;

for currentCharacter=1:length(textToEncode)
    if(textToEncode(currentCharacter)>='A' && textToEncode(currentCharacter)<='Z')
        currentCode = letterToCode(textToEncode(currentCharacter));
        fprintf(1, textToEncode(currentCharacter));
        for currentCodePosition=1:length(currentCode)
            if(currentCode(currentCodePosition)=='.')
                RandomValue = 1+rand()/5;       %makes a random -+ 20%
                RandomDotLength = floor(length(dit)*RandomValue); %randomises the length of the dot
                RandomDotPulse = ones(1,RandomDotLength);
                outputPulse = [outputPulse RandomDotPulse ili1];
                messageDuration = messageDuration + DIT_DURATION + ILI_DURATION1;
                fprintf(1, '.');
            else
                RandomValue = 1+rand()/5;       %makes a random -+ 20%
                RandomDashLength = floor(length(dah)*RandomValue); %randomises the length of the dot
                RandomDashPulse = ones(1,RandomDashLength);
                outputPulse = [outputPulse RandomDashPulse ili1];
                messageDuration = messageDuration + DAH_DURATION + ILI_DURATION1;
                fprintf(1, '-');
            end
        end
        outputPulse = [outputPulse ili2];
        messageDuration = messageDuration + ILI_DURATION2;
    else
        outputPulse = [outputPulse iwi];
        messageDuration = messageDuration + IWI_DURATION;
        fprintf(1, '\n');
    end
end

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Store Encoded Pulse Wave to Disk
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% wavwrite(outputPulse, SAMPLE_RATE, 8, 'encodedMessage.wav');
audiowrite('encodedMessage2.wav', outputPulse, SAMPLE_RATE);
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Plot a Graph Showing hte Encoded Pulse Wave
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

figure;

t = 0:1/SAMPLE_RATE:messageDuration*2;
plot(t(1:length(outputPulse)), outputPulse, 'r', 'LineWidth', 2);
ylabel('Amplitude', 'FontSize', 14);
xlabel('Time (s)', 'FontSize', 14);
ylim([0 1.5]);
xlim([0 messageDuration]);
title('Morse Pulse Wave', 'FontSize', 14);

%wavwrite(outputPulse, SAMPLE_RATE, 8, 'encodedMessage.wav');
