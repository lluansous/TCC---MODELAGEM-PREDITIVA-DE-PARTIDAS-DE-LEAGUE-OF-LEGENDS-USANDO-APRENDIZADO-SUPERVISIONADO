# 🎮 Modelagem Preditiva de Partidas de *League of Legends* usando Aprendizado Supervisionado

Este estudo investiga a aplicação de modelos de **aprendizado supervisionado** para prever o resultado de partidas de *League of Legends*, um dos eSports mais populares do mundo.

Foram analisadas diferentes abordagens de *machine learning*, utilizando um conjunto de dados extraído do **Oracle’s Elixir**, com foco em variáveis estratégicas como **diferença de recursos no início da partida** e **escolhas de campeões**.

Os modelos com melhor desempenho foram:

- **Regressão Logística**
- **K-Nearest Neighbors (KNN)**

Com resultados expressivos, alcançando até **0.930 de AUC**, os modelos demonstraram alto poder preditivo e relevância prática para decisões em ambientes competitivos.

---

## ⚙️ Tecnologias e Metodologias Utilizadas

### 📊 Manipulação e Transformação de Dados

- **Bibliotecas:** `pandas`, `numpy`
- **Tarefas realizadas:**
  - Carregamento e limpeza de dados
  - Criação de variáveis derivadas (ex: diferenças de recursos)
  - Filtragem de metadados irrelevantes

---

### 🏗️ Pré-processamento e Engenharia de Features

- **Bibliotecas:** `scikit-learn`, `category_encoders`
- **Ferramentas:**
  - `ColumnTransformer`, `Pipeline`
  - `RobustScaler`: Escalonamento robusto para evitar distorções causadas por outliers
  - `OneHotEncoder`: Codificação de variáveis categóricas (ex: lado da equipe)
  - `TargetEncoder`: Codificação de alta cardinalidade (ex: picks e bans), evitando explosão dimensional

---

### 🤖 Modelagem Preditiva

- **Biblioteca:** `scikit-learn`
- **Modelos Avaliados:**
  - `LogisticRegression` (com regularização L2)
  - `KNeighborsClassifier`
  - `GradientBoostingClassifier`
  - `DecisionTreeClassifier`

---

### 📈 Validação e Avaliação de Desempenho

- **Técnicas de Validação:**
  - `GroupKFold` e `GroupShuffleSplit` (agrupamento por `gameid` para evitar vazamento entre treino/teste)

- **Métricas Utilizadas:**
  - `roc_auc_score`
  - `accuracy_score`
  - `f1_score`

---

### 📊 Visualização de Dados

- **Bibliotecas:** `matplotlib`, `plotnine`
- **Gráficos:**
  - Boxplots comparando variáveis antes e depois do escalonamento
  - Análises visuais de desempenho dos modelos

---

## ✅ Justificativas das Escolhas Técnicas

- **Scikit-learn:** Ideal para criação de pipelines reprodutíveis e integração entre etapas do projeto.
- **TargetEncoder:** Essencial para lidar com variáveis de alta cardinalidade (ex: campeões) sem inflar a dimensionalidade.
- **RobustScaler:** Mantém a integridade dos dados ao minimizar a influência de valores extremos.
- **Pipeline + ColumnTransformer:** Evitam vazamento de dados e permitem encapsulamento de etapas de forma limpa e modular.
- **GroupKFold:** Garante a independência entre conjuntos de treino e teste, evitando que a mesma partida apareça em ambos.

---

📌 *Este projeto visa não apenas alcançar precisão preditiva, mas também fornecer insights úteis para decisões estratégicas em cenários competitivos de eSports.*
