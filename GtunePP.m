function note = GtunePP(f)
     key = int8(49 + 12*log2(f/440));
     switch(key)
          case{0,12,24,36,48,60,72,84}
               note = 'A_{b}';
          case{1,13,25,37,49,61,73,85}
               note = 'A';
          case{2,14,26,38,50,62,74,86}
               note = 'B_{b}';
          case{3,15,27,39,51,63,75,87}
               note = 'B';
          case{4,16,28,40,52,64,76,88}
               note = 'C';
          case{5,17,29,41,53,65,77}
               note = 'C#';
          case{6,18,30,42,54,66,78}
               note = 'D';
          case{7,19,31,43,55,67,79}
               note = 'E_{b}';
          case{8,20,32,44,56,68,80}
               note = 'E';
          case{9,21,33,45,57,69,81}
               note = 'F';
          case{10,22,34,46,58,70,82}
               note = 'F#';
          case{11,23,35,47,59,71,83}
               note = 'G';
          otherwise
               note = '-';
     end
end
