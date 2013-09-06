library(shiny)
library(RJSONIO)
library(plyr)

renderHandsontable <- function(expr, env = parent.frame(), quoted = FALSE) {
	func <- shiny::exprToFunction(expr, env, quoted)
	
	function() {		
		df <- func() # the dataframe returned    
		if(is.null(df)) return()
		#browser()  
		colnames(df) <- gsub("\\.","_",colnames(df))
		json <- NULL
		json$data <-t(t(df))
		#json$readOnly <- TRUE
		json$colHeaders <-colnames(df)
		
		# cn <- paste('data:"',colnames(df),'"',sep="")
		# cnn <- paste(cn,readonly.col,sep="")
# 		columns <- NULL
# 		for(i in 1:10) {
# 			if(i == 4) {
# 				columns[[i]] <- list(data=colnames(df)[i],readOnly=FALSE)
# 			} else {
# 				columns[[i]] <- list(data=colnames(df)[i],readOnly=TRUE)
# 			}
# 		}
		#browser()
# 		json$columns <- columns
#		json$multiSelect <- TRUE
#		json$fillHandle  <- FALSE
		#json$contextMenu  <- FALSE    
		toJSON(json)
	}
}


# Define server logic required to generate and plot a random distribution
shinyServer(function(input, output) {
  
  output$handsontable1 <- renderHandsontable({
	head(iris)
  })
  
  output$handsontable2 <- renderHandsontable({
  	if (is.null(input$handsontable1)) return()
  	#print("got data")  	
  	df <- input$handsontable1
  	#browser()
  	df.proper <- matrix(df,ncol=5,byrow=TRUE)
  	
  	
  	data.frame(
  		avg_Sepal_Length = mean(as.numeric(df.proper[,1]))
  		,avg_Width_Length = mean(as.numeric(df.proper[,2]))
  		,avg_Petal_Length = mean(as.numeric(df.proper[,3]))
  		,avg_Petal_Width = mean(as.numeric(df.proper[,4]))
  	)
  	#browser()
  	
  })
  
})
