library(learnr)
library(ggplot2)
library(ggfortify)
library(nortest)
library(lmtest)


## Regresión Lineal Simple
#
# La idea del modelo de regresión lineal simple es ajustar una linea recta a una _nube_ de puntos, los cuales están dados de la forma $(y_1,x_1),...,(y_n,x_n)$ donde $y$ es la variable respuesta y $x$ es la variable regresora.
#
### El problema de las facturas
#
# El gerente del departamento de _callcenter_ de una compañía desea modelar el número de llamadas recibidas con respecto al tiempo.
#
# Se ha recolectado, durante un periodo de 23 meses, la información sobre el número de llamadas recibidas.
#
# Escriba el código necesario para hacer un gráfico de dispersión entre los meses y el número de llamadas recibidas.
#
# N.B. El dataframe con los datos se llama `callcenter` y las variables `calls`, `month`.
#
## ---- point-plot ----------------------------------------------------------------------------------------
# library(ggplot2)



#
## ---- linear-relationship -------------------------------------------------------------------------------
#¿El gráfico sugiere la existencia de una relación lineal entre las variables?",



#
# Calcule la correlación entre las dos variables:
#
## ---- correlation ---------------------------------------------------------------------------------------



#
# La gráfica de dispersión indica una *posible* relación lineal entre el número de llamadas recibidas y el tiempo.
#
# La correlación de `r cor(callcenter$calls, callcenter$month)` indica una __fuerte__ relación lineal __negativa__ entre el número de llamadas recibidas y el tiempo.
#
# De acuerdo con esto pensamos que tiene sentido emplear un modelo de __regresión lineal simple__.
#
## Ajuste del modelo
#
# Complete el código para ajustar un modelo de regresión lineal simple e imprimir un resumen del mismo:
#
## ---- simple-lm -----------------------------------------------------------------------------------------
modelo <- lm()

summary()

#
# N.B. En adelante el modelo ajustado se llamara `modelo` y deberá usarse con ese nombre en los ejercicios que hagan referencia al mismo.
#
## ---- significative-params ------------------------------------------------------------------------------
#"De acuerdo a los resultados, ¿considera que la variable de tiempo puede axplicar adecuadamente el número de llamadas recibidas?",


#
# Recordemos que la prueba de hipótesis para los parámetros se establece de la siguiente manera:
#
# $$H_0: \beta_i =0 \ \ vs \ \ H_1:\beta_i \neq 0$$
#
# Por lo tanto observar p-values _pequeños_ significa que los datos observados son poco _compatibles_ con la hipótesis nula.
#
# Es decir, se tiene estadísticamente que $\beta_0 \neq0$ y $\beta_1 \neq0$, es decir $\beta_0$ y $\beta_1$ son parámetros __significativos__. Lo cual se traduce a que la variable de tiempo es útil para explicar el número de llamadas recibidas.
#
# Obtenga la $R^2$ del modelo.
#
## ---- lm-r2 ---------------------------------------------------------------------------------------------



# **Hint:** El summary del modelo es una lista que contiene los diferentes elementos que se muestran al imprimirlo.
#
#
# Recordemos que, geométricamente, el problema de regresión lineal consiste en ajustar un hiperplano a una nube de puntos, es decir, el modelo resultante es una simplificación del fenómeno real.
#
# __¿Qué tan buena es esta simplificación?__
#
# Una forma de evaluarla es comparar la varianza del modelo y la varianza de los datos observados, si éstas son similares significa que el modelo simplifica _adecuadamente_ al fenomeno real, más aún, la similitud entre las varianzas indica que tan lineal es la relación entre la(s) variable(s) explicativa(s) y la variable de respuesta.
#
# La $R^2$ es la métrica que compara las varianza del modelo y de los datos. Por su definición, esta métrica toma valores entre 0 y 1. Mientras más cercana a 1 sea mejor es el modelo, sin embargo, una $R^2$ _demasiado alta_ es señal de alarma pues indicaría una relación lineal perfecta.
#
# __¿Qué interpretación tiene el observar una relación lineal perfecta?__
#
# Los resultados, hasta el momento, indican que el modelo de __regresión lineal simple__ podría modelar adecuadamente la relación entre llamadas y el tiempo.
#
# Obtenga los intervalos de confianza para los parámetros del modelo:
#
## ---- param-confidence ----------------------------------------------------------------------------------


#
# **Hint:** Haga uso de la función confint().
#
#
# El modelo propuesto queda entonces como: `r sprintf("calls = %s %s*month", round(modelo$coefficients[1], 2), round(modelo$coefficients[2], 2))`
#
# __Ajuste del modelo__
#
# Haga un gráfico de dispersión de las variables junto con el modelo ajustado usando ggplot:
#
## ---- plot-model ----------------------------------------------------------------------------------------


