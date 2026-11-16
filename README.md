# 🚀 18 Days in Space

**Jogo educativo de gestão de recursos para o NASA Space Apps Challenge 2026** 🌕

![Godot](https://img.shields.io/badge/Godot-4.x-blue?logo=godot-engine)
![NASA Space Apps 2026](https://img.shields.io/badge/NASA-Space%20Apps%202026-red?logo=nasa)
![Plataforma Web](https://img.shields.io/badge/Plataforma-Web-green?logo=html5)
![Licença MIT](https://img.shields.io/badge/Licen%C3%A7a-MIT-yellow)

---

## 📖 Sobre o Projeto

**18 Days in Space** é um *serious game* desenvolvido para o **NASA Space Apps Challenge 2026**, o maior hackathon global da NASA. O projeto foi criado especificamente para o desafio **"Build a Junior Astronaut Mission Trainer"**.

O jogo coloca crianças de **7 a 12 anos** no papel de **Comandante de um posto avançado lunar** que sofreu uma catástrofe e perdeu o contato com a Terra. A nave de resgate levará **18 dias** para chegar (baseado em trajetórias reais de missões de carga da NASA). Durante esse período, o jogador deve gerenciar recursos escassos, tomar decisões difíceis e manter a tripulação viva até a chegada do resgate.

## 🎯 O Desafio da NASA

O desafio proposto pela NASA pede uma aplicação interativa que permita aos estudantes gerenciar um posto avançado lunar ou marciano, equilibrando demandas concorrentes como suporte de vida, blindagem contra radiação, energia e produção de alimentos. A intenção é que os jovens experimentem em primeira mão as decisões que determinam o sucesso ou o fracasso de uma missão.

O jogo também foi projetado para atender ao público-alvo específico do desafio: **crianças de 7 a 12 anos**, garantindo uma interface simplificada, linguagem acessível e mecânicas intuitivas.

## 🌟 Funcionalidades

- 🔋 **Gestão de Energia:** a energia solar é limitada e variável a cada dia. O jogador deve distribuí-la entre os sistemas vitais.
- 💨 **Suporte de Vida:** monitore os níveis de Oxigênio e Comida. O consumo da tripulação é constante e baseado em dados reais da ISS.
- 🛡️ **Blindagem contra Radiação:** eventos de tempestade solar podem ocorrer. O jogador deve decidir entre desviar energia para o escudo ou arriscar a saúde da tripulação.
- 🔬 **Pesquisa Científica:** alocar energia para a pesquisa é opcional, mas rende pontos e desbloqueia imagens reais da NASA (Galeria).
- 🎲 **Eventos Aleatórios (Pity System):** eventos imprevisíveis (meteoros, falhas, suprimentos) forçam o jogador a tomar decisões rápidas. A chance de um evento aumenta a cada dia sem ocorrências, mantendo a tensão.
- 🌍 **Localização (PT/EN):** todo o jogo, incluindo descrições de eventos e glossário, está disponível em Português e Inglês.
- 📚 **Galeria e Glossário:** um sistema de recompensas que desbloqueia imagens reais da NASA e explica termos técnicos, com persistência de dados via IndexedDB (na versão Web).

## 🛠️ Stack Tecnológico

| Item | Tecnologia |
|---|---|
| **Engine** | Godot Engine 4.x |
| **Linguagem** | GDScript |
| **Plataforma Alvo** | Web (HTML5), acessível diretamente no navegador |
| **Design de UI** | Pack de assets NEONIX UI (GONKEN Games) |
| **Arquitetura** | Princípios SOLID, padrão Data-Driven com Resources customizados e sistema de sinais (*signals*) para comunicação desacoplada |

## 📊 Uso de Dados Reais da NASA (Requisito do Desafio)

Um dos diferenciais do projeto é a fundamentação em dados abertos da NASA para garantir o rigor científico, mesmo que de forma simplificada para o público infantil:

- **Tempo de Jogo (18 Dias):** baseado em estudos de trajetórias de *"Fast Transit"* para missões de carga não tripuladas ao Gateway Lunar.
- **Consumo de Oxigênio e Reciclagem:** inspirado no sistema **ECLSS** da Estação Espacial Internacional (ISS).
- **Radiação:** dados do rover **Curiosity** e do sistema **DONKI** (*Space Weather Database*) da NASA para simular riscos de tempestades solares.
- **Imagens da Galeria:** todas as imagens desbloqueáveis são de domínio público, obtidas do [NASA Image and Video Library](https://images.nasa.gov/).

**Agradecimentos Especiais:**

- NASA Space Apps Challenge 2026 pela iniciativa.
- Comunidade Godot Engine pelo suporte e ferramentas.

## 🔗 Links Úteis

- [Página do Desafio na NASA](https://www.spaceappschallenge.org/)
- [Documentação da Godot Engine](https://docs.godotengine.org/)
- [NASA Open Data Portal](https://data.nasa.gov/)

---

<p align="center">Feito com 💙 para inspirar a próxima geração de exploradores espaciais. 🌌</p>
