%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
% Title  : Function to Convert a Letter to a Code
% Author : Ian van der Linde
% Date   : 15-10-13
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

function code = letterToCode(letter)

conversionTable{1}.letter = 'A';
conversionTable{1}.code = '.-';
conversionTable{2}.letter = 'B';
conversionTable{2}.code = '-...';
conversionTable{3}.letter = 'C';
conversionTable{3}.code = '-.-.';
conversionTable{4}.letter = 'D';
conversionTable{4}.code = '-..';
conversionTable{5}.letter = 'E';
conversionTable{5}.code = '.';
conversionTable{6}.letter = 'F';
conversionTable{6}.code = '..-.';
conversionTable{7}.letter = 'G';
conversionTable{7}.code = '--.';
conversionTable{8}.letter = 'H';
conversionTable{8}.code = '....';
conversionTable{9}.letter = 'I';
conversionTable{9}.code = '..';
conversionTable{10}.letter = 'J';
conversionTable{10}.code = '.---';
conversionTable{11}.letter = 'K';
conversionTable{11}.code = '-.-';
conversionTable{12}.letter = 'L';
conversionTable{12}.code = '.-..';
conversionTable{13}.letter = 'M';
conversionTable{13}.code = '--';
conversionTable{14}.letter = 'N';
conversionTable{14}.code = '-.';
conversionTable{15}.letter = 'O';
conversionTable{15}.code = '---';
conversionTable{16}.letter = 'P';
conversionTable{16}.code = '.--.';
conversionTable{17}.letter = 'Q';
conversionTable{17}.code = '--.-';
conversionTable{18}.letter = 'R';
conversionTable{18}.code = '.-.';
conversionTable{19}.letter = 'S';
conversionTable{19}.code = '...';
conversionTable{20}.letter = 'T';
conversionTable{20}.code = '-';
conversionTable{21}.letter = 'U';
conversionTable{21}.code = '..-';
conversionTable{22}.letter = 'V';
conversionTable{22}.code = '...-';
conversionTable{23}.letter = 'W';
conversionTable{23}.code = '.--';
conversionTable{24}.letter = 'X';
conversionTable{24}.code = '-..-';
conversionTable{25}.letter = 'Y';
conversionTable{25}.code = '-.--';
conversionTable{26}.letter = 'Z';
conversionTable{26}.code = '--..';
conversionTable{27}.letter = ' ';
conversionTable{27}.code = ' ';

currentRow = 1;

while(letter~=conversionTable{currentRow}.letter && currentRow<27)
    currentRow = currentRow + 1;
end

code = conversionTable{currentRow}.code;

end