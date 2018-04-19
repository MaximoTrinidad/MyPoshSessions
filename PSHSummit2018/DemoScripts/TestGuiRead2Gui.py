###########################################################################
## - TestGuiRead2Gui.py
## - Author: Maximo Trinidad, 06/15/2017
## - Comment: Block of code will read a CSV file to be display to a GUI.
###########################################################################

from tkinter import *
import csv
import sys

## - Prepare GUI envelope:
root = Tk()

## - Open CSV file from folder location:
with open(str(sys.argv[1]), mode='r') as csvfile:
    
    ## - Created Title for GUI application:
    root.title("LittleGridView - " + sys.argv[1])
    
    ## - Loads CSV file:
    csvdata = csv.reader(csvfile, delimiter=',', quotechar='"')

    ## - Reading CSV data from memory:
    for i, rec in enumerate(csvdata, 0):
        col = 0

        ## - For loop for each column(s) found:
        for c in rec:

            ## - Adjust columns default values:
            if col == 0:
                colWidth = 15
            else:
                colWidth = 15
            
            ## - Font Section:
            if i == 0:
                myFg = 'White'
                myBg = 'Black'
            else:
                myFg = 'Black'
                myBg = 'Yellow'

            ## - Build the datagrid:
            Label(root, text=c.replace('"', '').replace('ï»¿', ''), bg = myBg, fg = myFg, relief=RIDGE, width=colWidth, anchor=W).grid(row=i, column=col)
            col = col + 1
        
        ## - Stop displaying record limited to 20 rows:
        if i == 20:
            #resp = input('Enter Y to Continue: ')
            break

root.mainloop()

##
## cd /mnt/c/Scripts/
## Python Only - readfile parameter:
## - In Linux=> python /home/maxt/Scripts/TestGuiRead2Gui.py '//mnt//c//Temp//nonSMO_Data.csv'
## - In PowerShell Core Win10: => python C:\Scripts\TestGuiRead2Gui.py 'C:\Temp\nonSMO_Data.csv' 
##