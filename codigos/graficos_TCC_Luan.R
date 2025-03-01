####################################################
#Universidade Federal do Ceara
#Departamento de Estatistica e Matematica Aplicada
#Curso de Estatística
#Autor: Luan Sousa
#Orientador: Manoel Santos-Neto
####################################################
#**************************************************#
####################################################
#Pacotes necessários
library(ggplot2)
library(gridExtra)
library(dplyr)
####################################################
#--------------------------------------------------#
#Figura 3

# Gerando dados para regressão
x_reg <- seq(-3, 3, length.out = 20)
set.seed(20)
e <- rnorm(n= 20, 0, 2)
y_reg <- x_reg^2 + e
df_reg <- data.frame(x_reg, y_reg, e = e)

# Ajustando modelos
lm_under <- lm(y_reg ~ x_reg, data = df_reg)
lm_optimal <- lm(y_reg ~ I(x_reg^2) , data = df_reg)
lm_overfit <- lm(y_reg ~ poly(x_reg, 10) + e, data = df_reg)

# Gerando previsões
grid_reg <- data.frame(x_reg = seq(-3, 3, length.out = 100), e = e)
grid_reg$pred_under <- predict(lm_under, newdata = grid_reg)
grid_reg$pred_optimal <- predict(lm_optimal, newdata = grid_reg)
grid_reg$pred_overfit <- predict(lm_overfit, newdata = grid_reg)

# Plots de regressão
plot_reg <- function(pred_col, title) {
  ggplot(df_reg, aes(x_reg, y_reg)) +
    geom_point(size = 3) +
    geom_line(data = grid_reg, aes(x_reg, !!sym(pred_col)), color = "blue", size = 1) +
    labs(title = title, x="", y = "") +
    theme_minimal() + theme(
      plot.title = element_text(hjust = 0.5),
      axis.text = element_blank(),
      axis.ticks = element_blank()
    )
}


p6 <- ggplot(df_reg) + 
  geom_point(aes(x = x_reg, y= y_reg), size = 3) + 
  geom_line(aes(x = x_reg, y= y_reg), color = "blue", size = 1) +
  labs(title = "Sobreajuste \n (Muito bom para ser verdade)", x = "", y = "") + 
  theme_minimal() + theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )

p4 <- plot_reg("pred_under", "Sub-ajuste \n (Muito simples)")
p5 <- plot_reg("pred_optimal", "Ajuste ótimo")

# Exibindo todos os gráficos juntos
grid.arrange(p4, p5, p6, nrow = 1)
#--------------------------------------------------#
####################################################
####################################################
####################################################
#--------------------------------------------------#
#Figura 4

set.seed(9)
n <- 5
df <- data.frame(
  x1 = runif(n, 2, 3),
  x2 = runif(n, 2, 3),
  Classes = factor(rep(0:1, c(2,3)))
)


p1 <- ggplot(df, aes(x = x1, y = x2)) +
  geom_point(size = 3, color = "blue") +
  geom_point(aes(x = 2.1, y = 2.23), shape = 21, size = 6, fill = "yellow", color = "black") +
  annotate("text", x = 2.1, y = 2.23, label = "?") +
  labs(x = expression(x[1]), y = expression(x[2])) +
  theme_minimal()


p2 <- ggplot(df, aes(x = x1, y = x2, shape = Classes, color = Classes)) +
  geom_point(size = 3) +
  scale_shape_manual(values = c(15, 17)) +  # Quadrado para classe 0, triângulo para classe 1
  scale_color_manual(values = c("blue", "orange")) +
  geom_point(aes(x = 2.1, y = 2.23), shape = 21, size = 6, fill = "yellow", color = "black") +
  annotate("text", x = 2.1, y = 2.23, label = "?") +
  annotate("path", x = 2.15 + 0.2 * cos(seq(0, 2 * pi, length.out = 100)),
           y = 2.21 + 0.1 * sin(seq(0, 2 * pi, length.out = 100)), linetype = "dashed") +
  labs(x = expression(x[1]), y = expression(x[2])) +
  theme_minimal()  


grid.arrange(p1, p2, ncol = 2)
#--------------------------------------------------#
####################################################
####################################################
####################################################
#--------------------------------------------------#
#Figura 5

df_A <- data.frame(
  x = 1:10,
  y = rep(2, 10),
  category = c(rep("Azul", 4), rep("Amarelo", 6))
)

df_B <- data.frame(
  x = 1:10,
  y = rep(1, 10),
  category = c(rep("Azul", 3), rep("Amarelo", 3), rep("Verde", 4))
)

df <- rbind(df_A, df_B)

df$color <- factor(df$category, levels = c("Azul", "Amarelo", "Verde"))


