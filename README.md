# 🚀 18 Days in Space

**An educational resource-management game for the NASA Space Apps Challenge 2026** 🌕

![Godot](https://img.shields.io/badge/Godot-4.x-blue?logo=godot-engine)
![NASA Space Apps 2026](https://img.shields.io/badge/NASA-Space%20Apps%202026-red?logo=nasa)
![Web Platform](https://img.shields.io/badge/Platform-Web-green?logo=html5)
![MIT License](https://img.shields.io/badge/License-MIT-yellow)

---

## 📖 About the Project

**18 Days in Space** is a *serious game* developed for the **NASA Space Apps Challenge 2026**, NASA's largest global hackathon. The project was created specifically for the **"Build a Junior Astronaut Mission Trainer"** challenge.

The game puts children aged **7 to 12** in the role of **Commander of a lunar outpost** that has suffered a catastrophe and lost contact with Earth. The rescue ship will take **18 days** to arrive (based on real NASA cargo mission trajectories). During this time, the player must manage scarce resources, make tough decisions, and keep the crew alive until rescue arrives.

## 🎯 The NASA Challenge

The challenge set by NASA calls for an interactive application that lets students manage a lunar or Martian outpost, balancing competing demands such as life support, radiation shielding, power, and food production. The goal is for young people to experience firsthand the decisions that determine the success or failure of a mission.

The game was also designed for the challenge's specific target audience: **children aged 7 to 12**, ensuring a simplified interface, accessible language, and intuitive mechanics.

## 🌟 Features

- 🔋 **Energy Management:** solar power is limited and varies every day. The player must distribute it among the vital systems.
- 💨 **Life Support:** monitor Oxygen and Food levels. Crew consumption is constant and based on real ISS data.
- 🛡️ **Radiation Shielding:** solar storm events can occur. The player must decide between diverting power to the shield or risking the crew's health.
- 🔬 **Scientific Research:** allocating energy to research is optional, but it earns points and unlocks real NASA images (Gallery).
- 🎲 **Random Events (Pity System):** unpredictable events (meteors, failures, supplies) force the player to make quick decisions. The chance of an event increases with each day without one, keeping the tension high.
- 🌍 **Localization (PT/EN):** the entire game, including event descriptions and the glossary, is available in Portuguese and English.
- 📚 **Gallery and Glossary:** a reward system that unlocks real NASA images and explains technical terms, with data persistence via IndexedDB (in the Web version).

## 🛠️ Tech Stack

| Item | Technology |
|---|---|
| **Engine** | Godot Engine 4.x |
| **Language** | GDScript |
| **Target Platform** | Web (HTML5), playable directly in the browser |
| **UI Design** | NEONIX UI asset pack (GONKEN Games) |
| **Architecture** | SOLID principles, Data-Driven pattern with custom Resources, and a signal system for decoupled communication |

## 📊 Use of Real NASA Data (Challenge Requirement)

One of the project's key strengths is its grounding in NASA open data to ensure scientific rigor, even if simplified for a young audience:

- **Game Length (18 Days):** based on "Fast Transit" trajectory studies for uncrewed cargo missions to the Lunar Gateway.
- **Oxygen Consumption and Recycling:** inspired by the **ECLSS** system of the International Space Station (ISS).
- **Radiation:** data from the **Curiosity** rover and NASA's **DONKI** (*Space Weather Database*) system to simulate solar storm risks.
- **Gallery Images:** all unlockable images are in the public domain, obtained from the [NASA Image and Video Library](https://images.nasa.gov/).

**Special Thanks:**

- NASA Space Apps Challenge 2026 for the initiative.
- The Godot Engine community for their support and tools.

## 🔗 Useful Links

- [NASA Challenge Page](https://www.spaceappschallenge.org/)
- [Godot Engine Documentation](https://docs.godotengine.org/)
- [NASA Open Data Portal](https://data.nasa.gov/)

---

<p align="center">Made with 💙 to inspire the next generation of space explorers. 🌌</p>
