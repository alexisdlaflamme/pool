Option Explicit

Dim xlApp 
Dim xlBook 
Dim dataFilePath 

dataFilePath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".") & "\Data\NHL\dataBaseStatsJoueur.xlsm"

Set xlApp = CreateObject("Excel.Application") 

   xlApp.Visible = False
   xlApp.DisplayAlerts = False
   xlApp.AskToUpdateLinks = False
   xlApp.AlertBeforeOverwriting = False


Set xlBook = xlApp.Workbooks.Open(dataFilePath) 
''xlBook.Run "UpdateData"

xlBook.RefreshAll
WScript.sleep 15000

xlBook.Save

xlApp.Quit 
Set xlBook = Nothing 
Set xlApp = Nothing 

