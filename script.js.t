const traducoes = {
  pt: {
    labelLang: "Idioma / Language:",
    titleTurista: "Painel do Turista",
    btnGps: "📍 Ativar Localização Real",
    statusGpsOff: "Localização desativada.",
    lblEscolhaDestino: "Selecione para onde quer ir:",
    optSelecione: "-- Escolha um destino --",
    btnTextoInformacao: "ℹ️ Informações e Avisos de Mudanças",
    titleOpcoes: "Opções Disponíveis:",
    titleAvisos: "⚠️ Informações Importantes:",
    semAviso: "Nenhum aviso ou mudança cadastrada para esta rota.",
    prefixoDia: "Dia",
    lblTransp1: "Transporte 1",
    lblTransp2: "Transporte 2"
  },
  en: {
    labelLang: "Language / Idioma:",
    titleTurista: "Tourist Panel",
    btnGps: "📍 Enable Live Location",
    statusGpsOff: "Location disabled.",
    lblEscolhaDestino: "Select your destination:",
    optSelecione: "-- Choose a destination --",
    btnTextoInformacao: "ℹ️ Information & Service Notices",
    titleOpcoes: "Available Options:",
    titleAvisos: "⚠️ Important Information:",
    semAviso: "No service updates or notices for this route.",
    prefixoDia: "Day",
    lblTransp1: "Transit Option 1",
    lblTransp2: "Transit Option 2"
  },
  ja: {
    labelLang: "言語 / Language:",
    titleTurista: "観光客パネル",
    btnGps: "📍 現在地を取得",
    statusGpsOff: "位置情報がオフになっています。",
    lblEscolhaDestino: "目的地を選択してください:",
    optSelecione: "-- 目的地を選択 --",
    btnTextoInformacao: "ℹ️ 運行情報・お知らせ",
    titleOpcoes: "利用可能な交通機関:",
    titleAvisos: "⚠️ 重要なお知らせ:",
    semAviso: "このルートに関するお知らせはありません。",
    prefixoDia: "日",
    lblTransp1: "交通手段 1",
    lblTransp2: "交通手段 2"
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

let bancoDados = JSON.parse(localStorage.getItem('bancoTransportes')) || {
  "Av. Central": [
    { 
      nomePt: "Ônibus Linha 101",
      nomeEn: "Bus Line 101",
      nomeJa: "101号線バス",
      diaSemana: "Segunda-feira", 
      diaNumero: "15", 
      horario: "10:15", 
      avisoPt: "Rota com atraso de 5 min devido a obras na via.",
      avisoEn: "Route delayed by 5 min due to roadworks.",
      avisoJa: "道路工事のため5分程度の遅延が発生しています。"
    }
  ]
};

document.addEventListener('DOMContentLoaded', () => {
  atualizarSelectDestinos();
});

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

  atualizarSelectDestinos();
  exibirOpcoesTransporte();
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

function atualizarSelectDestinos() {
  const select = document.getElementById('select-destino');
  if (!select) return;

  const valorAtual = select.value;
  select.innerHTML = `<option value="" data-i18n="optSelecione">-- Escolha um destino --</option>`;

  Object.keys(bancoDados).forEach(rua => {
    const opt = document.createElement('option');
    opt.value = rua;
    opt.textContent = rua;
    select.appendChild(opt);
  });

  select.value = valorAtual;

  const lang = document.getElementById('select-lang').value;
  const textos = traducoes[lang];
  select.options[0].textContent = textos.optSelecione;
}

function formatarTextoData(item, lang) {
  if (!item) return "📅 --";
  const textos = traducoes[lang];
  const diaTraduzido = traducaoDias[item.diaSemana] ? (traducaoDias[item.diaSemana][lang] || item.diaSemana) : item.diaSemana;
  
  let texto = `📅 ${diaTraduzido}`;
  if (item.diaNumero) texto += ` (${textos.prefixoDia} ${item.diaNumero})`;
  return texto;
}

function exibirOpcoesTransporte() {
  const destino = document.getElementById('select-destino').value;
  const painelResultado = document.getElementById('resultado-turista');

  if (!destino || !bancoDados[destino]) {
    painelResultado.classList.add('hidden');
    return;
  }

  const lista = bancoDados[destino];
  const lang = document.getElementById('select-lang').value;
  let avisosUnificados = [];

  // Transporte 1
  if (lista[0]) {
    const nome1 = obterTextoPorIdioma(lista[0], 'nome', lang);
    const aviso1 = obterTextoPorIdioma(lista[0], 'aviso', lang);

    document.getElementById('res-t1-nome').textContent = nome1;
    document.getElementById('res-t1-data').textContent = formatarTextoData(lista[0], lang);
    document.getElementById('res-t1-horario').textContent = `⏱️ ${lista[0].horario}`;
    if (aviso1) avisosUnificados.push(`• ${nome1}: ${aviso1}`);
  } else {
    document.getElementById('res-t1-nome').textContent = "---";
    document.getElementById('res-t1-data').textContent = "📅 --";
    document.getElementById('res-t1-horario').textContent = "⏱️ --:--";
  }

  // Transporte 2
  if (lista[1]) {
    const nome2 = obterTextoPorIdioma(lista[1], 'nome', lang);
    const aviso2 = obterTextoPorIdioma(lista[1], 'aviso', lang);

    document.getElementById('res-t2-nome').textContent = nome2;
    document.getElementById('res-t2-data').textContent = formatarTextoData(lista[1], lang);
    document.getElementById('res-t2-horario').textContent = `⏱️ ${lista[1].horario}`;
    if (aviso2) avisosUnificados.push(`• ${nome2}: ${aviso2}`);
  } else {
    document.getElementById('res-t2-nome').textContent = "---";
    document.getElementById('res-t2-data').textContent = "📅 --";
    document.getElementById('res-t2-horario').textContent = "⏱️ --:--";
  }

  const textoAvisoEl = document.getElementById('texto-aviso-exibido');
  if (avisosUnificados.length > 0) {
    textoAvisoEl.innerHTML = avisosUnificados.join('<br><br>');
  } else {
    textoAvisoEl.textContent = traducoes[lang].semAviso;
  }

  painelResultado.classList.remove('hidden');
}

function alternarAvisos() {
  const caixaAvisos = document.getElementById('caixa-avisos');
  caixaAvisos.classList.toggle('hidden');
}

function obterLocalizacao() {
  const statusGps = document.getElementById('status-gps');

  if (!navigator.geolocation) {
    statusGps.textContent = "Geolocalização não suportada.";
    return;
  }

  statusGps.textContent = "Buscando localização...";

  navigator.geolocation.getCurrentPosition(
    (posiz) => {
      const lat = posiz.coords.latitude.toFixed(4);
      const lng = posiz.coords.longitude.toFixed(4);
      statusGps.textContent = `📍 Localização Ativa (${lat}, ${lng})`;
      statusGps.style.color = "#ca8a04";
    },
    () => {
      statusGps.textContent = "Permissão negada ou indisponível.";
      statusGps.style.color = "#ef4444";
    }
  );
}
