
const traducoes = {
  pt: {
    labelLang: "Idioma / Language:",
    titleLogin: "Acesso do Funcionário",
    lblEmail: "E-mail de Usuário:",
    lblSenha: "Senha:",
    btnEntrar: "Entrar / Cadastrar Senha",
    btnSair: "Sair 🚪",
    titleAdmin: "Painel do Funcionário",
    descAdmin: "Adicione ou atualize os dados do transporte abaixo:",
    lblNomeRua: "Nome da Rua / Ponto:",
    lblNomeTransp: "Nome do Transporte (PT):",
    lblNomeTranspEn: "Nome do Transporte (EN):",
    lblNomeTranspJa: "Nome do Transporte (JA):",
    lblDiaSemana: "Dia da Semana:",
    lblDiaNumero: "Dia do Mês (Nº):",
    optSeg: "Segunda-feira",
    optTer: "Terça-feira",
    optQua: "Quarta-feira",
    optQui: "Quinta-feira",
    optSex: "Sexta-feira",
    optSab: "Sábado",
    optDom: "Domingo",
    optDiario: "Diariamente",
    lblHorario: "Horário:",
    lblAviso: "Aviso / Observações (PT):",
    lblAvisoEn: "Aviso / Observações (EN):",
    lblAvisoJa: "Aviso / Observações (JA):",
    btnSalvar: "Adicionar / Salvar",
    titleRotasCriadas: "Minhas Rotas Cadastradas:",
    semRotas: "Nenhuma rota cadastrada no momento.",
    btnExcluir: "Excluir 🗑️",
    confirmExcluir: "Deseja excluir esta rota de ",
    prefixoDia: "Dia"
  },
  en: {
    labelLang: "Language / Idioma:",
    titleLogin: "Employee Access",
    lblEmail: "User Email:",
    lblSenha: "Password:",
    btnEntrar: "Login / Register Password",
    btnSair: "Exit 🚪",
    titleAdmin: "Employee Panel",
    descAdmin: "Add or update transit data below:",
    lblNomeRua: "Street Name / Stop:",
    lblNomeTransp: "Transit Line Name (PT):",
    lblNomeTranspEn: "Transit Line Name (EN):",
    lblNomeTranspJa: "Transit Line Name (JA):",
    lblDiaSemana: "Day of Week:",
    lblDiaNumero: "Day of Month (Nº):",
    optSeg: "Monday",
    optTer: "Tuesday",
    optQua: "Wednesday",
    optQui: "Thursday",
    optSex: "Friday",
    optSab: "Saturday",
    optDom: "Sunday",
    optDiario: "Daily",
    lblHorario: "Schedule:",
    lblAviso: "Notice / Service Changes (PT):",
    lblAvisoEn: "Notice / Service Changes (EN):",
    lblAvisoJa: "Notice / Service Changes (JA):",
    btnSalvar: "Add / Save",
    titleRotasCriadas: "My Registered Routes:",
    semRotas: "No routes registered at the moment.",
    btnExcluir: "Delete 🗑️",
    confirmExcluir: "Do you want to delete this route from ",
    prefixoDia: "Day"
  },
  ja: {
    labelLang: "言語 / Language:",
    titleLogin: "管理者ログイン",
    lblEmail: "ユーザーメールアドレス:",
    lblSenha: "パスワード:",
    btnEntrar: "ログイン / パスワード登録",
    btnSair: "ログアウト 🚪",
    titleAdmin: "管理者パネル",
    descAdmin: "以下で交通データを追加・更新してください:",
    lblNomeRua: "通り名 / バス停名:",
    lblNomeTransp: "路線名 (PT):",
    lblNomeTranspEn: "路線名 (EN):",
    lblNomeTranspJa: "路線名 (JA):",
    lblDiaSemana: "曜日:",
    lblDiaNumero: "日 (数字):",
    optSeg: "月曜日",
    optTer: "火曜日",
    optQua: "水曜日",
    optQui: "木曜日",
    optSex: "金曜日",
    optSab: "土曜日",
    optDom: "日曜日",
    optDiario: "毎日",
    lblHorario: "時刻:",
    lblAviso: "お知らせ / 変更事項 (PT):",
    lblAvisoEn: "お知らせ / 変更事項 (EN):",
    lblAvisoJa: "お知らせ / 変更事項 (JA):",
    btnSalvar: "追加 / 保存",
    titleRotasCriadas: "登録済みルート一覧:",
    semRotas: "現在登録されているルートはありません。",
    btnExcluir: "削除 🗑️",
    confirmExcluir: "このルートを削除しますか: ",
    prefixoDia: "日"
  }
};

