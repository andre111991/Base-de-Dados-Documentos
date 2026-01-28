-- Listar todas as vagas livres por andar
SELECT andar, id_vaga, tipo 
FROM Vaga 
WHERE estado = 'livre'
ORDER BY andar ASC;

-- Contagem total de vagas ocupadas vs livres
SELECT estado, COUNT(*) as total
FROM Vaga
GROUP BY estado;

--identificação carro eletrico ou combustao 

SELECT 
    id_veiculo,
    matricula,
    combustível,
    CASE 
        WHEN combustível IN ('Elétrico', 'Híbrido Plug-in', 'VE') THEN 'Elétrico'
        ELSE 'Combustão/Normal'
    END AS categoria_veiculo
FROM Veiculo;

-- Encontrar vagas de carregamento (VE) que estão atualmente livres
SELECT id_vaga, andar 
FROM Vaga 
WHERE tipo = 'VE' AND estado = 'livre';

-- Histórico de consumo de energia por veículo
SELECT id_veiculo, SUM(energia_consumida) as total_kwh
FROM Carregamento
GROUP BY id_veiculo;

-- Calcular a taxa de ocupação total (em percentagem)
SELECT 
    (COUNT(CASE WHEN estado = 'ocupada' THEN 1 END) * 100.0 / COUNT(*)) AS taxa_ocupacao_percent
FROM Vaga;

-- Taxa de desocupação total (em percentagem)
SELECT 
    COUNT(*) AS total_vagas,
    SUM(CASE WHEN estado = 'livre' THEN 1 ELSE 0 END) AS vagas_livres,
    ROUND((SUM(CASE WHEN estado = 'livre' THEN 1 ELSE 0 END) * 100.0) / COUNT(*), 2) AS taxa_desocupacao_percent
FROM Vaga;

-- Valor total faturado por método de pagamento
SELECT metodo_pagamento, SUM(valor) as total_recebido
FROM Pagamento
GROUP BY metodo_pagamento;

-- Análise de transações por método de pagamento
SELECT 
    metodo_pagamento, 
    COUNT(*) AS total_transacoes, 
    SUM(valor) AS total_faturado
FROM Pagamento
GROUP BY metodo_pagamento
ORDER BY total_faturado DESC;

-- Histórico de pagamentos realizados por utilizadores
SELECT 
    u.nome AS nome_utilizador,
    p.valor,
    p.metodo_pagamento,
    p.data_pagamento,
    r.id_reserva
FROM Pagamento p
JOIN Reserva r ON p.id_reserva = r.id_reserva
JOIN Utilizador u ON r.id_utilizador = u.id_utilizador
ORDER BY p.data_pagamento DESC;

-- Calcular o valor estimado de cada reserva concluída (tarifa fixa de 2.00 por hora)
SELECT 
    r.id_reserva,
    u.nome AS cliente,
    r.data_hora_inicio,
    r.data_hora_fim,
    -- Calcula a diferença em horas e multiplica pela tarifa
    ROUND(TIMESTAMPDIFF(MINUTE, r.data_hora_inicio, r.data_hora_fim) / 60 * 2.00, 2) AS valor_estimado
FROM Reserva r
JOIN Utilizador u ON r.id_utilizador = u.id_utilizador
WHERE r.data_hora_fim IS NOT NULL;

-- Consultar todas as reservas ativas de um utilizador específico (ex: id 1)
SELECT r.id_reserva, v.andar, v.id_vaga, r.data_hora_inicio
FROM Reserva r
JOIN Vaga v ON r.id_vaga = v.id_vaga
WHERE r.id_utilizador = 1 AND r.data_hora_fim IS NULL;

-- Total de energia gerada pelos painéis nos últimos 7 dias
SELECT SUM(potencia_gerada) as total_energia_gerada
FROM PainelSolar
WHERE data_registo >= DATE_SUB(CURDATE(), INTERVAL 7 DAY); //substraçao  de datas, pega na data atual e subtrai 7 dias
                                                        // da os dados apartir de 7 dias atras apartir de hoje