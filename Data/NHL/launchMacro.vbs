Option Explicit

Dim xlApp 
Dim xlBook 
Dim dataFilePath 

dataFilePath = CreateObject("Scripting.FileSystemObject").GetAbsolutePathName(".") & "\dataBaseStatsJoueur.xlsm"

Set xlApp = CreateObject("Excel.Application") 

   xlApp.Visible = True
   xlApp.DisplayAlerts = False
   xlApp.AskToUpdateLinks = False
   xlApp.AlertBeforeOverwriting = False


Set xlBook = xlApp.Workbooks.Open(dataFilePath) 
''xlBook.Run "UpdateData"

xlBook.RefreshAll
WScript.sleep 20000

xlBook.Save

xlApp.Quit 
Set xlBook = Nothing 
Set xlApp = Nothing 

