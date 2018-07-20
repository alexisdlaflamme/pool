install.packages("RDCOMClient", repos = "http://www.omegahat.net/R")

library(RDCOMClient)

# Open a specific workbook in Excel:
xlApp <- COMCreate("Excel.Application")
xlWbk <- xlApp$Workbooks()$Open("C:\\Temp\\macro_template.xlsm")

# this line of code might be necessary if you want to see your spreadsheet:
xlApp[['Visible']] <- TRUE 

# Run the macro called "MyMacro":
xlApp$Run("MyMacro")

# Close the workbook and quit the app:
xlWbk$Close(FALSE)
xlApp$Quit()

# Release resources:
rm(xlWbk, xlApp)
gc()