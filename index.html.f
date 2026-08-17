<!DOCTYPE html>
<html lang="pt-BR">
<head>
  <meta charset="UTF-8">
  <meta name="viewport" content="width=device-width, initial-scale=1.0">
  <title>Transporte Urbano - Funcionário Público</title>
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

    <section id="painel-login" class="card">
      <h2 data-i18n="titleLogin">Acesso do Funcionário</h2>
      
      <div class="form-group">
        <label data-i18n="lblEmail">E-mail de Usuário:</label>
        <input type="email" id="login-email" placeholder="seuemail@prefeitura.gov.br">
      </div>

      <div class="form-group">
        <label data-i18n="lblSenha">Senha:</label>
        <input type="password" id="login-senha" placeholder="••••••••">
      </div>

      <button onclick="autenticarFuncionario()" data-i18n="btnEntrar">Entrar / Cadastrar Senha</button>
    </section>

    <section id="painel-funcionario" class="card hidden">
      <div class="header-admin">
        <h2 data-i18n="titleAdmin">Painel do Funcionário</h2>
        <button onclick="deslogar()" class="btn-sair" data-i18n="btnSair">Sair 🚪</button>
      </div>
      
      <p class="desc-text" data-i18n="descAdmin">Adicione ou atualize os dados do transporte abaixo:</p>

      <div class="form-group">
        <label data-i18n="lblNomeRua">Nome da Rua / Ponto:</label>
        <input type="text" id="admin-rua" placeholder="Ex: Av. Central">
      </div>

      <div class="form-group">
        <label data-i18n="lblNomeTransp">Nome do Transporte (PT):</label>
        <input type="text" id="admin-transp-nome" placeholder="Ex: Linha 101 - Centro">
      </div>

      <div class="form-group">
        <label data-i18n="lblNomeTranspEn">Nome do Transporte (EN):</label>
        <input type="text" id="admin-transp-nome-en" placeholder="Ex: Line 101 - Downtown">
      </div>

      <div class="form-group">
        <label data-i18n="lblNomeTranspJa">Nome do Transporte (JA):</label>
        <input type="text" id="admin-transp-nome-ja" placeholder="Ex: 101号線 - 中心部">
      </div>

      <div class="form-row">
        <div class="form-group flex-1">
          <label data-i18n="lblDiaSemana">Dia da Semana:</label>
          <select id="admin-transp-diasemana">
            <option value="Segunda-feira" data-i18n="optSeg">Segunda-feira</option>
            <option value="Terça-feira" data-i18n="optTer">Terça-feira</option>
            <option value="Quarta-feira" data-i18n="optQua">Quarta-feira</option>
            <option value="Quinta-feira" data-i18n="optQui">Quinta-feira</option>
            <option value="Sexta-feira" data-i18n="optSex">Sexta-feira</option>
            <option value="Sábado" data-i18n="optSab">Sábado</option>
            <option value="Domingo" data-i18n="optDom">Domingo</option>
            <option value="Diariamente" data-i18n="optDiario">Diariamente</option>
          </select>
        </div>

        <div class="form-group flex-1">
          <label data-i18n="lblDiaNumero">Dia do Mês (Nº):</label>
          <input type="number" id="admin-transp-dianumero" min="1" max="31" placeholder="Ex: 15">
        </div>
      </div>

      <div class="form-group">
        <label data-i18n="lblHorario">Horário:</label>
        <input type="text" id="admin-transp-horario" placeholder="Ex: 10:30">
      </div>

      <div class="form-group">
        <label data-i18n="lblAviso">Aviso / Observações (PT):</label>
        <textarea id="admin-transp-aviso" rows="2" placeholder="Ex: Rota alterada devido a obras na via."></textarea>
      </div>

      <div class="form-group">
        <label data-i18n="lblAvisoEn">Aviso / Observações (EN):</label>
        <textarea id="admin-transp-aviso-en" rows="2" placeholder="Ex: Route changed due to roadworks."></textarea>
      </div>

      <div class="form-group">
        <label data-i18n="lblAvisoJa">Aviso / Observações (JA):</label>
        <textarea id="admin-transp-aviso-ja" rows="2" placeholder="Ex: 道路工事のためルート変更。"></textarea>
      </div>

      <button onclick="salvarRota()" data-i18n="btnSalvar">Adicionar / Salvar</button>

      <hr style="margin: 20px 0; border: 0; border-top: 1px solid #eab308;">

      <h3 data-i18n="titleRotasCriadas">Minhas Rotas Cadastradas:</h3>
      <div id="lista-rotas-admin" class="lista-gerenciador"></div>
    </section>
  </div>

  <script src="funcionario.js"></script>
</body>
</html>
