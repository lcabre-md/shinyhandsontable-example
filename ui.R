library(shiny)

sHOT <- function(id,showFirst=TRUE) {	#hot standsfor handsontable
	if(showFirst) {	
		tagList(		
			singleton(tags$head(tags$script(src ="jquery.handsontable.full.js" )))
			, singleton(tags$head(tags$link(rel="stylesheet", media="screen", href ="jquery.handsontable.full.css")))
			, singleton(tags$head(tags$script(src ="handsontable.js" )))		
			, div(class = "shinyhandsontable" ,id=id)		
			,tags$script(
				paste("console.log('hihi');$(document).find('#",id,".shinyhandsontable').handsontable()",sep="")
			)
		)
	} else {
		tagList(		
			singleton(tags$head(tags$script(src ="jquery.handsontable.full.js" )))
			, singleton(tags$head(tags$link(rel="stylesheet", media="screen", href ="jquery.handsontable.full.css")))
			, singleton(tags$head(tags$script(src ="handsontable.js" )))		
			, div(class = "shinyhandsontable" ,id=id)		
		)			
	}
}

# Define UI for application that plots random distributions 
shinyUI(basicPage(
  # Application title
  headerPanel("Handsontable Shiny Component!")
  , HTML("<p>Change the values in the table to see what happens.<br/>The table below will compute the average of the column above. <br/>The code is not perfect yet at least need to make the content native numeric. <br/>Work to be done.</p>")  
  # shinyhandsontable1
  ,sHOT("handsontable1",F)
  # shinyhandsontable2
  ,sHOT("handsontable2",F)
))