ggplot(df, aes(x = x, y = y, fill = color, shape = color)) +
  geom_point(size = 10) +
  scale_fill_manual(values = c("Azul" = "blue", "Amarelo" = "yellow", "Verde" = "green")) +
  scale_shape_manual(values = c("Azul" = 21, "Amarelo" = 22, "Verde" = 23)) +
  labs(x = "", y = "") +
  theme_minimal() +
  theme(legend.position = "none",
        axis.text = element_blank(),
        axis.ticks = element_blank()) +
  annotate("text", x = 5.5, y = 1.5, label = "Seção B", size = 6) +
  annotate("text", x = 5.5, y = 2.5, label = "Seção A", size = 6) +
  annotate("text", x = 4, y = 2.25, label = "Maioria:\nPluralidade:", hjust = 0, size = 5) +
  annotate("text", x = 4, y = 1.25, label = "Maioria: Nenhum\nPluralidade:", hjust = 0, size = 5) +
  annotate("point", x = 6, y = 1.21, shape = 23, size = 6, fill = "green", color = "black") + 
  annotate("point", x = 6, y = 2.21, shape = 22, size = 6, fill = "yellow", color = "black") +
  annotate("point", x = 6, y = 2.29, shape = 22, size = 6, fill = "yellow", color = "black")


#--------------------------------------------------#
####################################################
####################################################
####################################################
#--------------------------------------------------#
#Figura 6
# Gerar dados simulados para as classes
set.seed(123)
class1 <- data.frame(x1 = rnorm(10, 3.2, 0.5), x2 = rnorm(10, 3.8, 0.5), class = "circle")
class2 <- data.frame(x1 = rnorm(10, 4, 0.5), x2 = rnorm(10, 3, 0.5), class = "triangle")
class3 <- data.frame(x1 = rnorm(10, 3, 0.25), x2 = rnorm(10, 3.5, 0.5), class = "plus")

data <- rbind(class1, class2, class3)

# Ponto a ser classificado
query_point <- data.frame(x1 = 3.6, x2 = 3.5)

# Contagem das classes
contagem_classes <- table(vizinhos$class)
classe_predita <- names(which.max(contagem_classes))

# Plotagem
p <- ggplot(data, aes(x = x1, y = x2)) +
  geom_point(aes(shape = class, color = class), size = 5) +
  scale_shape_manual(values = c("circle" = 16, "triangle" = 17, "plus" = 3)) +
  scale_color_manual(values = c("circle" = "blue", "triangle" = "purple", "plus" = "orange")) +
  geom_point(data = query_point, aes(x = x1, y = x2), shape = 1, size = 6, color = "black") +
  annotate("text", x = query_point$x1, y = query_point$x2 + 0, label = "?", size = 5) +
  annotate("text", 
           x = query_point$x1 + 0.7, 
           y = query_point$x2 - 0.18,
           label = paste("Predito\n", "? = "),
           hjust = 0, color = "black", size = 5) +
  labs(x = expression(x[1]), y = expression(x[2])) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_blank(),
    axis.ticks = element_blank(),
    legend.position="none"
  )

# Adicionar círculo de vizinhança ao redor do ponto de consulta
p + annotate("path",
             x = query_point$x1 + 0.38 * cos(seq(0, 2 * pi, length.out = 100)),
             y = query_point$x2 + 0.25 * sin(seq(0, 2 * pi, length.out = 100)),
             color = "black", linetype = "dashed")
#--------------------------------------------------#
####################################################
####################################################
####################################################
#--------------------------------------------------#
#Figura 7

# Função de custo (parábola simples para simular a curva)
cost_function <- function(w) (w - 3)^2 + 2

# Valores para os pesos
w_values <- seq(0, 6, length.out = 300)
j_values <- cost_function(w_values)

# Ponto inicial e gradiente
initial_weight <- 5
slope_at_initial <- 2 * (initial_weight - 3)

# A seta agora acompanha a inclinação da curva
gradient_line <- data.frame(
  x = c(initial_weight, initial_weight - 0.5),
  y = c(cost_function(initial_weight), cost_function(initial_weight) - 0.5 * slope_at_initial)
)

# Reta paralela à curva (reta tangente aproximada no ponto inicial)
paralela_x <- seq(initial_weight - 1, initial_weight + 1, length.out = 100)
paralela_y <- cost_function(initial_weight) + slope_at_initial * (paralela_x - initial_weight)
paralela_df <- data.frame(w = paralela_x, J = paralela_y - 0.2)

# Segunda reta paralela mais à direita
deslocamento <- 1.5
paralela2_x <- paralela_x + deslocamento
paralela2_y <- paralela_y
paralela2_df <- data.frame(w = paralela2_x, J = paralela2_y)

