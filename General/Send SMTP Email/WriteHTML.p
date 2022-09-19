/* ------------------------------------------------------------------------

                            Raphael Frei - 2022

                          SEND SMTP - HTML EMAILS
                                GUIDE SHEET

------------------------------------------------------------------------ */

// Variáveis de Entrada
DEFINE INPUT PARAM otptFile AS CHAR NO-UNDO.
DEFINE INPUT PARAM reasonWr AS CHAR NO-UNDO.
DEFINE INPUT PARAM errorWr  AS CHAR NO-UNDO.

DEFINE VARIABLE txtString   AS CHAR NO-UNDO.

DEFINE VARIABLE cStr        AS CHAR NO-UNDO.

ASSIGN cStr = PROGRAM-NAME(1) 
       cStr = SUBSTRING(cStr, INDEX(cStr,'_') + 1, -1)
       cStr = REPLACE(cStr, ".ped", ".p").

OUTPUT TO VALUE (otptFile).

PUT UNFORMATTED
    //Cabeçalho

    '<TABLE cellSpacing=0 cellPadding=0 border=0 width="80%">' 

    //Topo
    '<TR>'
    '<TD colspan="2" class="">'
	'<H2>PC Control Warning - (' TODAY ' ' STRING(TIME, "hh:mm:ss") ')<H2>'
    '</TD>'
    '</TR>'
    '<TR>'
	'<TD class="topline" colspan="2" align="left">&nbsp;'
    '</TD>'
    '</tr>'
    '<tr>' 
	'<td colspan="2">' 
    '<span class="info"><!--Comments go here--></span>'
    '</TABLE>'
    '</td>'
    '</tr>'
    '<hr>'

    //Corpo
    '<h3><span style="font-weight:bold;">An error has occured on: <span style="font-weight:normal;">' reasonWr '</h3>'
    '<h4><span style="font-weight:normal;">' errorWr '</h4>'

    //Fim
    '<hr>'
    '<TR>'
	'<TD colspan="2" vAlign=top noWrap>&nbsp;</TD>'
    '</TR>'
    '<h7><span style="font-weight:normal;">Report written by ' cStr '</h7>'
    .

OUTPUT CLOSE.