const traducaoDias = {
  "Segunda-feira": { pt: "Segunda-feira", en: "Monday", ja: "月曜日" },
  "Terça-feira": { pt: "Terça-feira", en: "Tuesday", ja: "火曜日" },
  "Quarta-feira": { pt: "Quarta-feira", en: "Wednesday", ja: "水曜日" },
  "Quinta-feira": { pt: "Quinta-feira", en: "Thursday", ja: "木曜日" },
  "Sexta-feira": { pt: "Sexta-feira", en: "Friday", ja: "金曜日" },
  "Sábado": { pt: "Sábado", en: "Saturday", ja: "土曜日" },
  "Domingo": { pt: "Domingo", en: "Sunday", ja: "日曜日" },
  "Diariamente": { pt: "Diariamente", en: "Daily", ja: "毎日" }
};

let bancoDados = JSON.parse(localStorage.getItem('bancoTransportes')) || {};
let credenciaisFuncionario = JSON.parse(localStorage.getItem('credenciaisAdmin')) || null;

function mudarIdioma() {
  const lang = document.getElementById('select-lang').value;
  const textos = traducoes[lang];

  document.querySelectorAll('[data-i18n]').forEach(el => {
    const chave = el.getAttribute('data-i18n');
    if (textos[chave]) {
      if (el.tagName === 'OPTION') {
        el.textContent = textos[chave];
      } else {
        el.innerText = textos[chave];
      }
    }
  });

  renderizarMinhasRotas();
}

function autenticarFuncionario() {
  const email = document.getElementById('login-email').value.trim();
  const senha = document.getElementById('login-senha').value.trim();

  if (!email || !senha) {
    alert("Por favor, preencha o e-mail e a senha!");
    return;
  }

  if (!credenciaisFuncionario) {
    credenciaisFuncionario = { email, senha };
    localStorage.setItem('credenciaisAdmin', JSON.stringify(credenciaisFuncionario));
    alert("Conta criada e login efetuado com sucesso!");
  } else {
    if (credenciaisFuncionario.email !== email || credenciaisFuncionario.senha !== senha) {
      alert("E-mail ou senha incorretos!");
      return;
    }
  }

  document.getElementById('painel-login').classList.add('hidden');
  document.getElementById('painel-funcionario').classList.remove('hidden');
  renderizarMinhasRotas();
}

function deslogar() {
  document.getElementById('painel-funcionario').classList.add('hidden');
  document.getElementById('painel-login').classList.remove('hidden');
  document.getElementById('login-email').value = '';
  document.getElementById('login-senha').value = '';
}