# Dados para o gráfico
data <- data.frame(w = w_values, J = j_values)
initial_point <- data.frame(w = initial_weight, J = cost_function(initial_weight) + 0.7)
global_min <- data.frame(w = 3, J = cost_function(3))

# Gradientes intermediários para sequência de setas
weights <- seq(initial_weight, 3, length.out = 5)
gradient_arrows <- data.frame(
  x = weights[-length(weights)]  ,
  y = cost_function(weights[-length(weights)]) + c(0.7, 0.3, 0.2, 0.1),
  xend = weights[-1] + c(0.1, 0.1, 0.1, 0.1) ,
  yend = cost_function(weights[-1] + 0.2)
)

# Plotagem
ggplot(data, aes(x = w, y = J)) +
  geom_line(color = "blue", size = 2) +
  geom_point(data = initial_point, aes(x = w, y = J), color = "black", size = 10) +
  geom_point(data = global_min, aes(x = w, y = J), color = "red", size = 3) +
  # geom_segment(data = gradient_line, aes(x = x[1], y = y[1], xend = x[2], yend = y[2]),
  #             arrow = arrow(type = "closed", length = unit(0.2, "cm")), linetype = "dashed") +
  geom_line(data = paralela_df, aes(x = w, y = J), color = "purple", linetype = "dashed", size = 2) +
  #geom_line(data = paralela2_df, aes(x = w, y = J), color = "green", linetype = "dotted") +
  geom_segment(data = gradient_arrows, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(type = "closed", length = unit(0.15, "cm")), color = "black", size = 1) +
  annotate("text", x = initial_weight-0.7, y = cost_function(initial_weight) + 1.2, label = "Peso Inicial", hjust = 0) +
  annotate("text", x = 2.5, y = cost_function(3) - 1, label = expression(paste(J[min](w), " : ","Custo mínimo global") ), hjust = 0, color = "red") +
  annotate("text", x = 5, y = cost_function(4.5), label = "Gradiente", angle = -35, vjust = -1, color = "purple") +
  labs(x = "w", y = expression(J(w))) +
  theme_minimal() +
  theme(
    plot.title = element_text(hjust = 0.5),
    axis.text = element_blank(),
    axis.ticks = element_blank()
  )
#--------------------------------------------------#
####################################################
####################################################
####################################################
#--------------------------------------------------#
#Figura 8 
# Dados para a curva logística
x_values <- seq(-10, 10, length.out = 500)
y_values <- 1 / (1 + exp(-x_values))  # Função logística

# Pontos verdes em y = 0 e y = 1
green_points_x <- seq(-10, -5, length.out = 15)

green_points_x1 <- seq(5, 10, length.out = 15)
green_points_y_0 <- rep(0, length(green_points_x))
green_points_y_1 <- rep(1, length(green_points_x))

# Construção do gráfico
ggplot() +
  # Curva logística
  geom_line(aes(x = x_values, y = y_values), color = "red", linewidth = 1) +
  # Pontos verdes
  geom_point(aes(x = green_points_x, y = green_points_y_0), color = "green", size = 3) +
  geom_point(aes(x = green_points_x1, y = green_points_y_1), color = "green", size = 3) +
  # Anotações
  annotate("text", x = -5, y = 0.5, label = "Curva em forma de S", color = "black", size = 5, angle = 0) +
  annotate("text", x = 1.5, y = 0.2, label = "Y estimado\n dentro do intervalo (0,1)", color = "red", size = 4) +
  # Limites dos eixos
  scale_y_continuous(breaks = c(0, 1), limits = c(-0.1, 1.1)) +
  scale_x_continuous(name = "Variável Independente (X)") +
  labs(y = "Variável Dependente (Y)") +
  theme_minimal() +
  theme(
    plot.title = element_text(size = 14, face = "bold"),
    axis.title = element_text(size = 12)
  )
#--------------------------------------------------#
####################################################
####################################################
####################################################
###################Extras###########################
#Gradiente Decendente                              #
####################################################
# Função de custo (parábola simples para simular a curva)
cost_function <- function(w) (w - 3)^2 + 2

# Valores para os pesos
w_values <- seq(0, 6, length.out = 300)
j_values <- cost_function(w_values)

# Ponto inicial e gradiente
initial_weight <- 5
slope_at_initial <- 2 * (initial_weight - 3)

# A seta agora acompanha a inclinação da curva
gradient_line <- data.frame(
  x = c(initial_weight, initial_weight - 0.5),
  y = c(cost_function(initial_weight), cost_function(initial_weight) - 0.5 * slope_at_initial)
)

