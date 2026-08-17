<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Transporte Urbano - Turista</title>
  <link rel="stylesheet" href="style.css">
</head>
<body>

  <div class="container">
    <section class="card config-card">
      <div class="form-group">
        <label for="select-lang" data-i18n="labelLang">Idioma / Language:</label>
        <select id="select-lang" onchange="mudarIdioma()">
          <option value="pt">Português</option>
          <option value="en">English</option>
          <option value="ja">日本語 (Japonês)</option>
        </select>
      </div>
    </section>

    <section id="painel-turista" class="card">
      <div class="header-admin">
        <h2 data-i18n="titleTurista">Painel do Turista</h2>
      </div>

      <div class="step-box">
        <button id="btn-gps" onclick="obterLocalizacao()" data-i18n="btnGps">📍 Ativar Localização Real</button>
        <p id="status-gps" class="status-text" data-i18n="statusGpsOff">Localização desativada.</p>
      </div>

      <div class="form-group" style="margin-top: 15px;">
        <label for="select-destino" data-i18n="lblEscolhaDestino">Selecione para onde quer ir:</label>
        <select id="select-destino" onchange="exibirOpcoesTransporte()">
          <option value="" data-i18n="optSelecione">-- Escolha um destino --</option>
        </select>
      </div>

      <div id="resultado-turista" class="hidden">
        <button id="btn-info-aviso" class="btn-info-destaque" onclick="alternarAvisos()">
          <span data-i18n="btnTextoInformacao">ℹ️ Informações e Avisos de Mudanças</span>
        </button>

        <div id="caixa-avisos" class="alerta-box hidden">
          <strong data-i18n="titleAvisos">⚠️ Informações Importantes:</strong>
          <p id="texto-aviso-exibido">Nenhum aviso cadastrado para esta linha.</p>
        </div>

        <h3 data-i18n="titleOpcoes" style="margin-top: 15px;">Opções Disponíveis:</h3>
        
        <div class="transporte-card">
          <span class="badge" data-i18n="lblTransp1">Transporte 1</span>
          <strong id="res-t1-nome">---</strong>
          <div class="info-data-horario">
            <span class="data-tag" id="res-t1-data">📅 --</span>
            <span class="horario-tag" id="res-t1-horario">⏱️ --:--</span>
          </div>
        </div>

        <div class="transporte-card">
          <span class="badge" data-i18n="lblTransp2">Transporte 2</span>
          <strong id="res-t2-nome">---</strong>
          <div class="info-data-horario">
            <span class="data-tag" id="res-t2-data">📅 --</span>
            <span class="horario-tag" id="res-t2-horario">⏱️ --:--</span>
          </div>
        </div>
      </div>
    </section>
  </div>

  <script src="turista.js"></script>
</body>
</html>
