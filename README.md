---------------------------------------------------------------------------------------------------
#___________MODELAGEM PREDITIVA DE PARTIDAS DE LEAGUE OF LEGENDS USANDO APRENDIZADO SUPERVISIONADO_________#

Este estudo investiga a aplicação de modelos de aprendizado supervisionado para prever o
resultado de partidas de League of Legends, um dos esportes eletrônicos mais populares do
mundo. Foram analisadas diferentes abordagens, incluindo K-Nearest Neighbors (KNN),
Regressão Logística, Gradient Boosting e Árvores de Decisão, utilizando um conjunto de
dados extraído do Oracle’s Elixir. A metodologia envolveu a seleção criteriosa de variáveis, a
eliminação de metadados irrelevantes e a validação dos modelos por meio de métricas como
AUC-ROC e acurácia. Os resultados indicam que a Regressão Logística e o KNN obtiveram o
melhor desempenho, com AUC de até 0,930, demonstrando alta capacidade preditiva. Além da
precisão dos modelos, o estudo destaca a importância de variáveis estratégicas, como diferenças
de recursos no início da partida e escolhas de campeões, para a tomada de decisões em contextos
competitivos.
---------------------------------------------------------------------------------------------------
Categoria Detalhes
Manipulação e Transformação - Bibliotecas: Pandas e NumPy.
- Ações: Carregamento, filtragem e criação
de variáveis de diferença.
Pré-processamento e Engenharia de Featu-
res
- Biblioteca: Scikit-learn.
- Ferramentas: ColumnTransformer e
Pipeline.
- Técnicas: Escalonamento e codificação.
- RobustScaler: Escalonamento robusto de
features numéricas.
- OneHotEncoder: Codificação de variáveis
categóricas (ex: side).
- Biblioteca adicional: Category Encoders.
- TargetEncoder: Codificação de variáveis
de alta cardinalidade (ex: picks e bans).
Modelagem - Biblioteca: Scikit-learn.
---------------------------------------------------------------------------------------------------
- Algoritmos:
GradientBoostingClassifier (bo-
osting), LogisticRegression (mo-
delos lineares com regularização L2),
KNeighborsClassifier (classificação por
proximidade), DecisionTreeClassifier
(árvores de decisão CART e ID3).
Validação - Técnicas: GroupShuffleSplit e
GroupKFold (divisão estratificada e
agrupada por gameid).
---------------------------------------------------------------------------------------------------
- Métricas: roc_auc_score,
accuracy_score, f1_score.
Visualização - Biblioteca: Matplotlib e Plotnine.
- Gráficos: Boxplots comparativos antes e
depois do escalonamento.
Justificativas de Escolha - Scikit-learn: Eficiência em pipelines repro-
dutíveis e integração entre pré-processamento
e modelagem.
---------------------------------------------------------------------------------------------------
- TargetEncoder: Evita explosão dimensio-
nal em variáveis de alta cardinalidade.
- RobustScaler: Preserva integridade das
diferenças de recursos sem distorções por va-
lores extremos.
- Pipeline e ColumnTransformer: Encap-
sulam etapas de pré-processamento e modela-
gem, evitando vazamento de dados.
- GroupKFold: Assegura que partidas não
sejam divididas entre treino e teste, mantendo
a independência dos dados.
