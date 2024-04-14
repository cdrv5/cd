%{
extern int word_count;
%}

%%
[a-zA-Z]+   { word_count++; }
.           ;
\n          { return word_count; }
%%

