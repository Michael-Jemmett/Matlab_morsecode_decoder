%%% Decoder %%%

morseEncoder2
clear all;close all;clc;

[y, Fs] = audioread('encodedMessage2.wav');

flagcheck = 0;
i=1;
j=1;
n=1;
InitialHigh = 0;
InitialLow = 0;
HighPulse = [];
LowPulse = [];
HighPulseLength = 0;
LowPulseLength = 0;
AverageLowPulse = 0;
InterLetter = 0;
Message = "";
DecodedMessage = "";

l = length(y);

while(n ~= l)
    while(y(n) ~=0)
   
        if(y(n) > 0)
            n = n + 1;
        end
        if(y(n) == 0)
            HightoLowPulse = n;
            HighPulseLength = HightoLowPulse -InitialHigh;
            InitialLow = n;
        end
   
    end
   
    while(y(n) == 0 && flagcheck == 0)
           
        if(y(n) == 0)
            n = n + 1;
            if(n == l)
                flagcheck = 1;
            end    
        end
   
        if(y(n) > 0)
            LowPulseLength = n - InitialLow;
            InitialHigh = n;
        end
    end
    HighPulse(i) = HighPulseLength;
    LowPulse(i) = LowPulseLength;
    i = i + 1;
end
LowPulse(i-1) = n - (InitialLow - 1);
i= i-1;

% Fixing the first high pulse and the last low pulse %
HighPulse(1) = HighPulse(1) - 1; 

Dot = min(HighPulse);

Dash = max(HighPulse);

IntraLetter = min(LowPulse);

InterWord = max(LowPulse);

InterLetter = LowPulse(i);
if(Dot == Dash)
    if(Dot > InterLetter)
        TimeUnit = Dash/(Fs*4);
    end
    if(Dash < InterLetter)
        TimeUnit = Dot/(Fs*2);
    end 
    Dot = TimeUnit * 2 * Fs;
    Dash = TimeUnit * 4 * Fs;
    IntraLetter = TimeUnit * 1 * Fs;
    InterWord = (TimeUnit * 4 * Fs) + InterLetter;
end

if(InterLetter == InterWord)         %means that there is no space in the message sent
     InterWord = 0;
end

j = length(HighPulse);
%HighPulse(j+1) = 0;
for index = 1:length(HighPulse) %Building the decoded sentence
    if(HighPulse(index) < Dash*0.7) 
        Message = Message + '.';
    
    else
        Message = Message + '-';
    end
    
    if LowPulse(index) ~= IntraLetter
        DecodedMessage = DecodedMessage+codeToLetter(Message);
        Message = "";
    end
    if LowPulse(index) == InterWord
            DecodedMessage = DecodedMessage + ' ';
    end
    
end

DecodedMessage

T_ime = 1/Fs:1/Fs:length(y)/Fs;         %period of the original signal

Fs = 900;
signal=sin(2*pi*Fs*T_ime);

for i=1:length(y)
    x(i)=y(i)*signal(i);
end
%sound(x, (3.5*8000), 16);
