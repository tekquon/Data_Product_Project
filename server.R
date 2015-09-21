##Author: Andrew Techmeier
library(shiny)
library(UsingR)
specify_decimal <- function(x, k) format(round(x, k), nsmall=k)
shinyServer(function(input, output) {
    data(fat)
    simpleRegression <- lm(body.fat ~ age + 
                               BMI + 
                               neck + 
                               chest + 
                               abdomen + 
                               hip + 
                               thigh + 
                               knee + 
                               ankle + 
                               bicep + 
                               forearm + 
                               wrist, data = fat)
    output$text <- renderText({
        calcBMI <- (input$weight / (input$height^2))*703.0704
        inputVals <- data.frame(age = input$age,
                                weight = input$weight,
                                height = input$height,
                                BMI = calcBMI,
                                neck = input$neck,
                                chest = input$chest,
                                abdomen = input$abdomen,
                                hip = input$hip, 
                                thigh = input$thigh, 
                                knee = input$knee, 
                                ankle = input$ankle, 
                                bicep = input$bicep, 
                                forearm = input$forearm, 
                                wrist = input$wrist)
        prediction <- predict(simpleRegression, inputVals, interval = "prediction")
        text <- paste0("Predicted body fat is ", specify_decimal(prediction[[1]], 2), "%. (95% CI: ", specify_decimal(prediction[[2]], 2), "% to ", specify_decimal(prediction[[3]], 2), "%)")
        text
    })
})