#
# **Hint:** La función geom_abline() permite agregar una linea recta con pendiente e itersección dados.
#
#
# ## Validación gráfica de supuestos
#
# Para confirmar que el modelo propuesto es adecuado para _explicar_ el número de llamadas dado el mes, debemos __validar los supuestos__ del mismo.
#
# Corra el siguiente código para imprimir los 4 gráficos básicos de validación del modelo:
#
## ---- diagnose-plots ------------------------------------------------------------------------------------
# library(ggplot2)
# library(ggfortify)

autoplot()

#
#
# Complete el código siguiente para mostrar solamente el gráfico de escala-ubicación (scale-location):
#
## ---- scale-location ------------------------------------------------------------------------------------
# library(ggplot2)
# library(ggfortify)

autoplot()[[]]+
  theme_

#
# Si el modelo lineal es adecuado, debería observar un comportamiento __aleatorio__ en los residuales estandarizados, ¿por qué?
#
# Complete el código siguiente para mostrar el gráfico cuantil-cuantil (qqplot) de los residuales estandarizados:
#
## ---- qqplot --------------------------------------------------------------------------------------------
# library(ggplot2)
# library(ggfortify)

autoplot()[[]]+
  theme_

#
# Uno de los supuestos del modelo es que los residuales deben seguir una distribución Normal, ¿cónsidera que este supuesto se cumple?
#
## Validación teórica de supuestos
#
# Aunque las validaciones gráficas son muy útiles para determinar rápidamente si nuestro modelo cumple con los supuestos éstas no representan una prueba fehaciente, por lo cual debemos cerciorarnos usando pruebas estadísticas diseñadas para validar alguna hipótesis.
#
# __Normalidad__
#
# Complete el código para realizar la prueba Anderson-Darling de normalidad para los residuales:
#
## ---- resid-norm ----------------------------------------------------------------------------------------
# library(nortest)
ad.test(rstandard())

#
# Escriba las hipótesis de esta prueba, ¿qué conclusión indica el p-value?
#
# __Varianza constante__
#
# Complete el código para aplicar la prueba Breusch-Pagan de heterocedasticidad para el modelo:
#
## ---- hetero-test ---------------------------------------------------------------------------------------
# library(lmtest)
bptest()

#
# Escriba las hipótesis de esta prueba, ¿qué conclusión indica el p-value?
#
# __No correlación de residuales__
#
# Complete el código para aplicar la prueba Durbin-Watson de autocorrelación de residuales:
#
## ---- autocor -------------------------------------------------------------------------------------------
# library(lmtest)
dwtest()

#
# Escriba las hipótesis de esta prueba, ¿qué conclusión indica el p-value?
#
# ¿Qué conclusiones obtiene de estas pruebas?
#
# __Ejercicio de programación:__ Construya una función en R que realice todas las pruebas y que imprima orientación sobre la lectura adecuada de las mismas.
#

## Predicciones
#
# Complete el código siguiente para crear un gráfico de los datos observados, el modelo, el intervalo de confianza del ajuste y el intervalo de confianza del modelo:
#
## ---- final-plot ----------------------------------------------------------------------------------------
# library(ggplot2)

pred_inter <- as.data.frame(predict(, interval = "prediction"))
conf_inter <- as.data.frame(predict(, interval = "confidence"))

ggplot(callcenter, aes(month))+
  geom_line(aes(y = , colour = "Observed"))+
  geom_line(aes(y = conf_inter$, colour = "Confidence Interval"))+
  geom_line(aes(y = conf_inter$, colour = "Confidence Interval"))+
  geom_line(aes(y = pred_inter$, colour = "Prediction Interval"))+
  geom_line(aes(y = pred_inter$, colour = "Prediction Interval"))+
  geom_abline(aes(slope = m$coefficients[], intercept = m$coefficients[], colour = "Model Fit"))+
  theme_minimal()

#
# Complete el código para predecir las llamadas de los siguientes 7 meses y graficarlas con los datos observados y el modelo ajustado.
#
## ---- pred-plot -----------------------------------------------------------------------------------------
# library(ggplot2)

preds <- data.frame(month = 1:30,
                    calls_pred = predict( , data.frame(month = c(1:))),
                    calls_obser = c(callcenter$calls, rep(NA, 7)),
                    model_fit = c( $fitted.values, rep(NA, 7)))

ggplot(preds, aes(month))+
  geom_line(aes(y = , colour = "Observed Calls"))+
  geom_line(aes(y = , colour = "Fitted Model"))+
  geom_point(aes(y =, colour = "Predicted Calls"))+
  theme_minimal()

#
