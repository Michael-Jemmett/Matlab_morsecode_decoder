%%% Decoder %%%


morseEncoder
clear all;close all;clc;


[y, Fs] = audioread('encodedMessage1.wav');
info = audioinfo('encodedMessage1.wav');

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
Manual_Dot = 0;
Manual_Dash = 0;

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

i= i-1;

% Fixing the first high pulse and the last low pulse %
HighPulse(1) = HighPulse(1) - 1; 
%I dont think I need this part with a random timing variable being used

Dot = min(HighPulse);

Dash = max(HighPulse);



IntraLetter = min(LowPulse);
%LowPulse(i) = 0;
InterWord = max(LowPulse);

j = i - 1;
for i = 1:j
    if(LowPulse(i) ~= IntraLetter && LowPulse(i) ~= InterWord)
        InterLetter = LowPulse(i);
    end
end

if(InterLetter == 0)         %means that there is no space in the message sent
    InterLetter = InterWord;
    InterWord = 0;
end

for index = 1:length(HighPulse) %Building the decoded sentence
    if(HighPulse(index) == Dot) 
        Message = Message + '.';
    end
    if(HighPulse(index) == Dash)
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