function salvarRota() {
  const rua = document.getElementById('admin-rua').value.trim();
  const nomePt = document.getElementById('admin-transp-nome').value.trim();
  const nomeEn = document.getElementById('admin-transp-nome-en').value.trim();
  const nomeJa = document.getElementById('admin-transp-nome-ja').value.trim();
  const diaSemana = document.getElementById('admin-transp-diasemana').value;
  const diaNumero = document.getElementById('admin-transp-dianumero').value.trim();
  const horario = document.getElementById('admin-transp-horario').value.trim();
  const avisoPt = document.getElementById('admin-transp-aviso').value.trim();
  const avisoEn = document.getElementById('admin-transp-aviso-en').value.trim();
  const avisoJa = document.getElementById('admin-transp-aviso-ja').value.trim();

  if (!rua || !nomePt || !horario) {
    alert("Por favor, preencha a rua, nome e horário!");
    return;
  }

  if (!bancoDados[rua]) {
    bancoDados[rua] = [];
  }

  bancoDados[rua].push({ 
    nomePt: nomePt,
    nomeEn: nomeEn || nomePt,
    nomeJa: nomeJa || nomeEn || nomePt,
    diaSemana: diaSemana,
    diaNumero: diaNumero,
    horario: horario, 
    avisoPt: avisoPt,
    avisoEn: avisoEn || avisoPt,
    avisoJa: avisoJa || avisoEn || avisoPt
  });

  localStorage.setItem('bancoTransportes', JSON.stringify(bancoDados));
  alert("Dados salvos com sucesso!");

  document.getElementById('admin-rua').value = '';
  document.getElementById('admin-transp-nome').value = '';
  document.getElementById('admin-transp-nome-en').value = '';
  document.getElementById('admin-transp-nome-ja').value = '';
  document.getElementById('admin-transp-dianumero').value = '';
  document.getElementById('admin-transp-horario').value = '';
  document.getElementById('admin-transp-aviso').value = '';
  document.getElementById('admin-transp-aviso-en').value = '';
  document.getElementById('admin-transp-aviso-ja').value = '';

  renderizarMinhasRotas();
}

function obterTextoPorIdioma(item, propriedade, lang) {
  if (!item) return "";
  if (lang === 'ja') {
    return item[`${propriedade}Ja`] || item[`${propriedade}En`] || item[`${propriedade}Pt`] || item[propriedade];
  } else if (lang === 'en') {
    return item[`${propriedade}En`] || item[`${propriedade}Pt`] || item[propriedade];
  }
  return item[`${propriedade}Pt`] || item[propriedade];
}

function renderizarMinhasRotas() {
  const container = document.getElementById('lista-rotas-admin');
  if (!container) return;

  container.innerHTML = '';
  const lang = document.getElementById('select-lang').value;
  const textos = traducoes[lang];

  let possuiRotas = false;

  Object.keys(bancoDados).forEach(rua => {
    bancoDados[rua].forEach((item, index) => {
      possuiRotas = true;
      const diaTraduzido = traducaoDias[item.diaSemana] ? (traducaoDias[item.diaSemana][lang] || item.diaSemana) : item.diaSemana;
      const textoDiaNum = item.diaNumero ? `(${textos.prefixoDia} ${item.diaNumero})` : '';
      const nomeExibicao = obterTextoPorIdioma(item, 'nome', lang);

      const itemEl = document.createElement('div');
      itemEl.className = 'item-rota';
      itemEl.innerHTML = `
        <div class="item-info">
          <strong>📍 ${rua} - ${nomeExibicao}</strong>
          <span>📅 ${diaTraduzido} ${textoDiaNum} | ⏱️ ${item.horario}</span>
        </div>
        <button class="btn-excluir" onclick="excluirRota('${rua}', ${index})">${textos.btnExcluir}</button>
      `;
      container.appendChild(itemEl);
    });
  });

  if (!possuiRotas) {
    container.innerHTML = `<p class="desc-text">${textos.semRotas}</p>`;
  }
}

function excluirRota(rua, index) {
  const lang = document.getElementById('select-lang').value;
  const textos = traducoes[lang];

  if (confirm(`${textos.confirmExcluir} ${rua}?`)) {
    bancoDados[rua].splice(index, 1);
    
    if (bancoDados[rua].length === 0) {
      delete bancoDados[rua];
    }

    localStorage.setItem('bancoTransportes', JSON.stringify(bancoDados));
    renderizarMinhasRotas();
  }
}