# Reta paralela à curva (reta tangente aproximada no ponto inicial)
paralela_x <- seq(0, 1 + 1, length.out = 100)
paralela_y <- cost_function(1) + (-4) * (paralela_x - 1)
paralela_df <- data.frame(w = paralela_x, J = paralela_y - 0.2)

# Segunda reta paralela mais à direita
deslocamento <- 1.5
paralela2_x <- paralela_x + deslocamento
paralela2_y <- paralela_y
paralela2_df <- data.frame(w = paralela2_x, J = paralela2_y)

# Dados para o gráfico
data <- data.frame(w = w_values, J = j_values)
initial_point <- data.frame(w = initial_weight, J = cost_function(initial_weight) + 0.7)
global_min <- data.frame(w = 3, J = cost_function(3))

# Gradientes intermediários para sequência de setas
weights <- seq(initial_weight, 3, length.out = 5)
gradient_arrows <- data.frame(
  x = weights[-length(weights)]  ,
  y = cost_function(weights[-length(weights)]) + c(0.7, 0.3, 0.2, 0.1),
  xend = weights[-1] + c(0.1, 0.1, 0.1, 0.1) ,
  yend = cost_function(weights[-1] + 0.2)
)

# Plotagem
ggplot(data, aes(x = w, y = J)) +
  geom_line(color = "blue", size = 2) +
  geom_point(data=data.frame(x=1, y=7), aes(x = x, y =y), color = "black", size = 10) +
  geom_point(data = global_min, aes(x = w, y = J), color = "red", size = 3) +
  geom_segment(data = data.frame(x = c(1, 1.5), y = c(7,5)), aes(x = x[1], y = y[1], xend = x[2], yend = y[2]),
               arrow = arrow(type = "closed", length = unit(0.2, "cm")), linetype = "dashed") +
  geom_line(data = paralela_df, aes(x = w, y = J), color = "purple", linetype = "dashed", size = 2) +
  #geom_line(data = paralela2_df, aes(x = w, y = J), color = "green", linetype = "dotted") +
  geom_segment(data = gradient_arrows, aes(x = x, y = y, xend = xend, yend = yend),
               arrow = arrow(type = "closed", length = unit(0.15, "cm")), color = "black", size = 1) +
  annotate("text", x = initial_weight-0.7, y = cost_function(initial_weight) + 1.2, label = "Peso Inicial", hjust = 0) +
  annotate("text", x = 2.5, y = cost_function(3) - 1, label = expression(paste(J[min](w), " : ","Custo mínimo global") ), hjust = 0, color = "red") +
  annotate("text", x = 0.8, y = cost_function(1.5), label = "Gradiente", angle = -35, vjust = -1, color = "purple") +
  labs(x = "w", y = expression(J(w))) +
  theme_minimal() +
  theme(
  plot.title = element_text(hjust = 0.5),
  axis.text = element_blank(),
  axis.ticks = element_blank()
  )

####################################################
####################################################
####################################################
###################Extras###########################
#Regressao                                         #
####################################################
set.seed(42)
n <- 30

x <- runif(n, 0, 10)
y <- mapply(rnorm, n = 1, mean = 0.8 + 1.5*x, sd = 1)

df <- data.frame(
  x = x,
  y = y)

modelo_otimo <- lm(y ~ x, data = df)
coef_otimo <- coef(modelo_otimo)

set.seed(123)
modelos_iniciais <- data.frame( 
  intercepto <- c(coef_otimo[1] + 6/2, coef_otimo[1] + 5/2, coef_otimo[1] - 2/2,  coef_otimo[1] - 3/2,  coef_otimo[1] - 4/2),
  inclinacao <- c(coef_otimo[2] - 1.2/2, coef_otimo[2] - 1/2, coef_otimo[2] + 0.5/2, coef_otimo[2] + 0.7/2, coef_otimo[2] + 0.9/2))

p <- ggplot(df, aes(x = x, y = y)) +
  geom_point(shape = 1, size = 3, color = "blue") +  # Pontos de dados
  geom_abline(intercept = coef_otimo[1], slope = coef_otimo[2], color = "darkgreen", linewidth = 1.2) +  # Linha ótima
  geom_abline(data = modelos_iniciais, aes(intercept = intercepto, slope = inclinacao), color = "brown", linetype = "solid", size = 1) +  # Modelos iniciais
  annotate("text", x = 7.2, y = 16, label = "Ajuste aleatório inicial", size = 5) +
  annotate("text", x = 9.4, y = 14, label = "Ajuste Ótimo", color = "darkgreen", size = 5) +
  labs(x = "x", y = "Variável Alvo") +
  theme_minimal()

p
####################################################
####################################################
####################################################
####################################################


